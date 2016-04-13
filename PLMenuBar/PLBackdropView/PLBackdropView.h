//
//  PLBackdropView.h
//  PLMenuBar
//
//  Created by Patrick Lin on 4/12/16.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

#include <UIKit/UIKit.h>

@class PLBackdropViewSettings;

@interface PLBackdropView : UIView
{
    @public
    
    id _backdropView;
}

- (id)initWithFrame:(CGRect)frame settings:(PLBackdropViewSettings *)settings;

@end
