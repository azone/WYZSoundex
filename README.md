WYZSoundex
==========

通过Soundex算法来算出英文单词的读音索引，算法描述请参见：[http://en.wikipedia.org/wiki/Soundex](http://en.wikipedia.org/wiki/Soundex)

用法：

```objc
NSArray *wordsToSoundex = @[@"Robert", @"Rupert", @"Rubin", @"Ashcraft", @"Ashcroft", @"Tymczak", @"Pfister", @"Knuth", @"Kant"];
for (NSString *word in wordsToSoundex) {
    NSLog(@"%@'s soundex is: %@", word, [WYZSoundex soundexForWord:word]);
}
```

输出：

```
2014-04-09 22:54:58.934 WYZSoundex[1720:60b] Robert's soundex is: R163
2014-04-09 22:54:58.935 WYZSoundex[1720:60b] Rupert's soundex is: R163
2014-04-09 22:54:58.936 WYZSoundex[1720:60b] Rubin's soundex is: R150
2014-04-09 22:54:58.936 WYZSoundex[1720:60b] Ashcraft's soundex is: A261
2014-04-09 22:54:58.937 WYZSoundex[1720:60b] Ashcroft's soundex is: A261
2014-04-09 22:54:58.937 WYZSoundex[1720:60b] Tymczak's soundex is: T522
2014-04-09 22:54:58.938 WYZSoundex[1720:60b] Pfister's soundex is: P236
2014-04-09 22:54:58.938 WYZSoundex[1720:60b] Knuth's soundex is: K530
2014-04-09 22:54:58.939 WYZSoundex[1720:60b] Kant's soundex is: K530
```
