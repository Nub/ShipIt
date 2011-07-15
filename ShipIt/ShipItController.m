#import "ShipItController.h"
#import "Finder.h"
#import "SIPackage.h"
#import <Carbon/Carbon.h>
#import "HotKey/PTHotKeyCenter.h"
#import "SIShippingHelper.h"


@implementation ShipItController

- (ShipItController *)init 
{
    self = [super init];
    if (self) {
        pluginController = [PluginController sharedInstance];
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

- (void)shipPackage:(SIPackage *)package
{
    NSSet *destinations = [pluginController destinations];
    id packaging = [pluginController packaging];
    if ([destinations count] > 0 && package) {
        [package setDestinations:destinations];
        [package setPackaging:packaging];
        SIShippingHelper *helper = [SIShippingHelper helper];
        [NSThread detachNewThreadSelector:@selector(shipPackage:) toTarget:helper withObject:package];
    } else {
        NSLog(@"Error - Missing destinations or packaging");
    }
}

- (void)createPackageFromFinderSelection
{
    FinderApplication *finder = [SBApplication applicationWithBundleIdentifier:@"com.apple.finder"];
	SBElementArray *selection = [[finder selection] get];
	
	NSArray *items = [selection arrayByApplyingSelector:@selector(URL)];
    SIPackage *package = [SIPackage package];
	for (NSString *item in items) {
        [package addURL:[NSURL URLWithString:item]];
	}
    [self shipPackage:package];
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
    NSPasteboard *paste = [sender draggingPasteboard];
    NSString *desiredType = [paste availableTypeFromArray:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
    if([desiredType isEqualToString:NSFilenamesPboardType]) {
        [viewMenu setView:fileSelected];
        NSArray *items = [paste propertyListForType:@"NSFilenamesPboardType"];
        SIPackage *package = [SIPackage package];
        for (id item in items) {
            NSString *path = (NSString *)item;
            [package addURL:[NSURL URLWithString:path]];
            [packagePath setStringValue:path];
            [packageName setStringValue:[[path lastPathComponent] stringByDeletingPathExtension]];
            [packageIcon setImage:[[NSWorkspace sharedWorkspace] iconForFile:path]];
            [packageButton setEnabled:YES];
            NSLog(@"Adding URL to package: %@", path);
        }
        [self shipPackage:package];
        [package release];
    }
    return YES;
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
