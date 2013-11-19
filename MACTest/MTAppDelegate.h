//
//  MTAppDelegate.h
//  MACTest
//
//  Created by luozhen on 13-10-21.
//  Copyright (c) 2013年 luozhen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MTAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet NSButton *btnSwich;
@property (weak) IBOutlet NSSlider *slider;
@property (weak) IBOutlet NSTextField *lbValue;

- (IBAction)valueChange:(id)sender;

- (IBAction)btnOutputClicked:(id)sender;

- (void)resizeAndSaveImageWithPath:(NSString*)path;
- (NSImage *)imageResize:(NSImage*)anImage newSize:(NSSize)newSize;
- (BOOL)saveImage:(NSImage*)image withPath:(NSString*)path;

@end
