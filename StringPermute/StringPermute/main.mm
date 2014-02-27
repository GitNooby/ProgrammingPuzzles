//
//  main.m
//  StringPermute
//
//  Created by Kai Zou on 2/24/2014.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#import <Foundation/Foundation.h>
//#include <cstring>
#include <stdio.h>
//#include <cstdio>

void swap(char *a, char *b){
    char temp = *a;
    *a = *b;
    *b = temp;
}

void permuteString(char *str, int start, int end) {
    /*NOTE:
     The idea is to "hold" a character, then
     premute the remaining characters
     */
    
    //base case: no characters no hold and premute
    if (start == end) {
        printf("%s\n", str);
        return;
    }
    
    for (int j=start; j<=end; j++) {
        swap((char*)(str+start), (char*)(str+j));
        
        //here, we hold the character at "start", then permute from start+1 to end
        permuteString(str, start+1, end);
        
        //backtrack
        swap((char*)(str+start), (char*)(str+j));
    }
}

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        char str[] = "abcdef";
        permuteString(str, 0, (int)strlen(str)-1);
    }
    return 0;
}

