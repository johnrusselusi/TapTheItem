//
//  LevelViewController.h
//  TapTheItem
//
//  Created by John Russel Usi on 10/24/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemView;

@interface LevelViewController : UIViewController

@property (nonatomic) int timeLeft;

@property (retain, nonatomic) NSTimer *levelTimer;

@end