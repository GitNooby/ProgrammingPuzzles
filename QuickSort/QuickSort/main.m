//
//  main.m
//  QuickSort
//
//  Created by Kai Zou on 2/26/2014.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#import <Foundation/Foundation.h>


void quickSort(int *A, int start, int end) {
    if (start<end) {

    
        int pivot = A[end];
        int i = start-1;
        
        for (int j = start; j<end-1; j++) {
            if (A[j] < pivot) {
                i++;
                int temp = A[i];
                A[i] = A[j];
                A[j] = temp;
            }
        }
        
        int temp = A[i+1];
        A[i+1] = A[end];
        A[end] = temp;
        
        int q = i+1;
        
        quickSort(A, start, q-1);
        quickSort(A, q+1, end);
    }
    
    
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {

        int lenA = 12;
        int A[] = {3,4,5,2,6,7,2,67,2,8,987,-45};

        quickSort(A, 0, lenA-1);
        
        for (int i=0; i<lenA; i++) {
            printf("%d ", A[i]);
        }
        printf("\n");
        
    }
    return 0;
}

