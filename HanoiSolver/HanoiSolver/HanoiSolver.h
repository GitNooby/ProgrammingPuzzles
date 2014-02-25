//
//  HanoiSolver.h
//  HanoiSolver
//
//  Created by Kai Zou on 2/24/2014.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HanoiSolver : NSObject

-(id)initWithNumRings:(int)numRings;
-(void)solveHanoi;

@end
