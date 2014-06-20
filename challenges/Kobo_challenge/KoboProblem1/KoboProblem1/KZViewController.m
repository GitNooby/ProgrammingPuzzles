//
//  KZViewController.m
//  KoboProblem1
//
//  Created by Kai Zou on 2014-06-19.
//  Copyright (c) 2014 com.zou. All rights reserved.
//

#import "KZViewController.h"

@interface KZViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *productIDTextField;
@property (strong, nonatomic) IBOutlet UILabel *isbnLabel;

@end

@implementation KZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.productIDTextField.delegate = self;
}

#pragma mark - generating isbn
-(NSString*)generateISBN10FromProductID:(NSString*)productID {
    NSRange pidRange = NSMakeRange(3, 9);
    
    NSString *pidRangeString = [productID substringWithRange:pidRange];
    
    int sum = 0;
    for (int weight=10, index=0; weight>1; weight--, index++) {
        char c = [pidRangeString characterAtIndex:index];
        int digit = c - '0';
        sum += + weight * digit;
    }
    NSLog(@"sum is: %d", sum);
    
    // determine the last digit
    int lastDigit = 0;
    int newSum = sum;
    for (; lastDigit<11; lastDigit++) {
        newSum = sum + lastDigit;
        if (newSum % 11 == 0) {
            break;
        }
        lastDigit++;
    }
    
    // remove leading zeros
    int tempInt = [pidRangeString intValue];
    pidRangeString = [NSString stringWithFormat:@"%d", tempInt];
    
    // form the final isbn10 string
    NSString *isbn10String = @"";
    if (lastDigit < 10) {
        isbn10String = [NSString stringWithFormat:@"%@%d", pidRangeString, lastDigit];
    } else {
        isbn10String = [NSString stringWithFormat:@"%@%@", pidRangeString, @"x"];
    }
    
    return isbn10String;
}

#pragma mark - textfield handling
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    // get user input
    NSString *inputString = textField.text;
    
    // check if input is numeric
    NSScanner *scan = [NSScanner scannerWithString:inputString];
    BOOL isNumeric = [scan scanInteger:NULL] && [scan isAtEnd];
    
    // determine ISBN-10 from 12 digit product ID
    if (isNumeric && inputString.length == 12) {
        NSString *isbn10String = [self generateISBN10FromProductID:inputString];
        self.isbnLabel.text = isbn10String;
    } else if (isNumeric == NO) {
        self.isbnLabel.text = @"Enter Valid Product ID";
    } else if (inputString.length != 12) {
        self.isbnLabel.text = @"Enter Valid 12 Digit Product ID";
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.productIDTextField resignFirstResponder];
    return YES;
}

#pragma mark - override touchs
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.productIDTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
