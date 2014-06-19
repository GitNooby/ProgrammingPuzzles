//
//  main.m
//  joist01
//
//  Created by Kai Zou on 2014-06-09.
//  Copyright (c) 2014 com.yzz. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL isPalindrome(char *str) {
    
    if (str == NULL) {
        return NO;
    }
    
    
    unsigned long len = strlen(str);
    if (len == 0) {
        return NO;
    }
    char *start = str;
    char *end = str + len -1;
    
    while (start < end) {
        char s = *start;
        char e = *end;
        
        if (s != e) {
            return NO;
        }
        start++;
        end--;
    }
    return YES;
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        char *s = "raceca";
        
        BOOL b = isPalindrome(s);
        if (b) {
            NSLog(@"palindrome!");
        } else {
            NSLog(@"not palindrome!");
        }
        
        
    }
    return 0;
}

