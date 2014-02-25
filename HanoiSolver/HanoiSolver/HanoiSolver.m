//
//  HanoiSolver.m
//  HanoiSolver
//
//  Created by Kai Zou on 2/24/2014.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#import "HanoiSolver.h"
#import "HanoiPeg.h"

@interface HanoiSolver () {
    
}
@property (strong, nonatomic) HanoiPeg *source;
@property (strong, nonatomic) HanoiPeg *interm;
@property (strong, nonatomic) HanoiPeg *destin;
@end

@implementation HanoiSolver

-(id)initWithNumRings:(int)numRings {
    if (self = [super init]) {
        self.source = [[HanoiPeg alloc] initWithNumRings:numRings AndPegName:@"A"];
        self.interm = [[HanoiPeg alloc] initWithNumRings:0 AndPegName:@"B"];
        self.destin = [[HanoiPeg alloc] initWithNumRings:0 AndPegName:@"C"];
    }
    return self;
}

-(void)solveHanoi {
    NSLog(@"source:\n");
    [self.source printPeg];
    NSLog(@"interm:\n");
    [self.interm printPeg];
    NSLog(@"destin:\n");
    [self.destin printPeg];
    
    [self solveHanoiN:[self.source numRings] Src:self.source Dest:self.destin Inter:self.interm];
    
    NSLog(@"\n");
    NSLog(@"source:\n");
    [self.source printPeg];
    NSLog(@"interm:\n");
    [self.interm printPeg];
    NSLog(@"destin:\n");
    [self.destin printPeg];
}

#pragma mark - Helper functions
-(void)solveHanoiN:(int)n Src:(HanoiPeg*)src Dest:(HanoiPeg*)dest Inter:(HanoiPeg*)interm {
    if (n>0) {
        [self solveHanoiN:(n-1) Src:src Dest:interm Inter:dest];
        [self moveRingFromPeg:src ToOtherPeg:dest];
        printf("move from ");
        [src printPegName];
        printf(" to ");
        [dest printPegName];
        printf("\n");
        [self solveHanoiN:(n-1) Src:interm Dest:dest Inter:src];
    }
}

-(void)moveRingFromPeg:(HanoiPeg*)p ToOtherPeg:(HanoiPeg*)op {
    [op pushInt:[p popInt]];
}

@end
