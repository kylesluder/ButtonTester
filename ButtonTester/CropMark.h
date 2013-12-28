//
//  CropMark.h
//  ButtonTester
//
//  Created by Kyle Sluder on 11/14/13.
//  Copyright (c) 2013 Kyle Sluder. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString *const NorthwestCropMark; // "nw"
extern NSString *const NortheastCropMark; // "ne"
extern NSString *const SouthwestCropMark; // "sw"
extern NSString *const SoutheastCropMark; // "se"

@interface CropMark : NSView

@property (copy) NSString *compassPoint;

@end
