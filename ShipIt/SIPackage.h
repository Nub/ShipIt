//
//  SIShipment.h
//  ShipIt
//
//  Created by Doomspork on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIPluginProtocol.h"

@interface SIPackage : NSObject {
@private
    NSSet *items;
    NSSet *destinations;
    id<SIPluginProtocol> packaging;
}

+ (id)package;
- (void)addURL:(NSURL *)aURL;
- (void)setPackaging:(id<SIPluginProtocol>)packager;
- (void)setDestinations:(NSSet *)aSet;
- (void)addDestination:(id<SIPluginProtocol>)aDestination;
- (void)removeDestination:(id<SIPluginProtocol>)aDestination;


@end
