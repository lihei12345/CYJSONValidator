//
//  NSObject+CYJSONValidator.h
//  CYJSONValidator
//
//  Created by jason on 15/4/24.
//  Copyright (c) 2015 chenyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RPJSONValidator/RPValidatorPredicate.h>

typedef id (^CYValidatorBlock)(NSString *key, RPValidatorPredicate *predicate);
typedef id (^CYIdKeyBlock)(NSString *key);


@interface NSObject (CYJSONValidator)

- (id)cy_isArray;
- (id)cy_isDictionary;

- (CYValidatorBlock)cy_validatorKey;

- (NSString *)cy_stringKey:(NSString *)key;
- (NSNumber *)cy_numberKey:(NSString *)key;
- (id)cy_numberOrStringKey:(NSString *)key;
- (NSDictionary *)cy_dictionaryKey:(NSString *)key;
- (NSArray *)cy_arrayKey:(NSString *)key;
- (NSNumber *)cy_booleanKey:(NSString *)key;
- (NSNull *)cy_nullKey:(NSString *)key;

- (NSInteger)cy_integerKey:(NSString *)key;
- (NSInteger)cy_integerKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
- (double)cy_doubleKey:(NSString *)key;
- (double)cy_doubleKey:(NSString *)key defaultValue:(double)defaultValue;
- (float)cy_floatKey:(NSString *)key;
- (float)cy_floatKey:(NSString *)key defaultValue:(float)defaultValue;
- (int)cy_intKey:(NSString *)key;
- (int)cy_intKey:(NSString *)key defaultValue:(int)defaultValue;
- (long long)cy_longLongKey:(NSString *)key;
- (long long)cy_longLongKey:(NSString *)key defaultValue:(long long)defaultValue;
- (BOOL)cy_boolKey:(NSString *)key;
- (BOOL)cy_boolKey:(NSString *)key defaultValue:(BOOL)defaultValue;

@end

