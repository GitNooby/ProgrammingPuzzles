//
//  main.m
//  MergeArraysAandB
//
//  Created by Kai Zou on 2/26/2014.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 given sorted arrays A and B, and A is large enough to also hold B, merge them in sorted order
 */


void mergeAB(int *A, int lenA, int *B, int lenB) {
    
    int totalLen = lenA + lenB - 1;
    
    int j = lenA-1;
    int k = lenB-1;
    for (int i = totalLen; i>=0; i--) {
        printf("A %d  B %d", A[j], B[k]);
        if (A[j] > B[k]) {
            A[i] = A[j];
            printf(" store A:%d", A[j]);
            j--;
        } else {
            if (k!=-1) {
                printf(" store B:%d", B[k]);
                A[i] = B[k];
                k--;
            }

        }
        
        printf("\n");
    }
    
    
}


int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        int lenA = 3;
        int A[] = {1,3, 6, -1, -1};
        int lenB = 2;
        int B[] = {2,4};
        
        mergeAB(A, lenA, B, lenB);
        
        for (int i=0; i<lenA+lenB; i++) {
            printf("%d ", A[i]);
        }
        printf("\n");
        
    }
    return 0;
}

