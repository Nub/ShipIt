#import <Cocoa/Cocoa.h>
#import "SIStatusItemView.h"
#import "PluginController.h"

@interface ShipItController : NSObject {
    @private
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    SIStatusItemView *statusItemView;
    NSMutableArray *packageQueue;
    PluginController *pluginController;
    
    IBOutlet NSMenuItem *viewMenu;
    
    
    IBOutlet NSView *noFileSelected;
    IBOutlet NSView *fileSelected;
    IBOutlet NSTextField *packageName;
    IBOutlet NSTextField *packagePath;
    IBOutlet NSImageView *packageIcon;
    IBOutlet NSButton *packageButton;
}

- (IBAction)packageAndShare: (id) sender;
- (void)createAndEnqueuePackageWithFinderSelection;

@end

@interface ShipItController (Private)
- (void)registerGlobalHotKey;
@end
