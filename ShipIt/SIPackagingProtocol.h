//
//  SIPackagingProtocol.h
//  ShipIt
//
//  Created by Sean Callan on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SIPackagingProtocol <NSObject>
+ (NSView *)view;
- (NSString *)pasteboardNameForPackagedFileSet:(NSSet *)aSet error:(NSError **)error;
@end
