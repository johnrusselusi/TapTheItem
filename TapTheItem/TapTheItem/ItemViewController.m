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
@property (retain, nonatomic) NSArray *itemFrames;

@end

@implementation ItemViewController

#pragma mark - Initialize Arrays from JSON

- (void)initializeArrays{

    self.availableItems = [[[NSMutableArray alloc]init] autorelease];
    self.itemNames = [[[NSMutableArray alloc]initWithArray:[self getDataFromJSONFile:IMAGES_JSON]] autorelease];
    self.itemFrames = [[[NSArray alloc]initWithArray:[self getDataFromJSONFile:FRAMES_JSON]] autorelease];
}

- (NSArray *)getDataFromJSONFile:(NSString *)JSONFileName{
    
    NSString *filepath = [[NSBundle mainBundle]pathForResource:JSONFileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    NSMutableArray *JSONData = [NSJSONSerialization JSONObjectWithData:data
                                                               options:kNilOptions
                                                                 error:nil];
    
    return JSONData;
}

#pragma mark - ItemViewController Cycle

- (void)reloadNewItems{
    
    [self initializeArrays];
    
    for (int itemCounter = 0; itemCounter < MAX_NUMBER_OF_ITEMS; itemCounter++) {
        
        [self.availableItems addObject:[self generateRandomItems:itemCounter]];
    }
    for (ItemView *items in self.availableItems) {
        
        [self.view addSubview:items];
    }
    
    self.requiredItem = [[[ItemView alloc]initwithSelectedItem:
                         [self selectRequiredItemFromAvailableItems:self.availableItems]] autorelease];
    
    self.requiredItem.frame = REQUIRED_ITEMVIEW_FRAME;
    
    [self.view addSubview:self.requiredItem];
}

- (void)removeOldItems{

    for (ItemView *item in self.view.subviews) {
        
        [item removeFromSuperview];
    }
}

#pragma mark - Methods for Controlling ItemView

- (ItemView *)generateRandomItems:(int)count{
    
    int randomIndex = arc4random_uniform((uint32_t)MAX_NUMBER_OF_ITEMS);
    
    UIImage *image = [UIImage imageNamed:[self.itemNames objectAtIndex:randomIndex]];
    
    [self.itemNames removeObjectAtIndex:randomIndex];
    
    ItemView *itemView = [[[ItemView alloc]initWithFrame:CGRectFromString([self.itemFrames objectAtIndex:count])] autorelease];
    
    itemView.image = image; 
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self action:@selector(itemViewTapped:)];
    
    [itemView addGestureRecognizer:tapGestureRecognizer];
    
    [tapGestureRecognizer release];
    
    itemView.itemIdentifier = count;
    
    return itemView;
}

- (ItemView *)selectRequiredItemFromAvailableItems:(NSMutableArray *)availableItems{

    int randomIndex = arc4random_uniform((uint32_t)MAX_NUMBER_OF_ITEMS);
    
    return (ItemView *)[self.availableItems objectAtIndex:randomIndex];
    
}

- (void)itemViewTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self.delegate didSelectAnItem:(ItemView *)gestureRecognizer.view];
}

-(void)dealloc{
    
    self.itemFrames = nil;
    self.requiredItem = nil;
    self.availableItems = nil;
    self.itemNames = nil;
    
    [super dealloc];
}

@end
