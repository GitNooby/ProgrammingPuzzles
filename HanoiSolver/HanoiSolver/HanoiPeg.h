//
//  HanoiPeg.h
//  HanoiSolver
//
//  Created by Kai Zou on 2/24/2014.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HanoiPeg : NSObject

-(id)initWithNumRings:(int)numRings AndPegName:(NSString*)name;

-(void)pushInt:(int)intNum;
-(int)popInt;
-(int)peek;
-(BOOL)isEmpty;
-(int)numRings;
-(void)printPeg;
-(void)printPegName;

@end
