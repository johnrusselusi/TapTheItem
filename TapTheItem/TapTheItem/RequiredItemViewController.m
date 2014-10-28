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
    
    UIView *view = [[[UIView alloc]initWithFrame:REQUIRED_VIEW_FRAME] autorelease];
    
    [self setView:view];

    self.requiredItems = [[[NSMutableArray alloc]init] autorelease];
    
    for (int itemCount = 0; itemCount < 3; itemCount++) {
        
        [self.requiredItems addObject:[self generateRequiredItemFromAvailableItems:self.displayedItems
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

- (RequiredItemView *)generateRequiredItemFromAvailableItems:(NSArray *)availableItems
                                                   itemCount:(int)count{
    
    int randomIndex = arc4random_uniform((uint32_t)[availableItems count]);
    
    RequiredItemView *selectedItem = [[[RequiredItemView alloc]initWithItemView:[availableItems objectAtIndex:randomIndex]
                                                        itemCount:count] autorelease];
    
    [self.displayedItems removeObjectAtIndex:randomIndex];
    
    return selectedItem;
}

- (void)dealloc{

    [_displayedItems release];
    _displayedItems = nil;
    
    [_requiredItems release];
    _requiredItems = nil;
    
    [super dealloc];
}
@end
