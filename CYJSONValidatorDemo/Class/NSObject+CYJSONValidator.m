//
//  NSObject+CYJSONValidator.m
//  CYJSONValidator
//
//  Created by jason on 15/4/24.
//  Copyright (c) 2015 chenyang. All rights reserved.
//

#import "NSObject+CYJSONValidator.h"

@interface RPValidatorPredicate(Protected)
- (void)validateValue:(id)value withKey:(NSString *)key;
- (NSMutableArray *)failedRequirementDescriptions;
@end

@implementation NSObject (CYJSONValidator)

#pragma mark - public

- (id)cy_isArray
{
    if ([self isKindOfClass:[NSArray class]]) {
        return self;
    }
    
    return nil;
}

- (id)cy_isDictionary
{
    if ([self isKindOfClass:[NSDictionary class]]) {
        return self;
    }
    
    return nil;
}

- (CYValidatorBlock)cy_validatorKey
{
    CYValidatorBlock block = ^id(NSString *key, RPValidatorPredicate *predicate){
        if (!self.cy_isDictionary) {
            return nil;
        }
        
        id jsonValue = [self valueForKey:key];
        [predicate validateValue:jsonValue withKey:key];
        
        if([[predicate failedRequirementDescriptions] count]) {
            return nil;
        }
        
        return jsonValue;
    };
    return block;
}

#pragma mark - id type

- (NSString *)cy_stringKey:(NSString *)key
{
    CYIdKeyBlock keyBlock = [self keyBlockWithPredicate:RPValidatorPredicate.isString.isNotNull];
    NSString *string = keyBlock(key);
    return string;
}

- (NSNumber *)cy_numberKey:(NSString *)key
{
    CYIdKeyBlock keyBlock = [self keyBlockWithPredicate:RPValidatorPredicate.isNumber.isNotNull];
    NSNumber *number = keyBlock(key);
    return number;
}

- (id)cy_numberOrStringKey:(NSString *)key
{
    if (!self.cy_isDictionary) {
        return nil;
    }
    
    if ([self cy_stringKey:key] != nil || [self cy_numberKey:key] != nil) {
        id jsonValue = [self valueForKey:key];
        return jsonValue;
    }
    return nil;
}

- (NSDictionary *)cy_dictionaryKey:(NSString *)key
{
    CYIdKeyBlock keyBlock = [self keyBlockWithPredicate:RPValidatorPredicate.isDictionary.isNotNull];
    NSDictionary *dictionary = keyBlock(key);
    return dictionary;
}

- (NSArray *)cy_arrayKey:(NSString *)key
{
    CYIdKeyBlock keyBlock = [self keyBlockWithPredicate:RPValidatorPredicate.isArray.isNotNull];
    NSArray *array = keyBlock(key);
    return array;
}

- (NSNumber *)cy_booleanKey:(NSString *)key
{
    CYIdKeyBlock keyBlock = [self keyBlockWithPredicate:RPValidatorPredicate.isBoolean.isNotNull];
    NSNumber *number = keyBlock(key);
    return number;
}

- (NSNull *)cy_nullKey:(NSString *)key
{
    CYIdKeyBlock keyBlock = [self keyBlockWithPredicate:RPValidatorPredicate.isNull];
    NSNull *null = keyBlock(key);
    return null;
}

#pragma mark - basic type

#define CY_BASIC_TYPE_FUNCTION_KEY(TYPE, TYPE_METHOD) id value = [self cy_numberOrStringKey:key];\
TYPE result = defaultValue;\
if (value) {\
result = [value TYPE_METHOD];\
}\
return result;

- (NSInteger)cy_integerKey:(NSString *)key
{
    return [[self cy_numberOrStringKey:key] integerValue];
}


- (NSInteger)cy_integerKey:(NSString *)key defaultValue:(NSInteger)defaultValue
{
    CY_BASIC_TYPE_FUNCTION_KEY(NSInteger, integerValue);
}

- (double)cy_doubleKey:(NSString *)key
{
    return [[self cy_numberOrStringKey:key] doubleValue];
}

- (double)cy_doubleKey:(NSString *)key defaultValue:(double)defaultValue
{
    CY_BASIC_TYPE_FUNCTION_KEY(double, doubleValue);
}

- (float)cy_floatKey:(NSString *)key
{
    return [[self cy_numberOrStringKey:key] floatValue];
}

- (float)cy_floatKey:(NSString *)key defaultValue:(float)defaultValue
{
    CY_BASIC_TYPE_FUNCTION_KEY(float, floatValue);
}

- (int)cy_intKey:(NSString *)key
{
    return [[self cy_numberOrStringKey:key] intValue];
}

- (int)cy_intKey:(NSString *)key defaultValue:(int)defaultValue
{
    CY_BASIC_TYPE_FUNCTION_KEY(int, intValue);
}

- (long long)cy_longLongKey:(NSString *)key
{
    return [[self cy_numberOrStringKey:key] longLongValue];
}

- (long long)cy_longLongKey:(NSString *)key defaultValue:(long long)defaultValue
{
    CY_BASIC_TYPE_FUNCTION_KEY(long long, longLongValue);
}

- (BOOL)cy_boolKey:(NSString *)key
{
    return [[self cy_numberOrStringKey:key] boolValue];
}


- (BOOL)cy_boolKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    CY_BASIC_TYPE_FUNCTION_KEY(BOOL, boolValue);
}

#pragma mark - helper

- (CYIdKeyBlock)keyBlockWithPredicate:(RPValidatorPredicate *)predicate
{
    CYIdKeyBlock keyBlock = ^id(NSString *key){
        return self.cy_validatorKey(key, predicate);
    };
    return keyBlock;
}

@end
