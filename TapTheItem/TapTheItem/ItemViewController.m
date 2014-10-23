//
//  ItemViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/22/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "ItemViewController.h"
#import "ItemView.h"

CGPoint const FIRST_ITEMVIEW = {20, 62};
CGPoint const SECOND_ITEMVIEW = {88, 62};
CGPoint const THIRD_ITEMVIEW = {156, 62};
CGPoint const FOURTH_ITEMVIEW = {20, 130};
CGPoint const FIFTH_ITEMVIEW = {88, 130};
CGPoint const SIXTH_ITEMVIEW = {156, 130};
CGPoint const SEVENTH_ITEMVIEW = {20, 198};
CGPoint const EIGHT_ITEMVIEW = {88, 198};
CGPoint const NINTH_ITEMVIEW = {156, 198};

float const ITEMVIEW_WIDTH = 60;
float const ITEMVIEW_HEIGHT = 60;

@interface ItemViewController ()

@property (retain, nonatomic) NSArray *itemsName;
@property (nonatomic) NSMutableArray *itemsSelection;
@property (retain, nonatomic) NSMutableArray *availableItems;
@property (retain, nonatomic) ItemView *itemView;

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
    
    NSLog(@"%@", self.itemsName);
    
    self.itemsSelection = [NSMutableArray arrayWithArray:self.itemsName];
    
    for (int i = 0; i < 9; i++) {
        
        [self.availableItems addObject:[self generateRandomItems:i]];
    }
    for (ItemView *items in self.availableItems) {
        
        [self.view addSubview:items];
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
    itemView.image = image;
    
    return itemView;
}

@end
