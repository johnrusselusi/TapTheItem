//
//  RequiredItemView.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/23/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "RequiredItemView.h"
#import "ItemView.h"

CGRect const REQUIRED_ITEMVIEW_FRAME = {20, 115, 90, 90};

@implementation RequiredItemView

- (instancetype)initWithItemView:(ItemView *)itemView{

    self = [super init];
    
    if (self) {
        
        self.frame = REQUIRED_ITEMVIEW_FRAME;
        self.itemIdentifier = itemView.itemIdentifier;
        self.image = itemView.image;
    }
    return self;
}
@end
