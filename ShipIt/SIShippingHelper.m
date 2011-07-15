//
//  SIShipmentHelper.m
//  ShipIt
//
//  Created by Doomspork on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SIShippingHelper.h"


@implementation SIShippingHelper

+ (id)helper
{
    return [[[SIShippingHelper alloc] init] autorelease];
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

- (void)shipPackage:(SIPackage *)aPackage
{
    NSLog(@"Processing shipment in new thread.");
}

@end
