//
//  ViewController.m
//  TapTheItem
//
//  Created by John Russel Usi on 10/22/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "ViewController.h"
#import "ItemView.h"
#import "ItemViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{

    ItemViewController *itemView = [[ItemViewController alloc]init];
    
    [self.view addSubview:itemView.view];
}

@end
