//
//  CropMark.m
//  ButtonTester
//
//  Created by Kyle Sluder on 11/14/13.
//  Copyright (c) 2013 Kyle Sluder. All rights reserved.
//

#import "CropMark.h"

NSString *const NorthwestCropMark = @"nw";
NSString *const NortheastCropMark = @"ne";
NSString *const SouthwestCropMark = @"sw";
NSString *const SoutheastCropMark = @"se";

@implementation CropMark

@synthesize compassPoint=_compassPoint;

- (NSString *)compassPoint;
{
    return _compassPoint;
}

- (void)setCompassPoint:(NSString *)compassPoint;
{
    _compassPoint = [compassPoint copy];
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect;
{
    [[[NSColor redColor] colorWithAlphaComponent:0.5f] setFill];
    
    NSRectEdge horizEdge;
    
    if ([_compassPoint isEqualToString:NorthwestCropMark]
        || [_compassPoint isEqualToString:NortheastCropMark]) {
        horizEdge = [self isFlipped] ? NSMaxYEdge : NSMinYEdge;
    } else {
        horizEdge = [self isFlipped] ? NSMinYEdge : NSMaxYEdge;
    }
    
    NSRect horizRect;
    NSDivideRect(self.bounds, &horizRect, &(NSRect){}, 1.0f, horizEdge);
    NSRectFillUsingOperation(horizRect, NSCompositeSourceOver);
    
    NSRectEdge vertEdge;
    
    if ([_compassPoint isEqualToString:NortheastCropMark]
        || [_compassPoint isEqualToString:SoutheastCropMark]) {
        vertEdge = NSMinXEdge;
    } else {
        vertEdge = NSMaxXEdge;
    }
    
    NSRect vertRect;
    NSDivideRect(self.bounds, &vertRect, &(NSRect){}, 1.0f, vertEdge);
    NSRectFillUsingOperation(vertRect, NSCompositeSourceOver);
}

@end
