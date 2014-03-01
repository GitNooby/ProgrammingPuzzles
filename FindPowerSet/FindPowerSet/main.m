//
//  main.m
//  FindPowerSet
//
//  Created by Kai Zou on 2/28/2014.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#import <Foundation/Foundation.h>

NSUInteger SETSIZE = 4;
NSMutableArray *inputSet;

NSMutableArray* findPowerSet(NSMutableArray* set, int index) {
    NSMutableArray* powerSet;
    if (index == set.count) {
        powerSet = [[NSMutableArray alloc] init];
        NSMutableArray *subset = [[NSMutableArray alloc] init];
        [powerSet addObject:subset];
    } else {
        powerSet = findPowerSet(set, index + 1);
        
        NSNumber *anElement = [set objectAtIndex:index];
        
        NSMutableArray *aSubPowerSet = [NSKeyedUnarchiver unarchiveObjectWithData:
                                        [NSKeyedArchiver archivedDataWithRootObject:powerSet]]; //this is true deep copy for ios
//        [[NSMutableArray alloc] initWithArray:powerSet copyItems:YES];
        
        for (int i=0; i<[aSubPowerSet count]; i++) {
            NSMutableArray *aSubset = [aSubPowerSet objectAtIndex:i];
            [aSubset addObject:anElement];
        }
        [powerSet addObjectsFromArray:aSubPowerSet];
        
    }
    
    return powerSet;
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        inputSet = [[NSMutableArray alloc] initWithCapacity:SETSIZE];
        
        for (int i=1; i<=SETSIZE; i++) {
            NSNumber *anElement = [NSNumber numberWithInt:i];
            [inputSet addObject:anElement];
        }
        

        NSMutableArray *thePowerSet = findPowerSet(inputSet, 0);
        
        NSLog(@"%lu", (unsigned long)thePowerSet.count);
        
        for (int i=0; i<pow(2, SETSIZE); i++) {
            NSArray *subSet = [thePowerSet objectAtIndex:i];
            printf("set#:%d  ", i+1);
            for (int j=0; j<[subSet count]; j++) {
                printf("%d ", [[subSet objectAtIndex:j] intValue]);
            }
            printf("\n");
        }
        
    }
    return 0;
}

