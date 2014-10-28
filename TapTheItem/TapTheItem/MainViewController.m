//
//  MainViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/27/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "MainViewController.h"
#import "GameViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (IBAction)startButtonPressed:(id)sender {
    
    GameViewController *gameView = [[[GameViewController alloc]init] autorelease];
    
    gameView.navigationController.navigationBarHidden = YES;
    
    [self.navigationController pushViewController:gameView animated:NO];
}

@end
