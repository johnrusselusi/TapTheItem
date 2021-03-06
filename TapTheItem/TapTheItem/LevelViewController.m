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
#import "HighScoreManager.h"

NSInteger const STARTING_TIME = 3;
NSInteger const STARTING_NUMBER_OF_ATTEMPTS = 3;
NSInteger const STARTING_PLAYER_SCORE = 0;

float const TIMER_INTERVAL = 1.0;

NSString *const ALERTVIEW_TITLE = @"Game Over";
NSString *const TRY_AGAIN_BUTTON_TITLE = @"Try Again";
NSString *const RETURN_TO_MAIN_MENU_BUTTON_TITLE = @"Main Menu";

@interface LevelViewController () <ItemViewControllerDelegate, UIAlertViewDelegate>

@property (retain, nonatomic) LevelView *levelView;
@property (retain, nonatomic) ItemViewController *itemViewController;
@property (retain, nonatomic) PlayerModel *player;

@end

@implementation LevelViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.highScore = [HighScoreManager getCurrentHighScore];
    
    self.player = [[[PlayerModel alloc]init] autorelease];
    
    self.levelView = [[[LevelView alloc]init] autorelease];
    
    [self setView:self.levelView];
    
    self.itemViewController = [[[ItemViewController alloc]init] autorelease];
    
    self.itemViewController.delegate = self;
    
    [self.view addSubview:self.itemViewController.view];
    
    [self startNewLevel];
}

#pragma mark - Game Cycle

- (void)startNewLevel{
    
    //  Method for updating the views every level
    [self.itemViewController reloadNewItems];
    
    self.player.numberOfAttemptsLeft = STARTING_NUMBER_OF_ATTEMPTS;
    self.timeLeft = STARTING_TIME;
    
    self.levelView.timeLeftLabel.text = [NSString stringWithFormat:@"%ld",
                                         (long)self.timeLeft];
    
    self.levelView.playerScoreLabel.text = [NSString stringWithFormat:@"%ld",
                                            (long)self.player.playerScore];
    
    self.levelView.numberOfAttemptsLeftLabel.text = [NSString stringWithFormat:@"%ld",
                                                     (long)self.player.numberOfAttemptsLeft];
    
    self.levelTimer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL
                                                       target:self
                                                     selector:@selector(updateTimer:)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)didSelectAnItem:(ItemView *)selectedItem{
    
    //  Compare if the identifier of the tapped item is equivalent to the identifier of the required item
    if (selectedItem.itemIdentifier == self.itemViewController.requiredItem.itemIdentifier) {
        
        //  Stop the timer and update score
        [self.levelTimer invalidate];
        self.player.playerScore += self.player.numberOfAttemptsLeft;
        
        self.levelView.playerScoreLabel.text = [NSString stringWithFormat:@"%ld",
                                                (long)self.player.playerScore];
        
        [self.itemViewController removeOldItems];
        [self startNewLevel];

    } else {
    
        //  Check if the player still has chances left
        if (self.player.numberOfAttemptsLeft > 0) {
            
            //  Decrease the number of chances left of the player
            self.player.numberOfAttemptsLeft--;
            self.levelView.numberOfAttemptsLeftLabel.text = [NSString stringWithFormat:@"%ld",
                                                             (long)self.player.numberOfAttemptsLeft];
        } else {
            
            [self.levelTimer invalidate];
            [self gameOver];
        }
    }
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
        [HighScoreManager writeNewHighScore:self.highScore];
    }
    
    NSString *scoreFormat = [NSString stringWithFormat:@"Score :%ld\nHigh Score :%ld",
                             (long)self.player.playerScore,
                             (long)self.highScore];
    
    //  Alerview to notify the player that the game is over
    UIAlertView *gameOverAlert = [[UIAlertView alloc]initWithTitle:ALERTVIEW_TITLE
                                                           message:scoreFormat
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:TRY_AGAIN_BUTTON_TITLE,RETURN_TO_MAIN_MENU_BUTTON_TITLE,nil];
    
    [gameOverAlert show];
    [gameOverAlert release];
    
    self.player.playerScore = STARTING_PLAYER_SCORE;
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{

    //  gameOver alert view button responders
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:TRY_AGAIN_BUTTON_TITLE]) {
        
        [self.itemViewController removeOldItems];
        [self startNewLevel];
        
    } else if ([title isEqualToString:RETURN_TO_MAIN_MENU_BUTTON_TITLE]) {
    
        [self.itemViewController removeOldItems];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

- (void)dealloc{
    
    self.levelView = nil;
    self.itemViewController = nil;
    self.player = nil;
    self.levelTimer = nil;
    
    [super dealloc];
}
@end
