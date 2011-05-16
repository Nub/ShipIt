#import <Cocoa/Cocoa.h>
#import "CMDroppableView.h"
#import "CMCompressor.h"

@interface AppController : NSObject {
    @private
        IBOutlet NSMenu *statusMenu;
        NSStatusItem *statusItem;
        CMDroppableView *statusItemView;
        CMCompressor *compressor;
}

- (IBAction) packageAndShare: (id) sender;
//- (void) populateFilesWithFinderSelection;
//- (void) registerGlobalHotKey;

@end