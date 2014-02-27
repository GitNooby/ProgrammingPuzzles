//
//  main.m
//  NQueens
//
//  Created by Kai Zou on 2/24/2014.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>

int N = 9;
int *queenAtColOfRow;

bool isSafe(int row) {
    for (int r=0; r<row; r++) {
        int c = queenAtColOfRow[r];
        int col = queenAtColOfRow[row];
        if (c == col) {
            return false;
        } else if (abs(c-col) == abs(r-row)) {
            return false;
        }
    }
    return true;
}

void printBoard() {
    for (int row=0; row<N; row++) {
        int c = queenAtColOfRow[row];
        for (int col=0; col<N; col++) {
            if (c == col) {
                printf("Q ");
            } else {
                printf(". ");
            }
        }
        printf("\n");
    }
    printf("\n");
}

int solveNQueens(int row) {
    if (row == N) {
        printBoard();
        return 1;
    }
    
    int solutionCount = 0;
    for (int col=0; col<N; col++) {
        queenAtColOfRow[row] = col;
        if (isSafe(row) == true) {
            solutionCount += solveNQueens(row + 1);
        }
    }
    return solutionCount;
}

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        queenAtColOfRow = NULL;
        queenAtColOfRow = (int*)malloc(sizeof(int)*N);
        for (int i=0; i<N; i++) {
            queenAtColOfRow[i] = -1;
        }
        
        int solutions = solveNQueens(0);
        
        printf("solutions count:%d\n", solutions);
        
        free(queenAtColOfRow);
    }
    return 0;
}

