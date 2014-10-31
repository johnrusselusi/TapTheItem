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
NSString *const JSON_FILE_TYPE = @"json";

CGRect const REQUIRED_ITEMVIEW_FRAME = {20, 115, 90, 90};

@interface ItemViewController () <UIGestureRecognizerDelegate>

@property (retain, nonatomic) NSMutableArray *availableItems;
@property (retain, nonatomic) NSArray *itemFrames;
@property (retain, nonatomic) NSMutableArray *itemNames;

@end

@implementation ItemViewController

- (instancetype)init{

    self = [super init];
    
    if (self) {
        
        [self initializeArrays];
    }
    
    return self;
}

#pragma mark - Initialize Arrays from JSON

- (void)initializeArrays{
    
    self.availableItems = [[[NSMutableArray alloc]init] autorelease];
    self.itemFrames = [[[NSArray alloc]initWithArray:[self getDataFromFileNamed:FRAMES_JSON
                                                                       fileType:JSON_FILE_TYPE]] autorelease];
}

- (NSArray *)getDataFromFileNamed:(NSString *)fileName fileType:(NSString *)fileType{
    
    NSString *filepath = [[NSBundle mainBundle]pathForResource:fileName ofType:fileType];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    NSMutableArray *JSONData = [NSJSONSerialization JSONObjectWithData:data
                                                               options:kNilOptions
                                                                 error:nil];
    
    
    return JSONData;
}

#pragma mark - ItemViewController Cycle

- (void)reloadNewItems{
    
    self.itemNames = [NSMutableArray arrayWithArray:[self getDataFromFileNamed:IMAGES_JSON
                                                                      fileType:JSON_FILE_TYPE]];
    
    //  Store random generated items into availableItems array
    for (int itemCounter = 0; itemCounter < MAX_NUMBER_OF_ITEMS; itemCounter++) {
        
        [self.availableItems addObject:[self generateRandomItems:itemCounter]];
    }
    
    //  Add every items as subview of the ItemViewController
    for (ItemView *items in self.availableItems) {
        
        [self.view addSubview:items];
    }
    
    //  Generate a required item from the availableItems array
    self.requiredItem = [[[ItemView alloc]initwithSelectedItem:
                         [self selectRequiredItemFromAvailableItems]] autorelease];
    
    //  Add the generated requiredItem as subview of the ItemViewController
    self.requiredItem.frame = REQUIRED_ITEMVIEW_FRAME;
    
    [self.view addSubview:self.requiredItem];
}

- (void)removeOldItems{
    
    //  Remove all generated items from previous level
    [self.availableItems removeAllObjects];
    
    for (ItemView *item in self.view.subviews) {
        
        [item removeFromSuperview];
    }
}

#pragma mark - Methods for Controlling ItemView

- (ItemView *)generateRandomItems:(int)count{
    
    //  Get a randomIndex
    NSInteger randomIndex = [self generateRandomNumber];
    
    //  Create an image from the itemNames array
    UIImage *image = [UIImage imageNamed:[self.itemNames objectAtIndex:randomIndex]];
    
    [self.itemNames removeObjectAtIndex:randomIndex];
    
    //  Create an itemView instance with frames from the itemFrames array
    NSString *frameRect = [NSString stringWithString:[self.itemFrames objectAtIndex:count]];
    
    ItemView *itemView = [[[ItemView alloc]initWithFrame:CGRectFromString(frameRect)] autorelease];
    
    itemView.image = image;
    
    //  Add a gesture recognizer for the itemView
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self action:@selector(itemViewTapped:)];
    
    [itemView addGestureRecognizer:tapGestureRecognizer];
    
    [tapGestureRecognizer release];
    
    //  Set the itemIdentifier of the itemView
    itemView.itemIdentifier = count;
    
    return itemView;
}

- (ItemView *)selectRequiredItemFromAvailableItems{
    
    //  Return a random itemView from the availableItems array
    return (ItemView *)[self.availableItems objectAtIndex:[self generateRandomNumber]];
}

- (void)itemViewTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    //  Event when an item is tapped by the user
    [self.delegate didSelectAnItem:(ItemView *)gestureRecognizer.view];
}

- (NSInteger)generateRandomNumber{

    NSInteger randomIndex = arc4random_uniform((uint32_t)MAX_NUMBER_OF_ITEMS);
    
    return randomIndex;
}

-(void)dealloc{
    
    self.itemFrames = nil;
    self.requiredItem = nil;
    self.availableItems = nil;
    self.itemNames = nil;

    [super dealloc];
}

@end
