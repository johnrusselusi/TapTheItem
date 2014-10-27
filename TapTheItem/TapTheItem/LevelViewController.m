//
//  LevelViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/24/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "LevelViewController.h"
#import "ItemViewController.h"
#import "RequiredItemViewController.h"
#import "LevelView.h"
#import "ItemView.h"
#import "RequiredItemView.h"
#import "PlayerModel.h"

int const STARTING_TIME = 5;
int const STARTING_NUMBER_OF_ATTEMPTS = 3;
int const STARTING_PLAYER_SCORE = 0;

@interface LevelViewController () <ItemViewControllerDelegate, UIAlertViewDelegate, NSCoding>

@property (retain, nonatomic) LevelView *levelView;
@property (retain, nonatomic) ItemViewController *itemView;
@property (retain, nonatomic) RequiredItemViewController *requiredItem;
@property (retain, nonatomic) PlayerModel *player;

@end

@implementation LevelViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad{

    [super viewDidLoad];
    
    self.player = [[[PlayerModel alloc]init] autorelease];
    
    self.levelView = [[[LevelView alloc]init] autorelease];
    
    [self setView:self.levelView];
    
    [self startNewLevel];
}

#pragma mark - Game Cycle

- (void)startNewLevel{
    
    self.itemView = [[ItemViewController alloc]init];
    self.requiredItem = [[[RequiredItemViewController alloc]init] autorelease];
    
    self.itemView.delegate = self;

    [self.view addSubview:self.itemView.view];
    self.requiredItem.selectionItems = [[NSMutableArray alloc]
                                         initWithArray:self.itemView.availableItems];
    
    [self.view addSubview:self.requiredItem.view];
    
    self.timeLeft = STARTING_TIME;
    self.levelView.timeLeftLabel.text = [NSString stringWithFormat:@"%d",
                                         self.timeLeft];
    
    self.levelView.playerScoreLabel.text = [NSString stringWithFormat:@"%d",
                                            self.player.playerScore];
    
    self.levelView.numberOfAttemptsLeftLabel.text = [NSString stringWithFormat:@"%d",
                                                     self.player.numberOfAttemptsLeft];
    
    self.levelTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                       target:self
                                                     selector:@selector(updateTimer:)
                                                     userInfo:nil
                                                      repeats:YES];

}

- (void)didSelectAnItem:(ItemView *)selectedItem{
    
    ItemView *playerSelectedItem = selectedItem;
    
    [self compareSelectedItemAndRequiredItem:playerSelectedItem
                                requiredItem:self.requiredItem.selectedItem];
}

- (void)compareSelectedItemAndRequiredItem:(ItemView *)selectedItem
                              requiredItem:(RequiredItemView *)requiredItem{
    
    if (selectedItem.itemIdentifier == requiredItem.itemIdentifier) {
        
        NSLog(@"Correct");
        [self.levelTimer invalidate];
        self.player.playerScore += self.player.numberOfAttemptsLeft;
        self.player.numberOfAttemptsLeft = 3;
        
        self.levelView.playerScoreLabel.text = [NSString stringWithFormat:@"%d",
                                                self.player.playerScore];
        
        self.levelView.numberOfAttemptsLeftLabel.text = [NSString stringWithFormat:@"%d",
                                                         self.player.numberOfAttemptsLeft];
        
        [self removeCurrentItems];
    } else {
        
        NSLog(@"Wrong");
        
        if (self.player.numberOfAttemptsLeft > 0) {
            
            self.player.numberOfAttemptsLeft -= 1;
            self.levelView.numberOfAttemptsLeftLabel.text = [NSString stringWithFormat:@"%d",
                                                             self.player.numberOfAttemptsLeft];
        } else {
            [self.levelTimer invalidate];
            [self gameOver];
        }
    }
}

- (void)removeCurrentItems{
    
    [self.itemView viewWillDisappear:YES];
    [self.itemView removeFromParentViewController];
    
    [self.requiredItem viewWillDisappear:YES];
    [self.requiredItem removeFromParentViewController];
    
    [self startNewLevel];
}

- (void)updateTimer:(NSTimer *)timer{
    
    if (self.timeLeft > 0) {
        
        self.timeLeft--;
        self.levelView.timeLeftLabel.text = [NSString stringWithFormat:@"%d", self.timeLeft];
    } else {
        
        [self.levelTimer invalidate];
        [self gameOver];
    }
}

- (void)gameOver{
    
    if (self.highScore) {
        if (self.player.playerScore > self.highScore) {
            
            self.highScore = self.player.playerScore;
            [self writeNewHighScore];
        }
    }
    
    UIAlertView *gameOverAlert = [[UIAlertView alloc]initWithTitle:@"Game Over"
                                                           message:[NSString stringWithFormat:@"Score :%d", self.player.playerScore]
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"Try again", nil];
    
    [gameOverAlert show];
    
    self.player.playerScore = STARTING_PLAYER_SCORE;
    self.player.numberOfAttemptsLeft = STARTING_NUMBER_OF_ATTEMPTS;
    
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{

    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"Try again"]) {
        
        [self removeCurrentItems];
    }
}

- (NSString *)filePath{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *filePath = [paths objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:@"score.json"];
    return filePath;
}

- (void)readCurrentHighScore{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[self filePath]];
    self.highScore = [[dictionary valueForKey:@"highScore"] intValue];
}

- (void)writeNewHighScore{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:self.highScore]
                                                                         forKey:@"highScore"];
    
    [[NSString stringWithFormat:@"%@",dictionary] writeToFile:[self filePath]
                                                   atomically:YES
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
    
}

- (void)dealloc{

    [_levelView release];
    _levelView = nil;
    
    [_itemView release];
    _itemView = nil;
    
    [_requiredItem release];
    _requiredItem = nil;
    
    [_player release];
    _player = nil;
    
    [_levelTimer release];
    _levelTimer = nil;

    [super dealloc];
}
@end
