//
//  LevelViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/24/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "LevelViewController.h"
#import "ItemViewController.h"
#import "LevelView.h"
#import "ItemView.h"
#import "PlayerModel.h"

NSInteger const STARTING_TIME = 5;
NSInteger const STARTING_NUMBER_OF_ATTEMPTS = 3;
int const STARTING_PLAYER_SCORE = 0;

NSString *const JSON_PATH = @"score.json";
NSString *const HIGHSCORE_KEY = @"highScore";
NSString *const ALERTVIEW_TITLE = @"Game Over";
NSString *const TRY_AGAIN_BUTTON_TITLE = @"Try Again";
NSString *const RETURN_TO_MAIN_MENU_BUTTON_TITLE = @"Main Menu";

@interface LevelViewController () <ItemViewControllerDelegate, UIAlertViewDelegate>

@property (retain, nonatomic) LevelView *levelView;
@property (retain, nonatomic) ItemViewController *itemView;
@property (retain, nonatomic) PlayerModel *player;

@end

@implementation LevelViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad{

    [super viewDidLoad];
    
    [self readCurrentHighScore];
    
    self.player = [[[PlayerModel alloc]init] autorelease];
    
    self.levelView = [[[LevelView alloc]init] autorelease];
    
    [self setView:self.levelView];
    
    [self startNewLevel];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    self.itemView.delegate = nil;
}

#pragma mark - Game Cycle

- (void)startNewLevel{
    
    self.itemView = [[ItemViewController alloc]init];
    
    self.itemView.delegate = self;

    [self.view addSubview:self.itemView.view];
    
    self.timeLeft = STARTING_TIME;
    self.levelView.timeLeftLabel.text = [NSString stringWithFormat:@"%ld",
                                         (long)self.timeLeft];
    
    self.levelView.playerScoreLabel.text = [NSString stringWithFormat:@"%ld",
                                            (long)self.player.playerScore];
    
    self.levelView.numberOfAttemptsLeftLabel.text = [NSString stringWithFormat:@"%ld",
                                                     (long)self.player.numberOfAttemptsLeft];
    
    self.levelTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                       target:self
                                                     selector:@selector(updateTimer:)
                                                     userInfo:nil
                                                      repeats:YES];

}

- (void)didSelectAnItem:(ItemView *)selectedItem{
    
    if (selectedItem.itemIdentifier == self.itemView.requiredItem.itemIdentifier) {
        
        [self.levelTimer invalidate];
        self.player.playerScore += self.player.numberOfAttemptsLeft;
        self.player.numberOfAttemptsLeft = 3;
        
        self.levelView.playerScoreLabel.text = [NSString stringWithFormat:@"%ld",
                                                (long)self.player.playerScore];
        
        self.levelView.numberOfAttemptsLeftLabel.text = [NSString stringWithFormat:@"%ld",
                                                         (long)self.player.numberOfAttemptsLeft];
        
        [self removeCurrentItems];

    } else {
    
        if (self.player.numberOfAttemptsLeft > 0) {
            
            self.player.numberOfAttemptsLeft -= 1;
            self.levelView.numberOfAttemptsLeftLabel.text = [NSString stringWithFormat:@"%ld",
                                                             (long)self.player.numberOfAttemptsLeft];
        } else {
            [self.levelTimer invalidate];
            [self gameOver];
        }
    }
}

- (void)removeCurrentItems{
    
    [self.itemView viewWillDisappear:YES];
    [self.itemView removeFromParentViewController];
    
    [self startNewLevel];
}

- (void)updateTimer:(NSTimer *)timer{
    
    if (self.timeLeft > 0) {
        
        self.timeLeft--;
        self.levelView.timeLeftLabel.text = [NSString stringWithFormat:@"%ld", (long)self.timeLeft];
    } else {
        
        [self.levelTimer invalidate];
        [self gameOver];
    }
}

- (void)gameOver{
    
    if (self.player.playerScore > self.highScore) {
        
        self.highScore = self.player.playerScore;
        [self writeNewHighScore:self.highScore];
    }
    
    UIAlertView *gameOverAlert = [[UIAlertView alloc]initWithTitle:ALERTVIEW_TITLE
                                                           message:[NSString stringWithFormat:@"Score :%ld\nHigh Score :%ld", (long)self.player.playerScore,
                                                                    (long)self.highScore]
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:TRY_AGAIN_BUTTON_TITLE,RETURN_TO_MAIN_MENU_BUTTON_TITLE,nil];
    
    [gameOverAlert show];
    
    self.player.playerScore = STARTING_PLAYER_SCORE;
    self.player.numberOfAttemptsLeft = STARTING_NUMBER_OF_ATTEMPTS;
    
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{

    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:TRY_AGAIN_BUTTON_TITLE]) {
        
        [self removeCurrentItems];
    } else if ([title isEqualToString:RETURN_TO_MAIN_MENU_BUTTON_TITLE]) {
    
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark - Saving of High Score

- (NSString *)filePath{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *filePath = [paths objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:JSON_PATH];
    return filePath;
}

- (void)readCurrentHighScore{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[self filePath]];
    self.highScore = [[dictionary valueForKey:HIGHSCORE_KEY] intValue];
}

- (void)writeNewHighScore:(NSInteger)score{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInteger:score]
                                                                         forKey:HIGHSCORE_KEY];
    
    [[NSString stringWithFormat:@"%@",dictionary] writeToFile:[self filePath]
                                                   atomically:YES
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
    
}

- (void)dealloc{

    self.levelView = nil;
    self.itemView = nil;
    self.player = nil;
    self.levelTimer = nil;
    
    [super dealloc];
}
@end
