//
//  SIShipmentHelper.h
//  ShipIt
//
//  Created by Doomspork on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIPackage.h"

@interface SIShippingHelper : NSObject {
@private
    
}
+ (id)helper;
- (void)shipPackage:(SIPackage *)aPackage;

@end
