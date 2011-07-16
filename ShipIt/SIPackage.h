//
//  SIShipment.h
//  ShipIt
//
//  Created by Doomspork on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIPackagingProtocol.h"
#import "SIDestinationProtocol.h"

@interface SIPackage : NSObject {
@private
    NSSet *contents;
    NSSet *destinations;
    id<SIPackagingProtocol> packager;
}

+ (id)package;
- (void)addURL:(NSURL *)aURL;
- (void)setPackager:(id<SIPackagingProtocol>)packager;
- (void)setDestinations:(NSSet *)aSet;
- (void)addDestination:(id<SIDestinationProtocol>)aDestination;
- (void)removeDestination:(id<SIDestinationProtocol>)aDestination;
- (id)packager;
- (NSSet *)destinations;
- (NSSet *)contents;

@end
