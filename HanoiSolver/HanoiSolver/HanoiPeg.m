//
//  HanoiPeg.m
//  HanoiSolver
//
//  Created by Kai Zou on 2/24/2014.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#import "HanoiPeg.h"

@interface HanoiPeg () {
    
}
@property (strong, nonatomic) NSMutableArray *pegStack;
@property (strong, nonatomic) NSString *pegName;
@end

@implementation HanoiPeg

-(id)initWithNumRings:(int)numRings AndPegName:(NSString*)name {
    self = [super init];
    if (self) {
        self.pegStack = [[NSMutableArray alloc] initWithCapacity:numRings];
        self.pegName = name;
        
        for (int i=numRings; i>=1; i--) {
            NSNumber *aNumber = [NSNumber numberWithInt:i];
            [self.pegStack addObject:aNumber];
        }
        
    }
    return self;
}

-(void)printPegName {
    printf("%s", [self.pegName cStringUsingEncoding:NSASCIIStringEncoding]);
}

-(void)pushInt:(int)intNum {
    NSNumber *aNumber = [NSNumber numberWithInt:intNum];
    [self.pegStack addObject:aNumber];
}

-(int)popInt {
    int val = [self peek];
    [self.pegStack removeLastObject];
    return val;
}

-(int)peek {
    if ([self.pegStack count] != 0) {
        NSNumber *aNumber = [self.pegStack lastObject];
        return [aNumber intValue];
    }
    return -1;
}

-(BOOL)isEmpty {
    return (self.pegStack.count == 0);
}

-(int)numRings {
    return (int)self.pegStack.count;
}

-(void)printPeg {
    for (int i=0; i<self.pegStack.count; i++) {
//        NSLog(@"%d ", [[self.pegStack objectAtIndex:i] intValue]);
        printf("%d ", [[self.pegStack objectAtIndex:i] intValue]);
    }
//    NSLog(@"\n");
    printf("\n");
}

@end
