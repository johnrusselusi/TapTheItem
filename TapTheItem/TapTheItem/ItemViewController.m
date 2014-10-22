//
//  ItemViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/22/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "ItemViewController.h"
#import "ItemView.h"

@interface ItemViewController ()

@property (retain, nonatomic) NSArray *itemsName;
@property (nonatomic) NSMutableArray *itemsSelection;

@end

@implementation ItemViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    NSString *filepath = [[NSBundle mainBundle]pathForResource:@"items" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    self.itemsName = [NSJSONSerialization JSONObjectWithData:data
                                                          options:kNilOptions
                                                            error:nil];
    
    self.itemsSelection = [NSMutableArray arrayWithArray:self.itemsName];
    
    [self setView:[self generateRandomFoods]];
}

- (ItemView *)generateRandomFoods{
    
    int randomIndex = arc4random_uniform((uint32_t)[self.itemsSelection count]);
    
    UIImage *image = [UIImage imageNamed:[self.itemsSelection objectAtIndex:randomIndex]];
    [self.itemsSelection removeObjectAtIndex:randomIndex];
    
    ItemView *itemView = [[ItemView alloc]initWithImage:image];
    
    return itemView;
}

@end
