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

int const DEFAULT_TIME = 5;

@interface LevelViewController () <ItemViewControllerDelegate>

@property (retain, nonatomic) LevelView *levelView;
@property (retain, nonatomic) ItemViewController *itemView;
@property (retain, nonatomic) RequiredItemViewController *requiredItem;
@property (retain, nonatomic) ItemView *playerSelectedItem;
@property (retain, nonatomic) PlayerModel *player;

@end

@implementation LevelViewController

- (void)viewDidLoad{

    [super viewDidLoad];
    
    self.player = [[PlayerModel alloc]init];
    
    self.levelView = [[LevelView alloc]init];
    [self setView:self.levelView];
    
    [self initializeNewLevel];
}

- (void)initializeNewLevel{
    
    self.timeLeft = DEFAULT_TIME;
    
    self.levelView.timeLeftLabel.text = [NSString stringWithFormat:@"%d",
                                         self.timeLeft];
    
    self.levelView.playerScoreLabel.text = [NSString stringWithFormat:@"%d",
                                            self.player.playerScore];
    
    self.levelView.numberOfAttemptsLeftLabel.text = [NSString stringWithFormat:@"%d",
                                                     self.player.numberOfAttemptsLeft];
    
    self.itemView = [[ItemViewController alloc]init];
    self.requiredItem = [[RequiredItemViewController alloc]init];
    
    self.itemView.delegate = self;
    
    [self.view addSubview:self.itemView.view];
    
    self.requiredItem.selectionItems = [[NSMutableArray alloc]initWithArray:self.itemView.availableItems];
    
    [self.view addSubview:self.requiredItem.view];
    
    self.levelTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                       target:self
                                                     selector:@selector(updateTimer:)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)updateTimer:(NSTimer *)timer{

    if (self.timeLeft > 0) {
        
        self.timeLeft--;
        self.levelView.timeLeftLabel.text = [NSString stringWithFormat:@"%d", self.timeLeft];
    } else {
    
        NSLog(@"Gameover");
        [self.levelTimer invalidate];
        self.levelTimer = nil;
    }
}

- (void)didSelectAnItem:(ItemView *)selectedItem{

    self.playerSelectedItem = selectedItem;
    [self compareSelectedItemAndRequiredItem:self.playerSelectedItem
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
        
        [self prepareViewForReload];
    } else {
    
        NSLog(@"Wrong");
        
        if (self.player.numberOfAttemptsLeft > 0) {
            
            self.player.numberOfAttemptsLeft -= 1;
            self.levelView.numberOfAttemptsLeftLabel.text = [NSString stringWithFormat:@"%d",
                                                             self.player.numberOfAttemptsLeft];
        } else {
            [self.levelTimer invalidate];
            NSLog(@"Gameover");
        }
    }
}

- (void)prepareViewForReload{

    [self.itemView viewWillDisappear:YES];
    [self.itemView removeFromParentViewController];
    
    [self.requiredItem viewWillDisappear:YES];
    [self.requiredItem removeFromParentViewController];
    
    [self initializeNewLevel];
}
@end
