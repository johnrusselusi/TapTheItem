//
//  ViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/22/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "GameViewController.h"
#import "ItemView.h"
#import "ItemViewController.h"

@interface GameViewController ()

@property (retain, nonatomic) NSMutableArray *availableItems;

@end

@implementation GameViewController

- (void)viewDidLoad{
 
    ItemViewController *itemView = [[ItemViewController alloc]init];
    
    [self.view addSubview:itemView.view];
}

@end
