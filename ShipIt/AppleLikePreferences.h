//
//  AppleLikePreferences.h
//  ShipIt
//
//  Created by MrAsterisco on 21/06/11.
//  Copyright 2011 Codez4Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShortcutRecorder/ShortcutRecorder.h>

#import "LaunchAtLoginController.h"

@interface AppleLikePreferences : NSObject {
@private
    
    IBOutlet SRRecorderControl *shortcutRecorder;
    LaunchAtLoginController *launchAtLogin;

}

- (IBAction)toggleDockIcon:(NSButton *)checkbox;
- (IBAction)toggleLaunchAtLogin:(NSButton *)checkbox;

@end
