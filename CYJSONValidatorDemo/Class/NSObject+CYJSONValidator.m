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

- (instancetype)cy_isArray
{
    if ([self isKindOfClass:[NSArray class]]) {
        return self;
    }
    
    return nil;
}

- (instancetype)cy_isDictionary
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

- (CYIdKeyBlock)cy_stringKey
{
    return [self keyBlockWithPredicate_:RPValidatorPredicate.isString.isNotNull];
}

- (CYIdKeyBlock)cy_numberKey
{
    return [self keyBlockWithPredicate_:RPValidatorPredicate.isNumber.isNotNull];
}

- (CYIdKeyBlock)cy_numberOrStringKey
{
    CYIdKeyBlock keyBlock = ^id(NSString *key) {
        if (!self.cy_isDictionary) {
            return nil;
        }
        
        if (self.cy_stringKey(key) != nil || self.cy_numberKey(key) != nil) {
            id jsonValue = [self valueForKey:key];
            return jsonValue;
        }
        
        return nil;
    };
    return keyBlock;
}

- (CYIdKeyBlock)cy_dictionaryKey
{
    return [self keyBlockWithPredicate_:RPValidatorPredicate.isDictionary.isNotNull];
}

- (CYIdKeyBlock)cy_arrayKey
{
    return [self keyBlockWithPredicate_:RPValidatorPredicate.isArray.isNotNull];
}

- (CYIdKeyBlock)cy_booleanKey
{
    return [self keyBlockWithPredicate_:RPValidatorPredicate.isBoolean.isNotNull];
}

- (CYIdKeyBlock)cy_nullKey
{
    return [self keyBlockWithPredicate_:RPValidatorPredicate.isNull];
}

- (NSInteger (^)(NSString *))cy_integerKey
{
    NSInteger (^keyBlock)(NSString *)= ^NSInteger(NSString *key) {
        return [self.cy_numberOrStringKey(key) integerValue];
    };
    return keyBlock;
}

- (double (^)(NSString *))cy_doubleKey
{
    double (^keyBlock)(NSString *)= ^double(NSString *key) {
        return [self.cy_numberOrStringKey(key) doubleValue];
    };
    return keyBlock;
}

- (float (^)(NSString *))cy_floatKey
{
    float (^keyBlock)(NSString *)= ^float(NSString *key) {
        return [self.cy_numberOrStringKey(key) floatValue];
    };
    return keyBlock;
}

- (int (^)(NSString *))cy_intKey
{
    int (^keyBlock)(NSString *)= ^int(NSString *key) {
        return [self.cy_numberOrStringKey(key) intValue];
    };
    return keyBlock;
}

- (long long (^)(NSString *))cy_longLongKey
{
    long long (^keyBlock)(NSString *)= ^long long(NSString *key) {
        return [self.cy_numberOrStringKey(key) longLongValue];
    };
    return keyBlock;
}

- (BOOL (^)(NSString *))cy_boolKey
{
    BOOL (^keyBlock)(NSString *)= ^BOOL(NSString *key) {
        return [self.cy_numberOrStringKey(key) boolValue];
    };
    return keyBlock;
}

#pragma mark - helper


- (CYIdKeyBlock)keyBlockWithPredicate_:(RPValidatorPredicate *)predicate
{
    CYIdKeyBlock keyBlock = ^id(NSString *key){
        return self.cy_validatorKey(key, predicate);
    };
    return keyBlock;
}

@end
