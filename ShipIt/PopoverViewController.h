//
//  PopoverViewController.h
//  ShipIt
//
//  Created by Zachry Thayer on 8/1/11.
//  Copyright 2011 Penguins With Mustaches. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PopoverViewController : NSViewController
{
    
    NSPopover *_popover;
    
    NSView *_mainView;
    NSView *_prefView;
    
}

@property (assign) IBOutlet NSPopover *popover;

@property (assign) IBOutlet NSView *mainView;
@property (assign) IBOutlet NSView *prefView;


- (IBAction)showPrefs:(id)sender;
- (IBAction)showMain:(id)sender;

@end
