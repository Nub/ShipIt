//
//  SIShipment.m
//  ShipIt
//
//  Created by Doomspork on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SIPackage.h"


@implementation SIPackage

+ (id)package
{
    return [[[SIPackage alloc] init] autorelease];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)addURL:(NSURL *)aURL
{
    NSMutableSet *mut = [NSMutableSet setWithSet:items];
    [mut addObject:aURL];
    [items release];
    items = [NSSet setWithSet:mut];
}

- (void)setPackaging:(id<SIPluginProtocol>)aPackage
{
    [aPackage retain];
    [packaging release];
    packaging = aPackage;
}

- (void)setDestinations:(NSSet *)aSet
{
    [aSet retain];
    [destinations release];
    destinations = aSet;
}

- (void)addDestination:(id<SIPluginProtocol>)aDestination
{
    NSMutableSet *mut = [NSMutableSet setWithSet:destinations];
    [mut addObject:aDestination];
    [self setDestinations:mut];
}

- (void)removeDestination:(id<SIPluginProtocol>)aDestination
{
    NSMutableSet *mut = [NSMutableSet setWithSet:destinations];
    if ([mut containsObject:aDestination]) {
        [mut addObject:aDestination];
        [self setDestinations:mut];
    }
}


@end
