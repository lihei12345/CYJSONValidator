//
//  ViewController.m
//  CYJSONValidatorDemo
//
//  Created by jason on 15/4/24.
//  Copyright (c) 2015年 chenyang. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+CYJSONValidator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *json = @{
                           @"phoneNumber" : @"123-555-6789",
                           @"name" : @"Johnny Ringo",
                           @"age" : @"BANANA",
                           @"weight" : @"130.3",
                           @"height" : [NSNull null],
                           @"ssn" : [NSNull null],
                           @"children" : @[],
                           @"parents" : @[
                                   @{
                                       @"name" : @"Mickey"
                                       },
                                   @{
                                       @"name" : @"Minnie"
                                       }
                                   ],
                           @"data" : @{
                                   @"name" : @"json",
                                   @"age" : @"12",
                                   @"height" : @(122)
                                   }
                           };
    
    NSString * name = json.cy_stringKey(@"name");
    NSLog(@"name: %@", name);
    
    CGFloat weight = json.cy_floatKey(@"weight");
    NSLog(@"weight: %@", @(weight));
    CGFloat height = json.cy_floatKey(@"height");
    NSLog(@"height: %@", @(height));
    NSInteger age = json.cy_integerKey(@"age");
    NSLog(@"age: %@", @(age));
    
    NSDictionary *parentsDic = json.cy_dictionaryKey(@"parents");
    NSLog(@"parents dic: %@", parentsDic);
    NSArray *parentsArray = json.cy_arrayKey(@"parents");
    NSLog(@"parents array: %@", parentsArray);
    
    NSDictionary *dataDic = json.cy_dictionaryKey(@"data");
    NSString *aName = dataDic.cy_stringKey(@"name");
    NSLog(@"data name: %@", aName);
    NSNumber *aAge = dataDic.cy_numberKey(@"number");
    NSLog(@"data age: %@", aAge);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
