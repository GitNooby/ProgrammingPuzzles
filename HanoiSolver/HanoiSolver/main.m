//
//  main.m
//  HanoiSolver
//
//  Created by Kai Zou on 2/24/2014.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HanoiSolver.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        HanoiSolver *hanoiSolver = [[HanoiSolver alloc] initWithNumRings:9];
        
        [hanoiSolver solveHanoi];
    }
    return 0;
}

