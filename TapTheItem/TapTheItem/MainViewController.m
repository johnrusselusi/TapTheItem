//
//  MainViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/27/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "MainViewController.h"
#import "LevelViewController.h"
#import "HighScoreManager.h"

@interface MainViewController ()

@property (retain, nonatomic) IBOutlet UILabel *highScore;

@end

@implementation MainViewController

- (IBAction)startButtonPressed:(id)sender {
    
    LevelViewController *levelViewController = [[[LevelViewController alloc]init] autorelease];
    
    [self.navigationController pushViewController:levelViewController animated:NO];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.highScore.text = [NSString stringWithFormat:@"%ld", (long)[HighScoreManager getCurrentHighScore]];
}

- (void)dealloc {
    
    self.highScore = nil;
    
    [super dealloc];
}
@end
