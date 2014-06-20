//
//  Teacher.m
//  CodingTest
//
//  Created by Charles Joseph on 2014-06-02.
//  Copyright (c) 2014 Kobo Inc. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher

- (instancetype)initWithName:(NSString *)name salary:(NSNumber *)salary subjects:(NSArray *)subjects {
    self = [super init];
    
    if (self) {
        self.name = name;
        self.salary = salary;
        self.subjects = subjects;
    }
    
    return self;
}

@end
