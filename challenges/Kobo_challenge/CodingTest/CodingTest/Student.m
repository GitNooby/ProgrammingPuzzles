//
//  Student.m
//  CodingTest
//
//  Created by Charles Joseph on 2014-06-02.
//  Copyright (c) 2014 Kobo Inc. All rights reserved.
//

#import "Student.h"

@implementation Student

- (instancetype)initWithName:(NSString *)name tuition:(NSNumber *)tuition subjects:(NSArray *)subjects {
    self = [super init];
    
    if (self) {
        self.name = name;
        self.tuition = tuition;
        self.subjects = subjects;
    }
    
    return self;
}

@end
