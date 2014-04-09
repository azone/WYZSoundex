//
//  WYZSoundex.h
//  WYZSoundex
//
//  Created by Yozone Wang on 14-4-9.
//  Copyright (c) 2014年 Yozone Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYZSoundex : NSObject

+ (instancetype)sharedSoundex;

+ (NSString *)soundexForWord:(NSString *)wordString;

- (NSString *)soundexForWord:(NSString *)wordString;

@end
