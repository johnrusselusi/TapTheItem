//
//  MainViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/27/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "MainViewController.h"
#import "LevelViewController.h"

@interface MainViewController ()

@property (retain, nonatomic) IBOutlet UILabel *highScore;
@property (retain, nonatomic) LevelViewController *levelViewController;

@end

@implementation MainViewController

- (IBAction)startButtonPressed:(id)sender {
    
    self.levelViewController = [[[LevelViewController alloc]init] autorelease];
    
    [self.navigationController pushViewController:self.levelViewController animated:NO];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.highScore.text = [NSString stringWithFormat:@"%ld", (long)self.levelViewController.highScore];
}

- (void)dealloc {
    
    self.levelViewController = nil;
    self.highScore = nil;
    
    [super dealloc];
}
@end
