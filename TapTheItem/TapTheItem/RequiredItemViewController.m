//
//  RequireItemViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/23/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "RequiredItemViewController.h"
#import "RequiredItemView.h"
#import "ItemViewController.h"
#import "ItemView.h"

@interface RequiredItemViewController ()

@property (retain, nonatomic) RequiredItemView *selectedItem;

@end

@implementation RequiredItemViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self setView:[self generateRequiredItemFromSelectionItems:self.selectionItems]];
    NSLog(@"%d", self.selectedItem.itemIdentifier);
}

- (RequiredItemView *)generateRequiredItemFromSelectionItems:(NSArray *)selectionItems{

    int randomIndex = arc4random_uniform((uint32_t)[selectionItems count]);
    
    self.selectedItem = [[RequiredItemView alloc]initWithItemView:[selectionItems objectAtIndex:randomIndex]];
    
    return self.selectedItem;
}
@end
