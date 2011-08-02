#import <Cocoa/Cocoa.h>
#import "SIStatusItemView.h"
#import "HotKey/PTHotKey.h"

#define STATUS_ITEM_VIEW_WIDTH 24.0

@interface ShipItController : NSObject {
    @private
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    SIStatusItemView *statusItemView;
    
    IBOutlet NSMenuItem *viewMenu;
    
    
    IBOutlet NSView *noFileSelected;
    IBOutlet NSView *fileSelected;
    IBOutlet NSTextField *packageName;
    IBOutlet NSTextField *packagePath;
    IBOutlet NSImageView *packageIcon;
    IBOutlet NSButton *packageButton;
    
    IBOutlet NSPopover *popover;
}

- (IBAction)packageAndShare: (id)sender;
- (void)createPackageFromFinderSelection;
- (void)performHotKeySelector: (PTHotKey *)hotKey;
- (void)updateHotKey;
@end
