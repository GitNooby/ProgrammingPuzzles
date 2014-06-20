//
//  Student.h
//  CodingTest
//
//  Created by Charles Joseph on 2014-06-02.
//  Copyright (c) 2014 Kobo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *tuition;
@property (nonatomic, strong) NSArray *subjects;

- (instancetype)initWithName:(NSString *)name tuition:(NSNumber *)tuition subjects:(NSArray *)subjects;

@end
