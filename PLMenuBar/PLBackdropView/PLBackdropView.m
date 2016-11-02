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
#import "PLBackdropViewSettingsATVMenuDark.h"

@implementation PLBackdropView

- (void)setStyle:(enum PLBackdropViewStyle)style
{
    PLBackdropViewSettings* settings = nil;
    
    if (style == PLBackdropViewStyleLight) { settings = [[PLBackdropViewSettingsATVMenuLight alloc] init]; }
    
    else if (style == PLBackdropViewStyleDark) { settings = [[PLBackdropViewSettingsATVMenuDark alloc] init]; }
    
    if (settings != nil) { [self setupBackDropViewWithSettings:settings]; }
}

- (enum PLBackdropViewStyle)style
{
    if ([_settings isKindOfClass: [PLBackdropViewSettingsATVMenuLight class]]) { return PLBackdropViewStyleLight; }
    
    else if ([_settings isKindOfClass: [PLBackdropViewSettingsATVMenuDark class]]) { return PLBackdropViewStyleDark; }
    
    return PLBackdropViewStyleLight;
}

- (void)setupBackDropViewWithSettings:(PLBackdropViewSettings *)settings
{
    Class klass = NSClassFromString(@"_UIBackdropView");
    
    id backdropView = [klass alloc];
    
    CGRect bounds = self.bounds;
    
    id backdropViewSettings = settings->_backdropViewSettings;
    
    SEL sel = NSSelectorFromString(@"initWithFrame:settings:");
    
    NSMethodSignature *msig = [backdropView methodSignatureForSelector:sel];
    
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:msig];
    
    [inv setSelector:sel];
    
    [inv setTarget:backdropView];
    
    [inv setArgument:&bounds atIndex:2];
    
    [inv setArgument:&backdropViewSettings atIndex:3];
    
    [inv invoke];
    
    if (_backdropView == nil) {
        
        [self addSubview:backdropView];
        
    }
    
    else {
        
        NSUInteger index = [self.subviews indexOfObject:_backdropView];
        
        [_backdropView removeFromSuperview];
        
        [self insertSubview:backdropView atIndex:index];
        
        [backdropView setFrame:self.bounds];
        
    }
    
    [backdropView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    _backdropView = backdropView;
    
    _settings = settings;
    
}

- (id)initWithFrame:(CGRect)frame settings:(PLBackdropViewSettings *)settings
{
    self = [super initWithFrame:frame];
    
    if (!self) return nil;
    
    self.backgroundColor = [UIColor clearColor];
    
    [self setupBackDropViewWithSettings: settings];

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
