//
//  AppleLikePreferences.h
//  ShipIt
//
//  Created by MrAsterisco on 21/06/11.
//  Copyright 2011 Codez4Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShortcutRecorder/ShortcutRecorder.h>

@interface AppleLikePreferences : NSObject {
@private
    IBOutlet NSWindow *prefWindow;
    IBOutlet NSView *generalView;
    IBOutlet NSView *pluginsView;
    IBOutlet NSView *contentView;
    IBOutlet NSToolbar *myToolbar;
    IBOutlet SRRecorderControl *shortcutRecorder;
}

- (IBAction)showGeneral:(id)sender;
- (IBAction)showPlugins:(id)sender;
- (IBAction)toggleDockIcon:(id)sender;
- (IBAction)showPrefWindow:(id)sender;


@end
