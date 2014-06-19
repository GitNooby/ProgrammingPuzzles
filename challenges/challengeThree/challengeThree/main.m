//
//  main.m
//  challengeThree
//
//  Created by Kai Zou on 2014-06-06.
//  Copyright (c) 2014 com.yzz. All rights reserved.
//

#import <Foundation/Foundation.h>

int solution(NSMutableArray *A, int X, int D) {
    if (D >= X) {
        return 0;
    }
    
    int time = -1;

    int currentPosition = 0;
    int remainingDist = X - currentPosition;

    
    for (int second=0; second<A.count; second++) {
        int leafPosition = [[A objectAtIndex:second] intValue];
        if (leafPosition > currentPosition) {
            currentPosition = leafPosition;
            remainingDist = X - currentPosition;
            if (remainingDist <= D) {
                return second;
            }
        }
        
        
    }
    
    
    return time;
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSMutableArray *A = [[NSMutableArray alloc] init];
        A[0] = [NSNumber numberWithInt:1];
        A[1] = [NSNumber numberWithInt:3];
        A[2] = [NSNumber numberWithInt:1];
        A[3] = [NSNumber numberWithInt:4];
        A[4] = [NSNumber numberWithInt:2];
        A[5] = [NSNumber numberWithInt:5];
        
        int result = solution(A, 7, 3);
        
        NSLog(@"result:%d", result);
    }
    return 0;
}

