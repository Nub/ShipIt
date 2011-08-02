#import "ShipItController.h"
#import "Finder.h"
#import <Carbon/Carbon.h>
#import "HotKey/PTHotKeyCenter.h"


@implementation ShipItController

- (ShipItController *)init 
{
    self = [super init];
    if (self) {
        [NSApp setDelegate: self];
    }
    return self;
}

- (void)awakeFromNib 
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults boolForKey:@"showInDock"]) {
        ProcessSerialNumber psn = { 0, kCurrentProcess };
        // display dock icon
        TransformProcessType(&psn, kProcessTransformToForegroundApplication);
        // enable menu bar
        SetSystemUIMode(kUIModeNormal, 0);
        // switch to Dock.app
        [[NSWorkspace sharedWorkspace] launchAppWithBundleIdentifier:@"com.apple.dock" options:NSWorkspaceLaunchDefault additionalEventParamDescriptor:nil launchIdentifier:nil];
        // switch back
        [[NSApplication sharedApplication] activateIgnoringOtherApps:TRUE];
    }
    
	[self updateHotKey];
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:STATUS_ITEM_VIEW_WIDTH] retain];

    statusItemView = [[SIStatusItemView alloc] initWithStatusItem:statusItem];
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shipIt_icon" ofType:@"png"]];
    NSImage *alternate = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shipIt_icon" ofType:@"png"]];
    [statusItemView setImage:image];
    [statusItemView setAlternateImage:alternate];
	[statusItemView setMenu: statusMenu];
    [statusItemView setPopover:popover];
    
    [image release];
    [alternate release];
    
	[statusItem setView: statusItemView];	
	[statusItem	setHighlightMode: YES];
	[statusItem setEnabled: YES];
}

- (void)dealloc 
{
    [statusItemView release];
	[statusItem release];
	[super dealloc];
}

- (IBAction)packageAndShare:(id)sender 
{
	[self createPackageFromFinderSelection];
}


- (void)createPackageFromFinderSelection
{
   
}

#pragma mark Drag Operations

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    return NSDragOperationCopy;
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender
{
    return NSDragOperationCopy;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
    
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{

}

- (void)concludeDragOperation:(id<NSDraggingInfo>)sender {
}

#pragma mark HotKey Messages

- (void)performHotKeySelector:(PTHotKey *)hotKey
{
	[self createPackageFromFinderSelection];
} 

- (void)updateHotKey
{
	PTHotKeyCenter *hotKeyCenter = [PTHotKeyCenter sharedCenter];
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
    id keyComboPlist = [userDefaults objectForKey: @"GlobalHotKey"];
    if (keyComboPlist) {
        PTKeyCombo *keyCombo = [[[PTKeyCombo alloc] initWithPlistRepresentation:keyComboPlist] autorelease];
        PTHotKey *hotKey = [[[PTHotKey alloc] initWithIdentifier:@"GlobalHotKey" keyCombo:keyCombo] autorelease];
        [hotKey setTarget:self];
        [hotKey setAction:@selector(performHotKeySelector:)];
        [hotKeyCenter registerHotKey:hotKey];
    }
}

@end
