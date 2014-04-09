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

@property (strong, nonatomic) NSCharacterSet *soundex0CharacterSet;
@property (strong, nonatomic) NSCharacterSet *soundex1CharacterSet;
@property (strong, nonatomic) NSCharacterSet *soundex2CharacterSet;
@property (strong, nonatomic) NSCharacterSet *soundex3CharacterSet;
@property (strong, nonatomic) NSCharacterSet *soundex4CharacterSet;
@property (strong, nonatomic) NSCharacterSet *soundex5CharacterSet;
@property (strong, nonatomic) NSCharacterSet *soundex6CharacterSet;

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
        self.soundex0CharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"aeiouyhw"];
        self.soundex1CharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"bfpv"];
        self.soundex2CharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"cgjkqsxz"];
        self.soundex3CharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"dt"];
        self.soundex4CharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"l"];
        self.soundex5CharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"mn"];
        self.soundex6CharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"r"];
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
    for (int i = 0; i < wordLength; i++) {
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
    if ([self.soundex0CharacterSet characterIsMember:character]) {
        return 0;
    }
    if ([self.soundex1CharacterSet characterIsMember:character]) {
        return 1;
    }
    if ([self.soundex2CharacterSet characterIsMember:character]) {
        return 2;
    }
    if ([self.soundex3CharacterSet characterIsMember:character]) {
        return 3;
    }
    if ([self.soundex4CharacterSet characterIsMember:character]) {
        return 4;
    }
    if ([self.soundex5CharacterSet characterIsMember:character]) {
        return 5;
    }
    if ([self.soundex6CharacterSet characterIsMember:character]) {
        return 6;
    }
    return 0;
}

@end
