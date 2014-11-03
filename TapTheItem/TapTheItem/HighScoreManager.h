//
//  HighScoreManager.h
//  TapTheItem
//
//  Created by John Russel Usi on 11/3/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighScoreManager : NSObject

+ (NSInteger)getCurrentHighScore;
+ (void)writeNewHighScore:(NSInteger)score;

@end
