//
//  ItemViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/22/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "RequiredItemView.h"
#import "ItemViewController.h"
#import "ItemView.h"

@interface ItemViewController () <UIGestureRecognizerDelegate>

@property (retain, nonatomic) NSMutableArray *itemsSelection;

@end

@implementation ItemViewController

#pragma mark - View Life Cycle

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.availableItems = [[NSMutableArray alloc]init];
    
    NSString *filepath = [[NSBundle mainBundle]pathForResource:@"items" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    NSArray *itemsName = [NSJSONSerialization JSONObjectWithData:data
                                                          options:kNilOptions
                                                            error:nil];
    
    self.itemsSelection = [NSMutableArray arrayWithArray:itemsName];
    
    for (int itemCounter = 0; itemCounter < 9; itemCounter++) {
        
        [self.availableItems addObject:[self generateRandomItems:itemCounter]];
    }
    for (ItemView *items in self.availableItems) {
        
        [self.view addSubview:items];
    }
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    for (ItemView *itemView in self.view.subviews) {
        
        itemView.image = nil;
        [itemView release];
    }
}

#pragma mark - Methods for Controlling ItemView

- (ItemView *)generateRandomItems:(int)count{
    
    NSString *filepath = [[NSBundle mainBundle]pathForResource:@"frames" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    NSArray *frames = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:nil];
    
    int randomIndex = arc4random_uniform((uint32_t)[self.itemsSelection count]);
    
    UIImage *image = [UIImage imageNamed:[self.itemsSelection objectAtIndex:randomIndex]];
    
    [self.itemsSelection removeObjectAtIndex:randomIndex];
    
    ItemView *itemView = [[[ItemView alloc]initWithFrame:CGRectFromString([frames objectAtIndex:count])] autorelease];
    
    itemView.itemIdentifier = count;
    itemView.image = image;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self action:@selector(itemViewTapped:)];
    
    [itemView addGestureRecognizer:tapGestureRecognizer];
    
    return itemView;
}

- (void)itemViewTapped:(UITapGestureRecognizer *)gr{
    
    [self.delegate didSelectAnItem:(ItemView *)gr.view];
}

-(void)dealloc{

    [_itemsSelection release];
    _itemsSelection = nil;
    
    [_availableItems release];
    _availableItems = nil;
    
    [super dealloc];
}

@end
