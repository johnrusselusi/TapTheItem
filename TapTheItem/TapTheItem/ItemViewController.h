//
//  ItemViewController.h
//  TapTheItem
//
//  Created by John Russel Usi on 10/22/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemView;

@protocol ItemViewControllerDelegate <NSObject>

- (void)didSelectAnItem:(ItemView *)selectedItem;

@end

@interface ItemViewController : UIViewController

@property (assign, nonatomic) id<ItemViewControllerDelegate>delegate;

@end
