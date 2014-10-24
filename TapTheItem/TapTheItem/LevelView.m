//
//  LevelView.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/24/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "LevelView.h"

CGRect const SCORE_LABEL_FRAME = {20, 236, 60, 21};
CGRect const LIFE_LABEL_FRAME = {20, 265, 40, 21};
CGRect const TIME_LABEL_FRAME = {20, 63, 83, 21};
CGRect const PLAYER_SCORE_LABEL_FRAME = {81, 236, 114, 21};
CGRect const ATTEMPTS_LEFT_LABEL_FRAME = {81, 265, 131, 21};
CGRect const TIME_LEFT_LABEL_FRAME = {111, 63, 10, 21};

@interface LevelView ()

@property (nonatomic) UILabel *scoreLabel;
@property (nonatomic) UILabel *lifeLabel;
@property (nonatomic) UILabel *timeLabel;

@end

@implementation LevelView

- (instancetype)init{

    self = [super init];
    
    if (self) {
        
        self.timeLabel = [[UILabel alloc]init];
        self.scoreLabel = [[UILabel alloc]init];
        self.lifeLabel = [[UILabel alloc]init];
        self.playerScoreLabel = [[UILabel alloc]init];
        self.numberOfAttemptsLeftLabel = [[UILabel alloc]init];
        self.timeLeftLabel = [[UILabel alloc]init];
        
        self.timeLabel.frame = TIME_LABEL_FRAME;
        self.scoreLabel.frame = SCORE_LABEL_FRAME;
        self.lifeLabel.frame = LIFE_LABEL_FRAME;
        self.playerScoreLabel.frame = PLAYER_SCORE_LABEL_FRAME;
        self.numberOfAttemptsLeftLabel.frame = ATTEMPTS_LEFT_LABEL_FRAME;
        self.timeLeftLabel.frame = TIME_LEFT_LABEL_FRAME;
        
        self.timeLabel.text = @"Time Left :";
        self.scoreLabel.text = @"Score :";
        self.lifeLabel.text = @"Life :";
        
        [self addSubview:self.timeLabel];
        [self addSubview:self.scoreLabel];
        [self addSubview:self.lifeLabel];
        [self addSubview:self.playerScoreLabel];
        [self addSubview:self.numberOfAttemptsLeftLabel];
        [self addSubview:self.timeLeftLabel];
    }
    
    return self;
}
@end
