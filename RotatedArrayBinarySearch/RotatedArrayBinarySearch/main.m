//
//  main.m
//  RotatedArrayBinarySearch
//
//  Created by Kai Zou on 2/26/2014.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#import <Foundation/Foundation.h>


int rotatedBinarySearch(int *A, int lenA, int val) {
    int start = 0;
    int end = lenA-1;
    
    while (start <= end) {
        int mid = (start+end)/2;
        if (val == A[mid]) {
            return mid;
        }
        else if (A[start] < A[mid]) {
            if (val > A[mid]) {
                start = mid+1;
            } else if (val >= A[start]) {
                end = mid-1;
            } else {
                start = mid+1;
            }
        } else if (val < A[mid]) {
                end = mid-1;
            } else if (val <= A[end]) {
                start = mid+1;
            } else {
                end = mid-1;
            }
    }
    return -1;
}

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        int A[] = {6,7,8,9,1,2,3,4,5};
        int lenA = 9;
        
        int index = rotatedBinarySearch(A, lenA, 5);
        printf("index:%d", index);
        
    }
    return 0;
}

