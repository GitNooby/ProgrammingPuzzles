//
//  main.m
//  challengeTwo
//
//  Created by Kai Zou on 2014-06-06.
//  Copyright (c) 2014 com.yzz. All rights reserved.
//

#import <Foundation/Foundation.h>

int solution(int A, int B) {
    NSString *strA = [NSString stringWithFormat:@"%d", A];
    NSString *strB = [NSString stringWithFormat:@"%d", B];
    
    NSMutableString *strC = [[NSMutableString alloc] initWithString:@""];
    int ptrA = 0;
    int ptrB = 0;
    BOOL workOnA = YES;
    
    do {
        if (workOnA == YES) {
            if (ptrA >= strA.length) {
                workOnA = NO;
                ptrA++;
                continue;
            }
            NSRange r = NSMakeRange(ptrA, 1);
            NSString *charA = [strA substringWithRange:r];
            [strC appendString:charA];
            workOnA = NO;
            ptrA++;
        }
        else {
            if (ptrB >= strB.length) {
                workOnA = YES;
                ptrB++;
                continue;
            }
            NSRange r = NSMakeRange(ptrB, 1);
            NSString *charB = [strB substringWithRange:r];
            [strC appendString:charB];
            workOnA = YES;
            ptrB++;
        }
        
        
    } while (ptrA < strA.length || ptrB < strB.length);
    
    NSLog(@"%d %d", ptrA, ptrB);
    
    
    int C = [strC intValue];
    
    return C;
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        int A = 12;
        int B = 564;
        
        int result = solution(A, B);
        
        NSLog(@"final %d", result);
        
    }
    return 0;
}

