//
//  SIPluginController.m
//  ShipIt
//
//  Created by doomspork on 5/21/11.
//  Copyright 2011 Codez4Mac.com All rights reserved.
//

#import "PluginController.h"

NSString * const kSIPluginTypeDelivery = @"SIDeliveryPlugin";
NSString * const kSIPluginTypePackaging = @"SIPackagingPlugin";

@implementation PluginController 

+ (PluginController *) sharedInstance 
{                                                                    
    static PluginController *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[PluginController alloc] init];
        return sharedSingleton;
    }                                                                     
}

- (void)dealloc
{
    [deliveryPlugins release];
    [packagingPlugins release];
    [super dealloc];
}

- (id<SIPluginProtocol>)packaging
{
    return nil;
}

- (NSSet *)destinations 
{
    return nil;   
}

@end

@implementation PluginController (PrivateMethods)

- (id)init
{
    self = [super init];
    if (self) {
            //LOAD PLUGINS
    }
    return self;
}

+ (void)initialize
{
    [super initialize];
}

+ (NSSet *)availablePluginsInDirectory:(NSString *)aDirectory forProtocol:(Protocol *)aProtocol 
{
    NSArray * plugins = [NSBundle pathsForResourcesOfType:@"plugin" 
                                              inDirectory:[aDirectory stringByExpandingTildeInPath]];
    
    NSMutableSet *set = [NSMutableSet setWithCapacity: [plugins count]];
    for(id path in plugins) {
        NSBundle *pluginBundle = [NSBundle bundleWithPath: path];
        NSDictionary* pluginDict = [pluginBundle infoDictionary];
        NSString* pluginName = [pluginDict objectForKey:@"NSPrincipalClass"];
        Class pluginClass = NSClassFromString(pluginName);
        if (!pluginClass) {
            pluginClass = [pluginBundle principalClass];
        }
        if ([pluginClass conformsToProtocol: aProtocol] && 
            [pluginClass isKindOfClass: [NSObject class]]) {
            [set addObject: pluginClass];
        }
    }
    return [[NSSet setWithSet: set] autorelease];
}
@end
