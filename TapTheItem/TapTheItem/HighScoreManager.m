//
//  HighScoreManager.m
//  TapTheItem
//
//  Created by John Russel Usi on 11/3/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "HighScoreManager.h"

NSInteger const FIRST_INDEX = 0;

NSString *const JSON_PATH = @"score.json";
NSString *const HIGHSCORE_KEY = @"highScore";

@implementation HighScoreManager

+ (NSString *)filePath{
    
    //  Method for getting the filepath
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *filePath = [paths objectAtIndex:FIRST_INDEX];
    filePath = [filePath stringByAppendingPathComponent:JSON_PATH];
    return filePath;
}

+ (NSInteger)getCurrentHighScore{
        
    //  Method for reading the stored highscore
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[self filePath]];
    return [[dictionary valueForKey:HIGHSCORE_KEY] integerValue];
}

+ (void)writeNewHighScore:(NSInteger)score{
    
    //  Method for storing a new highscore
    NSMutableDictionary *scoreDictionary = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInteger:score]
                                                                              forKey:HIGHSCORE_KEY];
    
    [[NSString stringWithFormat:@"%@", scoreDictionary] writeToFile:[self filePath]
                                                         atomically:YES
                                                           encoding:NSUTF8StringEncoding
                                                              error:nil];
    
}

@end
