#import <Cocoa/Cocoa.h>
#import "SIStatusItemView.h"
#import "PluginController.h"
#import "HotKey/PTHotKey.h"
#import "SIPackage.h"

#define STATUS_ITEM_VIEW_WIDTH 24.0

@interface ShipItController : NSObject {
    @private
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    SIStatusItemView *statusItemView;
    PluginController *pluginController;
    
    IBOutlet NSMenuItem *viewMenu;
    
    
    IBOutlet NSView *noFileSelected;
    IBOutlet NSView *fileSelected;
    IBOutlet NSTextField *packageName;
    IBOutlet NSTextField *packagePath;
    IBOutlet NSImageView *packageIcon;
    IBOutlet NSButton *packageButton;
}

- (void)shipPackage:(SIPackage *)package;
- (IBAction)packageAndShare: (id)sender;
- (void)createPackageFromFinderSelection;
- (void)performHotKeySelector: (PTHotKey *)hotKey;
- (void)updateHotKey;
@end
