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

@end

@implementation LevelView

- (instancetype)init{

    self = [super init];
    
    if (self) {
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:TIME_LABEL_FRAME];
        UILabel *scoreLabel = [[UILabel alloc]initWithFrame:SCORE_LABEL_FRAME];
        UILabel *lifeLabel = [[UILabel alloc]initWithFrame:LIFE_LABEL_FRAME];
        
        self.playerScoreLabel = [[[UILabel alloc]initWithFrame:PLAYER_SCORE_LABEL_FRAME] autorelease];
        self.numberOfAttemptsLeftLabel = [[[UILabel alloc]initWithFrame:ATTEMPTS_LEFT_LABEL_FRAME] autorelease];
        self.timeLeftLabel = [[[UILabel alloc]initWithFrame:TIME_LEFT_LABEL_FRAME] autorelease];
        
        timeLabel.text = @"Time Left :";
        scoreLabel.text = @"Score :";
        lifeLabel.text = @"Life :";
        
        [self addSubview:timeLabel];
        [self addSubview:scoreLabel];
        [self addSubview:lifeLabel];
        
        [self addSubview:self.playerScoreLabel];
        [self addSubview:self.numberOfAttemptsLeftLabel];
        [self addSubview:self.timeLeftLabel];
        
        [timeLabel release];
        [scoreLabel release];
        [lifeLabel release];
    }
    
    return self;
}

- (void)dealloc{

    [_playerScoreLabel release];
    _playerScoreLabel = nil;
    [_numberOfAttemptsLeftLabel release];
    _numberOfAttemptsLeftLabel = nil;
    [_timeLeftLabel release];
    _timeLeftLabel = nil;
    
    [super dealloc];
}
@end
