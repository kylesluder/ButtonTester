//
//  AppDelegate.h
//  ButtonTester
//
//  Created by Kyle Sluder on 11/13/13.
//  Copyright (c) 2013 Kyle Sluder. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate>

@property IBOutlet NSButton *button;
- (IBAction)buttonAction:(id)sender;

@property IBOutlet NSTextField *titleTextField;
@property IBOutlet NSTextField *alternateTitleTextField;
@property IBOutlet NSPopUpButton *controlSizePopUpButton;
@property IBOutlet NSPopUpButton *fontPopUpButton;
@property IBOutlet NSPopUpButton *backgroundStylePopUpButton;
@property IBOutlet NSPopUpButton *buttonTypePopUpButton;
@property IBOutlet NSPopUpButton *bezelStylePopUpButton;
@property IBOutlet NSButton *borderedCheckbox;
@property IBOutlet NSPopUpButton *statePopUpButton;
@property IBOutlet NSMatrix *highlightsByMatrix;
@property IBOutlet NSMatrix *showsStateByMatrix;
@property IBOutlet NSImageView *imageWell;
@property IBOutlet NSButton *imageIsTemplateCheckbox;
@property IBOutlet NSImageView *alternateImageWell;
@property IBOutlet NSButton *alternateImageIsTemplateCheckbox;

- (IBAction)applyTextFieldValueToCell:(id)sender;
- (IBAction)clearTextFieldValueForCell:(id)sender;
- (IBAction)applyPopUpValueToCell:(id)sender;
- (IBAction)applyFontFromPopUpToCell:(id)sender;
- (IBAction)applyCheckboxStateToCell:(id)sender;
- (IBAction)applyHighlightToButton:(id)sender;
- (IBAction)applyMatrixValueToCell:(id)sender;
- (IBAction)applyImageToCell:(id)sender;
- (IBAction)chooseImage:(id)sender;
- (IBAction)applyTemplateCheckboxToImage:(id)sender;

@end
