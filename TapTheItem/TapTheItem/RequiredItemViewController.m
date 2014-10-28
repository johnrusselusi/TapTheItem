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

CGRect const REQUIRED_VIEW_FRAME = {20, 135, 165, 50};

@implementation RequiredItemViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]initWithFrame:REQUIRED_VIEW_FRAME];
    
    [self setView:view];

    self.requiredItems = [[NSMutableArray alloc]init];
    
    for (int itemCount = 0; itemCount < 3; itemCount++) {
        
        [self.requiredItems addObject:[self generateRequiredItemFromSelectionItems:self.selectionItems
                                                                         itemCount:itemCount]];
    }
    for (RequiredItemView *items in self.requiredItems) {
        
        [self.view addSubview:items];
    }
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    for (RequiredItemView *items in self.requiredItems) {
        
        items.image = nil;
        [items release];
    }
}

- (RequiredItemView *)generateRequiredItemFromSelectionItems:(NSArray *)selectionItems
                                                   itemCount:(int)count{

    RequiredItemView *selectedItem = [[[RequiredItemView alloc]init] autorelease];
    
    int randomIndex = arc4random_uniform((uint32_t)[selectionItems count]);
    
    selectedItem = [[RequiredItemView alloc]initWithItemView:[selectionItems objectAtIndex:randomIndex]
                                                        itemCount:count];
    
    [self.selectionItems removeObjectAtIndex:randomIndex];
    
    return selectedItem;
}

- (void)dealloc{

    [_selectionItems release];
    _selectionItems = nil;
    
    [_requiredItems release];
    _requiredItems = nil;
    
    [super dealloc];
}
@end
