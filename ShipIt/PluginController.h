//
//  SIServicesManager.h
//  ShipIt
//
//  Created by doomspork on 5/21/11.
//  Copyright 2011 Codez4Mac.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIPluginProtocol.h"

extern NSString * const kSIPluginTypeDelivery;
extern NSString * const kSIPluginTypePackaging;

@interface PluginController : NSObject {
@private
    NSSet *deliveryPlugins;
    NSSet *packagingPlugins;
}

+ (PluginController *)sharedInstance;
- (id<SIPluginProtocol>)packaging;
- (NSSet *)destinations;
@end

@interface PluginController (PrivateMethods){
@private

}

- (id)init;
+ (void)initialize;
+ (NSSet *)availablePluginsInDirectory:(NSString *)aDirectory forProtocol:(Protocol *)aProtocol;

@end

