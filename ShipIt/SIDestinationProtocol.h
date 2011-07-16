//
//  SIDestinationProtocol.h
//  ShipIt
//
//  Created by Doomspork on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SIDestinationProtocol <NSObject>
+ (NSView *)view;
- (BOOL)deliverFile:(NSString *)aString error:(NSError **)error;
@end
