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
    NSMutableSet *mut = [NSMutableSet setWithSet:contents];
    [mut addObject:aURL];
    [contents release];
    contents = [NSSet setWithSet:mut];
}

- (void)setPackager:(id<SIPackagingProtocol>)aPackager
{
    [aPackager retain];
    [packager release];
    packager = aPackager;
}

- (void)setDestinations:(NSSet *)aSet
{
    [aSet retain];
    [destinations release];
    destinations = aSet;
}

- (void)addDestination:(id<SIDestinationProtocol>)aDestination
{
    NSMutableSet *mut = [NSMutableSet setWithSet:destinations];
    [mut addObject:aDestination];
    [self setDestinations:mut];
}

- (void)removeDestination:(id<SIDestinationProtocol>)aDestination
{
    NSMutableSet *mut = [NSMutableSet setWithSet:destinations];
    if ([mut containsObject:aDestination]) {
        [mut addObject:aDestination];
        [self setDestinations:mut];
    }
}

- (id<SIPackagingProtocol>)packager
{
    return packager;
}

- (NSSet *)destinations
{
    return destinations;
}

- (NSSet *)contents;
{
    return contents;
}

@end
