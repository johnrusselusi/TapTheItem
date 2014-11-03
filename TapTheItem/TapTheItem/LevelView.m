//
//  LevelView.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/24/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "LevelView.h"

CGRect const SCORE_LABEL_FRAME = {20, 236, 80, 21};
CGRect const LIFE_LABEL_FRAME = {20, 265, 80, 21};
CGRect const TIME_LABEL_FRAME = {20, 63, 120, 21};

CGRect const PLAYER_SCORE_LABEL_FRAME = {100, 236, 114, 21};
CGRect const ATTEMPTS_LEFT_LABEL_FRAME = {100, 265, 131, 21};
CGRect const TIME_LEFT_LABEL_FRAME = {125, 63, 20, 21};

NSString *const TIME_LABEL_TEXT = @"Time Left :";
NSString *const SCORE_LABEL_TEXT = @"Score :";
NSString *const LIFE_LABEL_TEXT = @"Chance :";

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
        
        timeLabel.text = TIME_LABEL_TEXT;
        scoreLabel.text = SCORE_LABEL_TEXT;
        lifeLabel.text = LIFE_LABEL_TEXT;
        
        self.timeLeftLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
        timeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
        
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

    self.playerScoreLabel = nil;
    self.numberOfAttemptsLeftLabel = nil;
    self.timeLeftLabel = nil;
    
    [super dealloc];
}
@end
