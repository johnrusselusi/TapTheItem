//
//  RequireItemViewController.h
//  TapTheItem
//
//  Created by John Russel Usi on 10/23/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RequiredItemView;

@interface RequiredItemViewController : UIViewController

@property (retain, nonatomic) NSMutableArray *displayedItems;
@property (retain, nonatomic) NSMutableArray *requiredItems;

@end
