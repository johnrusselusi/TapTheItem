//
//  Player.h
//  TapTheItem
//
//  Created by John Russel Usi on 10/24/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerModel : NSObject

@property (assign, nonatomic) int numberOfAttemptsLeft;
@property (assign, nonatomic) int playerScore;
@property (assign, nonatomic) int highScore;

@end
