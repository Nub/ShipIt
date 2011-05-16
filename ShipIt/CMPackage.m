//
//  CMPackage.m
//  ShipIt!
//
//  Created by doomspork on 5/15/11.
//  Copyright 2011 Codez4Mac.com. All rights reserved.
//

#import "CMPackage.h"


@implementation CMPackage

-(CMPackage *)init {
    self = [super init];
    if(self) {
        packageFiles = [[NSMutableArray array] retain];
    }
    return self;
}

-(void)dealloc {
    [packageFiles release];
    [super dealloc];
}

-(void)addURLToPackage:(NSURL *)aURL {
    [packageFiles addObject: aURL];
}

-(NSArray *)packageContentsAsArray {
    return [NSArray arrayWithArray: packageFiles];
}

-(unsigned int)size {
    return [packageFiles count];
}

@end
