//
//  Player.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/24/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "PlayerModel.h"

@implementation PlayerModel

- (instancetype)init{

    self = [super init];
    
    if (self) {
        
        self.playerScore = 0;
        self.numberOfAttemptsLeft = 3;
    }
    
    return self;
}

- (void)playerDidSelectCorrectAnswer{

    self.playerScore += self.numberOfAttemptsLeft;
}

- (void)playerDidSelectWrongAnswer{

    self.numberOfAttemptsLeft -= 1;
}
@end
