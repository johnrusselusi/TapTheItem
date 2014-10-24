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
#import "LevelViewController.h"
#import "PlayerModel.h"

@interface GameViewController ()

@property (retain, nonatomic) LevelViewController *levelView;
@property (retain, nonatomic) PlayerModel *player;
@property (retain, nonatomic) GameView *gameView;

@end

@implementation GameViewController

- (void)viewDidLoad{
 
    [super viewDidLoad];
    
    self.gameView = [[GameView alloc]init];
    
    [self setView:self.gameView];
    
    [self startALevel];
}

- (void)startALevel{
    
    self.levelView = [[LevelViewController alloc]init];
    
    [self.view addSubview:self.levelView.view];
    
    for (ItemView *view in self.levelView.view.subviews) {
        
        [self.view addSubview:view];
    }
}

@end
