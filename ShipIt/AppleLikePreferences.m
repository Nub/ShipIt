//
//  AppleLikePreferences.m
//  ShipIt
//
//  Created by MrAsterisco on 21/06/11.
//  Copyright 2011 Codez4Mac. All rights reserved.
//

#import "AppleLikePreferences.h"
#import "HotKey/PTHotKey.h"
#import "ShipItController.h"

#define WINDOW_TOOLBAR_HEIGHT 78

@implementation AppleLikePreferences

- (id)init
{
    self = [super init];
    if (self) {
        launchAtLogin = [[LaunchAtLoginController alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}


- (IBAction)toggleDockIcon:(NSButton *)checkbox {
    
}

- (IBAction)toggleLaunchAtLogin:(NSButton *)checkbox{
    
    if([checkbox state] == NSOnState)
        [launchAtLogin setLaunchAtLogin:YES];
    else
        [launchAtLogin setLaunchAtLogin:NO];
    
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"Unrecognized Selector: %@", NSStringFromSelector(aSelector));
}

#pragma mark shortcutRecorder Delegate

- (BOOL)shortcutRecorder:(SRRecorderControl *)aRecorder isKeyCode:(NSInteger)keyCode andFlagsTaken:(NSUInteger)flags reason:(NSString **)aReason {
	return NO;
}

- (void)shortcutRecorder:(SRRecorderControl *)aRecorder keyComboDidChange:(KeyCombo)newKeyCombo {
    signed short code = newKeyCombo.code;
	unsigned int flags = [aRecorder cocoaToCarbonFlags:newKeyCombo.flags];
	PTKeyCombo *keyCombo = [[[PTKeyCombo alloc] initWithKeyCode:code modifiers:flags] autorelease];
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[keyCombo plistRepresentation] forKey:@"GlobalHotKey"];
	[userDefaults synchronize];
    
    [(ShipItController *)[NSApp delegate] updateHotKey];
}

@end
