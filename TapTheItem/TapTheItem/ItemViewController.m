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

CGPoint const FIRST_ITEMVIEW = {200, 34};
CGPoint const SECOND_ITEMVIEW = {292, 34};
CGPoint const THIRD_ITEMVIEW = {380, 34};
CGPoint const FOURTH_ITEMVIEW = {200, 125};
CGPoint const FIFTH_ITEMVIEW = {292, 125};
CGPoint const SIXTH_ITEMVIEW = {380, 125};
CGPoint const SEVENTH_ITEMVIEW = {200, 220};
CGPoint const EIGHT_ITEMVIEW = {292, 220};
CGPoint const NINTH_ITEMVIEW = {380, 220};

float const ITEMVIEW_WIDTH = 80;
float const ITEMVIEW_HEIGHT = 80;

@interface ItemViewController () <UIGestureRecognizerDelegate>

@property (retain, nonatomic) NSArray *itemsName;
@property (nonatomic) NSMutableArray *itemsSelection;

@end

@implementation ItemViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.availableItems = [[NSMutableArray alloc]init];
    
    NSString *filepath = [[NSBundle mainBundle]pathForResource:@"items" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    self.itemsName = [NSJSONSerialization JSONObjectWithData:data
                                                          options:kNilOptions
                                                            error:nil];
    
    self.itemsSelection = [NSMutableArray arrayWithArray:self.itemsName];
    
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

- (ItemView *)generateRandomItems:(int)count{
    
    CGRect frame;
    
    int randomIndex = arc4random_uniform((uint32_t)[self.itemsSelection count]);
    
    UIImage *image = [UIImage imageNamed:[self.itemsSelection objectAtIndex:randomIndex]];
    
    [self.itemsSelection removeObjectAtIndex:randomIndex];
    
    if (count == 0) {
        
        frame = CGRectMake(FIRST_ITEMVIEW.x, FIRST_ITEMVIEW.y, ITEMVIEW_WIDTH, ITEMVIEW_HEIGHT);
    } else if (count == 1) {
    
        frame = CGRectMake(SECOND_ITEMVIEW.x, SECOND_ITEMVIEW.y, ITEMVIEW_WIDTH, ITEMVIEW_HEIGHT);
    } else if (count == 2) {
    
        frame = CGRectMake(THIRD_ITEMVIEW.x, THIRD_ITEMVIEW.y, ITEMVIEW_WIDTH, ITEMVIEW_HEIGHT);
    } else if (count == 3) {
    
        frame = CGRectMake(FOURTH_ITEMVIEW.x, FOURTH_ITEMVIEW.y, ITEMVIEW_WIDTH, ITEMVIEW_HEIGHT);
    } else if (count == 4) {
    
         frame = CGRectMake(FIFTH_ITEMVIEW.x, FIFTH_ITEMVIEW.y, ITEMVIEW_WIDTH, ITEMVIEW_HEIGHT);
    } else if (count == 5) {
    
        frame = CGRectMake(SIXTH_ITEMVIEW.x, SIXTH_ITEMVIEW.y, ITEMVIEW_WIDTH, ITEMVIEW_HEIGHT);
    } else if (count == 6) {
    
        frame = CGRectMake(SEVENTH_ITEMVIEW.x, SEVENTH_ITEMVIEW.y, ITEMVIEW_WIDTH, ITEMVIEW_HEIGHT);
    } else if (count == 7) {
    
        frame = CGRectMake(EIGHT_ITEMVIEW.x, EIGHT_ITEMVIEW.y, ITEMVIEW_WIDTH, ITEMVIEW_HEIGHT);
    } else if (count == 8) {
    
        frame = CGRectMake(NINTH_ITEMVIEW.x, NINTH_ITEMVIEW.y, ITEMVIEW_WIDTH, ITEMVIEW_HEIGHT);
    }
    
    ItemView *itemView = [[ItemView alloc]initWithFrame:frame];
    
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
                                                
@end
