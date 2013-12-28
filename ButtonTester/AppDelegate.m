//
//  AppDelegate.m
//  ButtonTester
//
//  Created by Kyle Sluder on 11/13/13.
//  Copyright (c) 2013 Kyle Sluder. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self _updateUI];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender;
{
    return YES;
}

- (void)buttonAction:(id)sender;
{
    [self _updateUI];
}

- (void)_updateUI;
{
    for (NSTextField *textField in @[_titleTextField, _alternateTitleTextField]) {
        NSString *stringValue = [self.button.cell valueForKey:textField.identifier];
        textField.stringValue = stringValue;
        
        if (stringValue)
            ((NSTextFieldCell *)textField.cell).placeholderString = nil;
        else
            ((NSTextFieldCell *)textField.cell).placeholderString = @"(null)";
    }
    
    for (NSPopUpButton *popUpButton in @[_controlSizePopUpButton, _backgroundStylePopUpButton, _bezelStylePopUpButton, _statePopUpButton])
        [popUpButton selectItemWithTag:[[self.button.cell valueForKey:popUpButton.identifier] integerValue]];
    
    [_borderedCheckbox setState:[[self.button.cell valueForKey:_borderedCheckbox.identifier] boolValue] ? NSOnState : NSOffState];
    
    for (NSMatrix *matrix in @[_highlightsByMatrix, _showsStateByMatrix]) {
        [matrix deselectAllCells];
        
        NSUInteger value = [[self.button.cell valueForKey:matrix.identifier] unsignedIntegerValue];
        [[matrix cellWithTag:NSContentsCellMask] setState:(value & NSContentsCellMask) ? NSOnState : NSOffState];
        [[matrix cellWithTag:NSPushInCellMask] setState:(value & NSPushInCellMask) ? NSOnState : NSOffState];
        [[matrix cellWithTag:NSChangeGrayCellMask] setState:(value & NSChangeGrayCellMask) ? NSOnState : NSOffState];
        [[matrix cellWithTag:NSChangeBackgroundCellMask] setState:(value & NSChangeBackgroundCellMask) ? NSOnState : NSOffState];
    }
    
    NSImage *image = [self.button.cell image];
    _imageWell.image = image;
    _imageIsTemplateCheckbox.state = image.isTemplate ? NSOnState : NSOffState;
    
    NSImage *alternateImage = [self.button.cell alternateImage];
    _alternateImageWell.image = image;
    _alternateImageIsTemplateCheckbox.state = alternateImage.isTemplate ? NSOnState : NSOffState;
}

- (void)menuNeedsUpdate:(NSMenu *)menu;
{
    for (NSMenuItem *menuItem in menu.itemArray) {
        CGFloat fontSize = [NSFont systemFontSizeForControlSize:[self.button.cell font].pointSize];
        if ((menuItem.tag & NSBoldFontMask))
            menuItem.state = [[self.button.cell font] isEqual:[NSFont systemFontOfSize:fontSize]] ? NSOnState : NSOffState;
        else if ((menuItem.tag & NSUnboldFontMask))
            menuItem.state = [[self.button.cell font] isEqual:[NSFont systemFontOfSize:fontSize]] ? NSOnState : NSOffState;
    }
}

- (void)applyTextFieldValueToCell:(id)sender;
{
    NSTextField *textField = (NSTextField *)sender;
    [self.button.cell setValue:textField.stringValue forKey:textField.identifier];
    [self _updateUI];
}

- (void)clearTextFieldValueForCell:(id)sender;
{
    NSButton *button = (NSButton *)sender;
    [self.button.cell setValue:nil forKey:button.identifier];
    [self _updateUI];
}

- (void)applyPopUpValueToCell:(id)sender;
{
    NSPopUpButton *popUpButton = (NSPopUpButton *)sender;
    [self.button.cell setValue:@(popUpButton.selectedTag) forKey:popUpButton.identifier];
    [self _updateUI];
}

- (void)applyFontFromPopUpToCell:(id)sender;
{
    NSPopUpButton *popUpButton = (NSPopUpButton *)sender;
    CGFloat fontSize = [NSFont systemFontSizeForControlSize:[self.button.cell controlSize]];
    [self.button.cell setFont:(popUpButton.selectedTag & NSBoldFontMask) ? [NSFont boldSystemFontOfSize:fontSize] : [NSFont systemFontOfSize:fontSize]];
    [self _updateUI];
}

- (IBAction)applyCheckboxStateToCell:(id)sender;
{
    NSButton *checkbox = (NSButton *)sender;
    [self.button.cell setValue:@(checkbox.state == NSOnState) forKey:checkbox.identifier];
    [self _updateUI];
}

- (void)applyHighlightToButton:(id)sender;
{
    NSButton *button = (NSButton *)sender;
    [self.button highlight:button.tag];
    [self _updateUI];
}

- (void)applyMatrixValueToCell:(id)sender;
{
    NSMatrix *matrix = (NSMatrix *)sender;
    NSUInteger value = 0;
    
    if ([[matrix cellWithTag:NSContentsCellMask] state] == NSOnState)
        value |= NSContentsCellMask;
    
    if ([[matrix cellWithTag:NSPushInCellMask] state] == NSOnState)
        value |= NSPushInCellMask;
    
    if ([[matrix cellWithTag:NSChangeGrayCellMask] state] == NSOnState)
        value |= NSChangeGrayCellMask;
    
    if ([[matrix cellWithTag:NSChangeBackgroundCellMask] state] == NSOnState)
        value |= NSChangeBackgroundCellMask;
    
    [self.button.cell setValue:@(value) forKey:matrix.identifier];
    [self _updateUI];
}

- (void)applyImageToCell:(id)sender;
{
    NSImageView *imageView = (NSImageView *)sender;
    [self.button.cell setValue:imageView.image forKey:imageView.identifier];
    [self _updateUI];
}

- (void)chooseImage:(id)sender;
{
    NSButton *chooseButton = (NSButton *)sender;
    
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.allowedFileTypes = @[@"public.image"];
    openPanel.allowsMultipleSelection = NO;
    [openPanel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            [self.button.cell setValue:[[NSImage alloc] initWithContentsOfURL:openPanel.URL] forKey:chooseButton.identifier];
            [self _updateUI];
        }
    }];
}

- (void)applyTemplateCheckboxToImage:(id)sender;
{
    NSButton *checkbox = (NSButton *)sender;
    NSImage *image = [self.button.cell valueForKey:checkbox.identifier];
    [image setTemplate:checkbox.state == NSOnState ? YES : NO];
    [self _updateUI];
}

@end
