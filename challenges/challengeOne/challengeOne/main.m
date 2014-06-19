//
//  main.m
//  challengeOne
//
//  Created by Kai Zou on 2014-06-06.
//  Copyright (c) 2014 com.yzz. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString * solution(NSString *S) {
    if (S == nil) {
        return nil;
    } else if (S.length == 0 || S.length == 1) {
        return S;
    }
    
    NSMutableString *input = [NSMutableString stringWithString:S];
    
    for (int i=0; i<input.length-1; i++) {
        NSRange range = NSMakeRange(i, 2);
        NSString *twoChars = [input substringWithRange:range];
        
        if ([twoChars caseInsensitiveCompare:@"AB"] == NSOrderedSame) {
            [input replaceCharactersInRange:range withString:@"AA"];
            NSLog(@"case 1: %@ %d", input, i);
            i = -1;

        } else if ([twoChars caseInsensitiveCompare:@"BA"] == NSOrderedSame) {
            [input replaceCharactersInRange:range withString:@"AA"];
            NSLog(@"case 2: %@ %d", input, i);
            i = -1;

        } else if ([twoChars caseInsensitiveCompare:@"CB"] == NSOrderedSame) {
            [input replaceCharactersInRange:range withString:@"CC"];
            NSLog(@"case 3: %@ %d", input, i);
            i = -1;
        } else if ([twoChars caseInsensitiveCompare:@"BC"] == NSOrderedSame) {
            [input replaceCharactersInRange:range withString:@"CC"];
            NSLog(@"case 4: %@ %d", input, i);
            i = -1;
        } else if ([twoChars caseInsensitiveCompare:@"AA"] == NSOrderedSame) {
            [input replaceCharactersInRange:range withString:@"A"];
            NSLog(@"case 5: %@ %d", input, i);
            i = -1;
        } else if ([twoChars caseInsensitiveCompare:@"CC"] == NSOrderedSame) {
            [input replaceCharactersInRange:range withString:@"C"];
            NSLog(@"case 6: %@ %d", input, i);
            i = -1;
        }
    }
    
    return input;
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSString *input = @"ABBCC";
        
        
        NSString *output = solution(input);
        NSLog(@"final %@", output);
        
    }
    return 0;
}

