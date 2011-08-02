//
//  PopoverViewController.m
//  ShipIt
//
//  Created by Zachry Thayer on 8/1/11.
//  Copyright 2011 Penguins With Mustaches. All rights reserved.
//

#import "PopoverViewController.h"

#import <Quartz/Quartz.h>

@implementation PopoverViewController

@synthesize popover = _popover;
@synthesize mainView = _mainView;
@synthesize prefView = _prefView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)awakeFromNib{
    
    [self.view addSubview:_mainView];
    
    NSRect bounds = [_mainView bounds];
    NSSize newSize = bounds.size;
    
    [_popover setContentSize:newSize];
    
}

- (IBAction)showPrefs:(id)sender{
    
    NSRect bounds = [_prefView bounds];
    NSSize newSize = bounds.size;
    
    [_popover setContentSize:newSize];
    
    [_mainView removeFromSuperview];
    [self.view addSubview:_prefView];
        
}

- (IBAction)showMain:(id)sender{
    
    NSRect bounds = [_mainView bounds];
    NSSize newSize = bounds.size;
    
    [_popover setContentSize:newSize];
    
    [_prefView removeFromSuperview];
    [self.view addSubview:_mainView];
    
}

@end
