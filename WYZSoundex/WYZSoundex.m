//
//  WYZSoundex.m
//  WYZSoundex
//
//  算法详见：http://en.wikipedia.org/wiki/Soundex
//
//  Created by Yozone Wang on 14-4-9.
//  Copyright (c) 2014年 Yozone Wang. All rights reserved.
//

#import "WYZSoundex.h"

@interface WYZSoundex ()

@property (strong, nonatomic) NSArray *soundexCharacterSetArray;

@end

@implementation WYZSoundex

+ (instancetype)sharedSoundex {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initSingleton];
    });
    return sharedInstance;
}

- (id)init {
    NSAssert(NO, @"Cannot create instance of Singleton");
    return nil;
}

- (id)initSingleton {
    self = [super init];
    if (self) {
        self.soundexCharacterSetArray = @[
            [NSCharacterSet characterSetWithCharactersInString:@"aeiouyhw"],
            [NSCharacterSet characterSetWithCharactersInString:@"bfpv"],
            [NSCharacterSet characterSetWithCharactersInString:@"cgjkqsxz"],
            [NSCharacterSet characterSetWithCharactersInString:@"dt"],
            [NSCharacterSet characterSetWithCharactersInString:@"l"],
            [NSCharacterSet characterSetWithCharactersInString:@"mn"],
            [NSCharacterSet characterSetWithCharactersInString:@"r"]
        ];
    }
    return self;
}

+ (NSString *)soundexForWord:(NSString *)wordString {
    return [[self sharedSoundex] soundexForWord:wordString];
}

- (NSString *)soundexForWord:(NSString *)wordString {
    NSString *trimmedWordString = [wordString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    trimmedWordString = [trimmedWordString lowercaseString];
    if (!trimmedWordString || [trimmedWordString isEqualToString:@""]) {
        return nil;
    }
    NSMutableString *soundexMutableString = [NSMutableString stringWithString:[trimmedWordString substringToIndex:1]];
    NSUInteger wordLength = [trimmedWordString length];
    unichar previousCharacter = 0;
    NSInteger previousCharacterSoundex = 0;
    for (NSUInteger i = 0; i < wordLength; i++) {
        if (i == 0) {
            previousCharacter = [trimmedWordString characterAtIndex:i];
            previousCharacterSoundex = [self soundexForCharacter:previousCharacter];
            continue;
        }
        unichar character = [trimmedWordString characterAtIndex:i];
        NSInteger characterSoundex = [self soundexForCharacter:character];
        if (previousCharacterSoundex != characterSoundex && (previousCharacter != 'h' && previousCharacter != 'w') && characterSoundex != 0) {
            [soundexMutableString appendFormat:@"%d", characterSoundex];
        }
        previousCharacterSoundex = characterSoundex;
        previousCharacter = character;
    }
    NSString *soundexString = [[soundexMutableString stringByPaddingToLength:4 withString:@"0" startingAtIndex:0] uppercaseString];
    return [soundexString substringToIndex:4];
}

- (NSInteger)soundexForCharacter:(unichar)character {
    __block NSInteger soundex = 0;
    [self.soundexCharacterSetArray enumerateObjectsWithOptions:NSEnumerationConcurrent
                                                    usingBlock:^(NSCharacterSet *characterSet, NSUInteger idx, BOOL *stop) {
                                                        if ([characterSet characterIsMember:character]) {
                                                            soundex = idx;
                                                            *stop = YES;
                                                        }
                                                    }];
    return soundex;
}

@end
