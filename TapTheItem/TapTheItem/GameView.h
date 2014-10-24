//
//  GameView.h
//  TapTheItem
//
//  Created by John Russel Usi on 10/24/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameView : UIScrollView

@property (retain, nonatomic) UILabel *playerScoreLabel;
@property (retain, nonatomic) UILabel *numberOfAttemptsLeftLabel;

@end
