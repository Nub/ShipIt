//
//  CMDeliveryProtocol.h
//  ShipIt
//
//  Created by doomspork on 5/21/11.
//  Copyright 2011 Codez4Mac.com All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kSIDeliveryPlugin,
    kSICompressionPlugin,
    kSIContentPlugin
} SIPluginTypes;

@protocol SIDeliveryServiceProtocol <NSObject>
- (id)initializeService;
- (void)terminateService;
+ (NSString *)name;
- (BOOL)deliverPackage: (SIPackage *)aPackage;
@end
