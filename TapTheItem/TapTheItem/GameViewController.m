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
#import "RequiredItemViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad{
 
    [super viewDidLoad];
    
    ItemViewController *itemView = [[ItemViewController alloc]init];
    RequiredItemViewController *requiredItem = [[RequiredItemViewController alloc]init];
    
    [self.view addSubview:itemView.view];
    
    requiredItem.selectionItems = [[NSMutableArray alloc]initWithArray:itemView.availableItems];
    
    [self.view addSubview:requiredItem.view];
}

@end
