//
//  main.m
//  FindMaximumSumSubarry
//
//  Created by Kai Zou on 2/27/2014.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#import <Foundation/Foundation.h>

int findMaxSumInSubarry(int *a, int lena) {
    
    int finalMax = 0;
    int curMax = 0;
    
    for (int i=0; i<lena; i++) {
        
        int sum = curMax + a[i];
        if (curMax < 0) {
            curMax = a[i];
        } else {
            curMax = sum;
        }
        
        if (curMax > finalMax) {
            finalMax = curMax;
        }
        
    }
    
    return finalMax;
}

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        int A[] = {-1,-1,-1,1,1,1,-1,1,1,1,-1,-2,-3};
        int lenA = 12;
        
        int maxsum = findMaxSumInSubarry(A, lenA);
        
        printf("mas sum:%d\n", maxsum);
    }
    return 0;
}

