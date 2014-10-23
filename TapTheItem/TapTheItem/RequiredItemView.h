//
//  RequiredItemView.h
//  TapTheItem
//
//  Created by John Russel Usi on 10/23/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemView;

@interface RequiredItemView : UIImageView

@property (nonatomic) int itemIdentifier;

- (instancetype)initWithItemView:(ItemView *)itemView;

@end
