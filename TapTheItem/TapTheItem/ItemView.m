//
//  ItemView.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/22/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "ItemView.h"

float const IMAGEVIEW_X_AXIS = 0.0;
float const IMAGEVIEW_Y_AXIS = 0.0;
float const IMAGEVIEW_WIDTH = 60.0;
float const IMAGEVIEW_HEIGHT = 60.0;

@implementation ItemView

- (instancetype)initWithImage:(UIImage *)image{
    
    self = [super initWithImage:image];
    if (self) {
        
        CGRect frame = CGRectMake(IMAGEVIEW_X_AXIS,
                                  IMAGEVIEW_Y_AXIS,
                                  IMAGEVIEW_WIDTH,
                                  IMAGEVIEW_HEIGHT);
        
        
        self.frame = frame;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}


@end
