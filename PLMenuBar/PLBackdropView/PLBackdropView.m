//
//  PLBackdropView.m
//  PLMenuBar
//
//  Created by Patrick Lin on 4/12/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

#import "PLBackdropView.h"
#import "PLBackdropViewSettings.h"
#import "PLBackdropViewSettingsATVMenuLight.h"

@implementation PLBackdropView

- (id)initWithFrame:(CGRect)frame settings:(PLBackdropViewSettings *)settings
{
    self = [super initWithFrame:frame];
    
    if (!self) return nil;
    
    self.backgroundColor = [UIColor clearColor];
    
    Class klass = NSClassFromString(@"_UIBackdropView");
    
    _backdropView = [klass alloc];
    
    CGRect bounds = self.bounds;
    
    id backdropViewSettings = settings->_backdropViewSettings;
    
    SEL sel = NSSelectorFromString(@"initWithFrame:settings:");
    
    NSMethodSignature *msig = [_backdropView methodSignatureForSelector:sel];
    
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:msig];
    
    [inv setSelector:sel];
    
    [inv setTarget:_backdropView];
    
    [inv setArgument:&bounds atIndex:2];
    
    [inv setArgument:&backdropViewSettings atIndex:3];
    
    [inv invoke];
    
    [self addSubview:_backdropView];

    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    PLBackdropViewSettingsATVMenuLight *settings = [[PLBackdropViewSettingsATVMenuLight alloc] initWithDefaultValues];
    
    self = [self initWithFrame:frame settings:settings];
    
    if (!self) return nil;

    return self;
}

@end
