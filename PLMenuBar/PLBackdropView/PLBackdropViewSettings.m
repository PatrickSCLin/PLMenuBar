//
//  PLBackdropViewSettings.m
//  PLMenuBar
//
//  Created by Patrick Lin on 4/12/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

#import "PLBackdropViewSettings.h"

@implementation PLBackdropViewSettings

- (id)init
{
    self = [super init];
    
    if (!self) return nil;

    [self _configureBackdropViewSettings];
    
    return self;
}

- (id)initWithDefaultValues
{
    self = [super init];
    
    if (!self) return nil;
    
    [self _configureBackdropViewSettingsWithDefaultValues];
    
    return self;
}

- (Class)_wrappingClass
{
    return NSClassFromString(@"_UIBackdropViewSettings");
}

- (void)_configureBackdropViewSettings
{
    Class klass = [self _wrappingClass];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    SEL sel = NSSelectorFromString(@"init");
    
    _backdropViewSettings = [[klass alloc] performSelector:sel];
    
#pragma clang diagnostic pop
    
}

- (void)_configureBackdropViewSettingsWithDefaultValues
{
    Class klass = [self _wrappingClass];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    SEL sel = NSSelectorFromString(@"initWithDefaultValues");
    
    _backdropViewSettings = [[klass alloc] performSelector:sel];
    
#pragma clang diagnostic pop
    
}

@end
