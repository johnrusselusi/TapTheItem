//
//  ViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/22/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "GameViewController.h"
#import "ItemView.h"
#import "LevelViewController.h"

@implementation GameViewController

- (void)viewDidLoad{
 
    [super viewDidLoad];
    
    [self startALevel];
}

- (void)startALevel{
    
    LevelViewController *levelView = [[[LevelViewController alloc]init] autorelease];

    [self.view addSubview:levelView.view];
    
    for (ItemView *view in levelView.view.subviews) {
        
        [self.view addSubview:view];
    }
}

@end
