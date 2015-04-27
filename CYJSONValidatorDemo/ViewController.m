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
                           @"tag1": @"star",
                           @"tag2": @"jason",
                           @"totalNum": @(1616),
                           @"start_index": @"60",
                           @"return_number": @(30),
                           @"data" : @[@"1", @"2"],
                           @"tags" : [NSNull null],
                           @"config" : @{
                                   @"max_num" : @(30000),
                                   @"tag" : [NSNull null]
                                   }
                           };
    
    // Normal
    NSDictionary *configDic1 = [json objectForKey:@"config"];
    if (configDic1 != nil && [configDic1 isKindOfClass:[NSDictionary class]]) {
        id number = [configDic1 objectForKey:@"max_num"];
        if ([number isKindOfClass:[NSNumber class]] || [number isKindOfClass:[NSString class]]) {
            NSInteger maxNum = [number integerValue];
            NSLog(@"maxNum 1: %@", @(maxNum));
        }
    }
    
    // Or just this!
    NSInteger maxNum = [[json cy_dictionaryKey:@"config"] cy_integerKey:@"max_num"];
    NSLog(@"maxNum: %@", @(maxNum));
    
    // Handle NSNull
    NSArray *tags = [json cy_arrayKey:@"tags"];
    NSLog(@"%@", tags);
    
    // Handle wrong type
    NSString *string = [[json cy_dictionaryKey:@"data"] cy_stringKey:@"1"];
    NSLog(@"%@", string);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
