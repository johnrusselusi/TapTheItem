//
//  ViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/22/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "GameViewController.h"
#import "GameView.h"
#import "ItemView.h"
#import "RequiredItemView.h"
#import "ItemViewController.h"
#import "RequiredItemViewController.h"
#import "PlayerModel.h"

@interface GameViewController () <ItemViewControllerDelegate>

@property (retain, nonatomic) ItemViewController *itemView;
@property (retain, nonatomic) RequiredItemViewController *requiredItem;
@property (retain, nonatomic) PlayerModel *player;
@property (retain, nonatomic) GameView *gameView;

@end

@implementation GameViewController

- (void)viewDidLoad{
 
    [super viewDidLoad];
    
    self.gameView = [[GameView alloc]init];
    
    [self setView:self.gameView];
    
    self.player = [[PlayerModel alloc]init];
    [self startALevel];
}

- (void)startALevel{
    
    self.gameView.playerScoreLabel.text = [NSString stringWithFormat:@"%d", self.player.playerScore];
    self.gameView.numberOfAttemptsLeftLabel.text = [NSString stringWithFormat:@"%d", self.player.numberOfAttemptsLeft];
    
    self.itemView = [[ItemViewController alloc]init];
    self.requiredItem = [[RequiredItemViewController alloc]init];
    
    self.itemView.delegate = self;
    
    [self.view addSubview:self.itemView.view];
    
    self.requiredItem.selectionItems = [[NSMutableArray alloc]initWithArray:self.itemView.availableItems];
    
    [self.view addSubview:self.requiredItem.view];
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
        
        [self.itemView viewWillDisappear:YES];
        [self.itemView removeFromParentViewController];
        
        [self.requiredItem viewWillDisappear:YES];
        [self.requiredItem removeFromParentViewController];
        
        [self.player playerDidSelectCorrectAnswer];
        NSLog(@"Score :%d", self.player.playerScore);
        [self startALevel];
    } else {
    
        NSLog(@"Wrong");
        [self.player playerDidSelectWrongAnswer];
        NSLog(@"Attempts left: %d", self.player.numberOfAttemptsLeft);
        self.gameView.numberOfAttemptsLeftLabel.text = [NSString stringWithFormat:@"%d", self.player.numberOfAttemptsLeft];
    }
}

@end
