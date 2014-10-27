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

CGRect const FIRST_ITEMVIEW_FRAME = {200, 34, 80, 80};
CGRect const SECOND_ITEMVIEW_FRAME = {292, 34, 80, 80};
CGRect const THIRD_ITEMVIEW_FRAME = {380, 34, 80, 80};
CGRect const FOURTH_ITEMVIEW_FRAME = {200, 125, 80, 80};
CGRect const FIFTH_ITEMVIEW_FRAME = {292, 125, 80, 80};
CGRect const SIXTH_ITEMVIEW_FRAME = {380, 125, 80, 80};
CGRect const SEVENTH_ITEMVIEW_FRAME = {200, 220, 80, 80};
CGRect const EIGHT_ITEMVIEW_FRAME = {292, 220, 80, 80};
CGRect const NINTH_ITEMVIEW_FRAME = {380, 220, 80, 80};

@interface ItemViewController () <UIGestureRecognizerDelegate>

@property (nonatomic) NSMutableArray *itemsSelection;

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
    
    for (int i = 0; i < 9; i++) {
        
        [self.availableItems addObject:[self generateRandomItems:i]];
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
    
    CGRect frame;
    
    int randomIndex = arc4random_uniform((uint32_t)[self.itemsSelection count]);
    
    UIImage *image = [UIImage imageNamed:[self.itemsSelection objectAtIndex:randomIndex]];
    
    [self.itemsSelection removeObjectAtIndex:randomIndex];
    
    if (count == 0) {
        
        frame = FIRST_ITEMVIEW_FRAME;
    } else if (count == 1) {
    
        frame = SECOND_ITEMVIEW_FRAME;
    } else if (count == 2) {
    
        frame = THIRD_ITEMVIEW_FRAME;
    } else if (count == 3) {
    
        frame = FOURTH_ITEMVIEW_FRAME;
    } else if (count == 4) {
    
        frame = FIFTH_ITEMVIEW_FRAME;
    } else if (count == 5) {
    
        frame = SIXTH_ITEMVIEW_FRAME;
    } else if (count == 6) {
    
        frame = SEVENTH_ITEMVIEW_FRAME;
    } else if (count == 7) {
    
        frame = EIGHT_ITEMVIEW_FRAME;
    } else if (count == 8) {
    
        frame = NINTH_ITEMVIEW_FRAME;
    }
    
    ItemView *itemView = [[[ItemView alloc]initWithFrame:frame] autorelease];
    
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
    
    [_delegate release];
    _delegate = nil;
    
    [_availableItems release];
    _availableItems = nil;
    
    [super dealloc];
}

@end
