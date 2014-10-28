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

@implementation RequiredItemViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.requiredItems = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 3; i++) {
        
        [self.requiredItems addObject:[self generateRequiredItemFromSelectionItems:self.selectionItems itemCount:i]];
    }
    for (RequiredItemView *items in self.requiredItems) {
        
        [self.view addSubview:items];
    }
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    for (RequiredItemView *items in self.requiredItems) {
        
        items.image = [UIImage imageNamed:@""];
    }
}

- (RequiredItemView *)generateRequiredItemFromSelectionItems:(NSArray *)selectionItems itemCount:(int)count{

    int randomIndex = arc4random_uniform((uint32_t)[selectionItems count]);
    
    self.selectedItem = [[RequiredItemView alloc]initWithItemView:[selectionItems objectAtIndex:randomIndex]
                                                        itemCount:count];
    
    [self.selectionItems removeObjectAtIndex:randomIndex];
    
    return self.selectedItem;
}

- (void)dealloc{

    [_selectionItems release];
    _selectionItems = nil;
    
    [_selectedItem release];
    _selectedItem = nil;
    
    [_requiredItems release];
    _requiredItems = nil;
    
    [super dealloc];
}
@end
