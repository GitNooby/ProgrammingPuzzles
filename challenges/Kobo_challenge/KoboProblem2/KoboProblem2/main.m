//
//  main.m
//  KoboProblem2
//
//  Created by Kai Zou on 2014-06-19.
//  Copyright (c) 2014 com.zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdlib.h>

int* countingSort(int *inArray, int len) {
    int *outArray = (int*)malloc(sizeof(int) * len);
    
    int counterArray[3] = {0, 0, 0};
    
    // count the number of each type of element
    for (int i=0; i<len; i++) {
        int element = inArray[i];
        int bucketNumber = element - 1;
        counterArray[bucketNumber]++;
    }
    
    // populate the sorted array
    int index = 0;
    for (int i=0; i<3; i++) {
        int element = i + 1;
        for (int j=counterArray[i]; j>0; j--) {
            outArray[index] = element;
            index++;
        }
    }
    
    return outArray;
}


int main(int argc, const char * argv[])
{
    
    // create a random length array that at most 50 in length, and at least 1 in length
    int randomArrayLength = arc4random() % 50 + 1;
    int *testArray = (int*)malloc(sizeof(randomArrayLength));
    // populate the array
    for (int i=0; i<randomArrayLength; i++) {
        int randomNumber = arc4random() % 3 + 1;
        testArray[i] = randomNumber;
    }
    
    // print the input for reference:
    printf("input array:\n");
    for (int i=0; i<randomArrayLength; i++) {
        printf("%d", testArray[i]);
        if (i<randomArrayLength) {
            printf(", ");
        }
    }
    printf("\n");
    
    // do the sort
    int *sortedArray = countingSort(testArray, randomArrayLength);
    
    // print the output for reference
    printf("output array:\n");
    for (int i=0; i<randomArrayLength; i++) {
        printf("%d", sortedArray[i]);
        if (i<randomArrayLength) {
            printf(", ");
        }
    }
    printf("\ndone\n");
    
    // clean up
    free(sortedArray);
    free(testArray);
    
    return 0;
}

