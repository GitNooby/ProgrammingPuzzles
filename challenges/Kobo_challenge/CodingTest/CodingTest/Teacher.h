//
//  Teacher.h
//  CodingTest
//
//  Created by Charles Joseph on 2014-06-02.
//  Copyright (c) 2014 Kobo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Teacher : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *salary;
@property (nonatomic, strong) NSArray *subjects;

- (instancetype)initWithName:(NSString *)name salary:(NSNumber *)salary subjects:(NSArray *)subjects;

@end
