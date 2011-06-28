#import <Cocoa/Cocoa.h>
#import "SIStatusItemView.h"
#import "PluginController.h"
#import "HotKey/PTHotKey.h"

@interface ShipItController : NSObject {
    @private
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    SIStatusItemView *statusItemView;
    NSMutableArray *packageQueue;
    PluginController *pluginController;
    
}

- (IBAction)packageAndShare: (id)sender;
- (void)createAndEnqueuePackageWithFinderSelection: (PTHotKey *)hotKey;
- (void)updateHotKey;
@end

@interface ShipItController (Private)
    //- (void)registerGlobalHotKey;

@end
