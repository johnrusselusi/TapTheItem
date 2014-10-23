//
//  RequiredItemView.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/23/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "RequiredItemView.h"
#import "ItemView.h"

CGPoint const REQUIRED_ITEMVIEW_ORIGIN = {20, 115};

float const REQUIRED_ITEMVIEW_WIDTH = 90;
float const REQUIRED_ITEMVIEW_HEIGHT = 90;

@implementation RequiredItemView

- (instancetype)initWithItemView:(ItemView *)itemView{

    self = [super init];
    
    if (self) {
        CGRect frame = CGRectMake(REQUIRED_ITEMVIEW_ORIGIN.x,
                                  REQUIRED_ITEMVIEW_ORIGIN.y,
                                   REQUIRED_ITEMVIEW_WIDTH,
                                  REQUIRED_ITEMVIEW_HEIGHT);
        
        self.frame = frame;
        self.itemIdentifier = itemView.itemIdentifier;
        self.image = itemView.image;
        self.userInteractionEnabled = YES;
    }
    return self;
}
@end
