//
//  ItemView.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/22/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (instancetype)initwithSelectedItem:(ItemView *)selectedItem{

    self = [super init];
    
    if (self) {
        
        self.itemIdentifier = selectedItem.itemIdentifier;
        self.image = selectedItem.image;
    }
    
    return self;
}
@end
