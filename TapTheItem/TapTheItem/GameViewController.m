//
//  ViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/22/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "GameViewController.h"
#import "ItemView.h"
#import "RequiredItemView.h"
#import "ItemViewController.h"
#import "RequiredItemViewController.h"

@interface GameViewController () <ItemViewControllerDelegate>

@property (retain, nonatomic) ItemViewController *itemView;
@property (retain, nonatomic) RequiredItemViewController *requiredItem;

@end

@implementation GameViewController

- (void)viewDidLoad{
 
    [super viewDidLoad];
    [self startALevel];
}

- (void)startALevel{
    
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
        [self startALevel];
    } else {
    
        NSLog(@"Wrong");
    }
}

@end
