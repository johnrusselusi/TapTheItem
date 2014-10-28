//
//  RequiredItemView.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/23/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "RequiredItemView.h"
#import "ItemView.h"

CGRect const FIRST_REQUIRED_ITEMVIEW_FRAME = {20, 135, 50, 50};
CGRect const SECOND_REQUIRED_ITEMVIEW_FRAME = {77, 135, 50, 50};
CGRect const THIRD_REQUIRED_ITEMVIEW_FRAME = {135, 135, 50, 50};

@implementation RequiredItemView

- (instancetype)initWithItemView:(ItemView *)itemView itemCount:(int)count{

    self = [super init];
    
    if (self) {
        
        if (count == 0) {
            
            self.frame = FIRST_REQUIRED_ITEMVIEW_FRAME;
        } else if (count == 1) {
        
            self.frame = SECOND_REQUIRED_ITEMVIEW_FRAME;
        } else if (count == 2) {
        
            self.frame = THIRD_REQUIRED_ITEMVIEW_FRAME;
        }
        
        self.itemIdentifier = itemView.itemIdentifier;
        self.image = itemView.image;
    }
    return self;
}
@end
