//
//  ItemViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/22/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "ItemViewController.h"
#import "ItemView.h"

NSInteger const MAX_NUMBER_OF_ITEMS = 9;

NSString *const IMAGES_JSON = @"items";
NSString *const FRAMES_JSON = @"frames";

CGRect const REQUIRED_ITEMVIEW_FRAME = {20, 115, 90, 90};

@interface ItemViewController () <UIGestureRecognizerDelegate>

@property (retain, nonatomic) NSMutableArray *availableItems;
@property (retain, nonatomic) NSMutableArray *itemNames;

@end

@implementation ItemViewController

#pragma mark - View Life Cycle

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.availableItems = [[NSMutableArray alloc]init];
    self.itemNames = [[NSMutableArray alloc]initWithArray:[self getDataFromJSONFile:IMAGES_JSON]];
    
    for (int itemCounter = 0; itemCounter < MAX_NUMBER_OF_ITEMS; itemCounter++) {
        
        [self.availableItems addObject:[self generateRandomItems:itemCounter]];
    }
    for (ItemView *items in self.availableItems) {
        
        [self.view addSubview:items];
    }
    
    self.requiredItem = [[ItemView alloc]initwithSelectedItem:
                         [self selectRequiredItemFromAvailableItems:self.availableItems]];
    
    self.requiredItem.frame = REQUIRED_ITEMVIEW_FRAME;
    
    [self.view addSubview:self.requiredItem];
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
    
    NSArray *frames = [[NSArray alloc]initWithArray:[self getDataFromJSONFile:FRAMES_JSON]];
    
    int randomIndex = arc4random_uniform((uint32_t)MAX_NUMBER_OF_ITEMS);
    
    UIImage *image = [UIImage imageNamed:[self.itemNames objectAtIndex:randomIndex]];
    
    [self.itemNames removeObjectAtIndex:randomIndex];
    
    ItemView *itemView = [[[ItemView alloc]initWithFrame:CGRectFromString([frames objectAtIndex:count])] autorelease];
    
    itemView.image = image; 
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self action:@selector(itemViewTapped:)];
    
    [itemView addGestureRecognizer:tapGestureRecognizer];
    
    [tapGestureRecognizer release];
    
    itemView.itemIdentifier = count;
    
    [frames release];
    
    return itemView;
}

- (ItemView *)selectRequiredItemFromAvailableItems:(NSMutableArray *)availableItems{

    int randomIndex = arc4random_uniform((uint32_t)MAX_NUMBER_OF_ITEMS);
    
    return (ItemView *)[self.availableItems objectAtIndex:randomIndex];
    
}

- (void)itemViewTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self.delegate didSelectAnItem:(ItemView *)gestureRecognizer.view];
}

- (NSArray *)getDataFromJSONFile:(NSString *)JSONFileName{

    NSString *filepath = [[NSBundle mainBundle]pathForResource:JSONFileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    NSMutableArray *JSONData = [NSJSONSerialization JSONObjectWithData:data
                                                        options:kNilOptions
                                                          error:nil];
    
    return JSONData;
}

-(void)dealloc{
    
    self.requiredItem = nil;
    
    [super dealloc];
}

@end
