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

    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (IBAction)showGeneral:(id)sender {
    NSView *view = nil;
	view = generalView;
	
	NSRect windowFrame = [prefWindow frame];
	windowFrame.size.height = [view frame].size.height + WINDOW_TOOLBAR_HEIGHT;
	windowFrame.size.width = [view frame].size.width;
	windowFrame.origin.y = NSMaxY([prefWindow frame]) - ([view frame].size.height + WINDOW_TOOLBAR_HEIGHT);
	
	if ([[contentView subviews] count] != 0)
	{
		[[[contentView subviews] objectAtIndex:0] removeFromSuperview];
	}
	
	[prefWindow setFrame:windowFrame display:YES animate:YES];
	[contentView setFrame:[view frame]];
	[contentView addSubview:view];
	[prefWindow setTitle:NSLocalizedString(@"General", @"General preference pane title")];
	[myToolbar setSelectedItemIdentifier:@"General"];
    
    [shortcutRecorder setCanCaptureGlobalHotKeys: YES];
    [shortcutRecorder setAllowedFlags: NSCommandKeyMask|NSAlternateKeyMask|NSControlKeyMask|NSShiftKeyMask];
    id keyComboPlist = [[NSUserDefaults standardUserDefaults] objectForKey: @"GlobalHotKey"];
    if (keyComboPlist) {
        KeyCombo keyCombo;
        PTKeyCombo *keyComboObject = [[[PTKeyCombo alloc] initWithPlistRepresentation:keyComboPlist] autorelease];
        keyCombo.code = [keyComboObject keyCode];
        keyCombo.flags = [shortcutRecorder carbonToCocoaFlags:[keyComboObject modifiers]];
        [shortcutRecorder setKeyCombo:keyCombo];
    } else {
        [shortcutRecorder setKeyCombo:SRMakeKeyCombo(ShortcutRecorderEmptyCode, ShortcutRecorderEmptyFlags)];
    }
    
}

- (IBAction)showPlugins:(id)sender {
    NSView *view = nil;
	view = pluginsView;
	
	NSRect windowFrame = [prefWindow frame];
	windowFrame.size.height = [view frame].size.height + WINDOW_TOOLBAR_HEIGHT;
	windowFrame.size.width = [view frame].size.width;
	windowFrame.origin.y = NSMaxY([prefWindow frame]) - ([view frame].size.height + WINDOW_TOOLBAR_HEIGHT);
	
	if ([[contentView subviews] count] != 0)
	{
		[[[contentView subviews] objectAtIndex:0] removeFromSuperview];
	}
	
	[prefWindow setFrame:windowFrame display:YES animate:YES];
	[contentView setFrame:[view frame]];
	[contentView addSubview:view];
	[prefWindow setTitle:NSLocalizedString(@"Plugins", @"Plugins preference pane title")];
	[myToolbar setSelectedItemIdentifier:@"Plugins"];
}

- (IBAction)toggleDockIcon:(id)sender {
    NSAlert *myAlert = [[NSAlert alloc] init];
    [myAlert setMessageText:NSLocalizedString(@"Restart ShipIt! to apply changes", @"Toggle Dock Icon alert - Message Text")];
    [myAlert setInformativeText:NSLocalizedString(@"To show or hide the Dock icon you need to restart the application.", @"Toggle Dock Icon alert - Informative Text")];
    [myAlert beginSheetModalForWindow:prefWindow modalDelegate:nil didEndSelector:nil contextInfo:nil];
    [myAlert release];
}

- (IBAction)showPrefWindow:(id)sender {
    [self showGeneral:self];
    [prefWindow makeKeyAndOrderFront:self];
    [NSApp activateIgnoringOtherApps:YES];
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
