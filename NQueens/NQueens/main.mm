//
//  main.m
//  NQueens
//
//  Created by Kai Zou on 2/24/2014.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>

int N = 4;
char **board;

void printBoard() {
    for (int i=0; i<N; i++) {
        for (int j=0; j<N; j++) {
            printf("%c", board[j][i]);
        }
        printf("\n");
    }
}

bool safe(char **board, int col, int row) {
    for (int i=0; i<N; i++) {
        for (int j=0; j<N; j++) {
            char c = board[j][i];
            if (j == row && c == 'x') {
                return false;
            }
            if (i == col && c == 'x') {
                return false;
            }
        }
    }
    return true;
}

void solveNQueens(char **board, int rows) {
    if (rows == N) {
        printBoard();
        printf("\n");
        return;
    }
    
    for (int i=0; i<N; i++) {
        if (safe(board, i, rows)) {
            board[i][rows] = 'x';
        }
        solveNQueens(board, rows+1);
        if (safe(board, i, rows)) {
            board[i][rows] = '.';
        }
    }
    
}

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        

        
        board = NULL;
        board = (char**)malloc(sizeof(char*)*N);
        for (int i=0; i<N; i++) {
            *(board+i) = (char*)malloc(sizeof(char)*N);
        }
        
        for (int i=0; i<N; i++) {
            for (int j=0; j<N; j++) {
//                board[j][i] = '.';
                *(*(board+j)+i) = '.';
            }
        }
        
        solveNQueens(board, 0);
        
        for (int i=0; i<N; i++) {
//            free(*(board+i));
            free(board[i]);
        }
        free(board);
        printf("THIS ALGO IS BROKEN!!!\n");
    }
    return 0;
}

