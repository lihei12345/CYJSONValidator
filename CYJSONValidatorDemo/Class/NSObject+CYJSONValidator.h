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

#define CY_TYPE_KEY_BLOCK(TYPE) TYPE *(^)(NSString *)
#define CY_TYPE_KEY_BLOCK_VAR(TYPE, VAR) TYPE *(^VAR)(NSString *)

@interface NSObject (CYJSONValidator)

- (instancetype)cy_isArray;
- (instancetype)cy_isDictionary;

- (CYValidatorBlock)cy_validatorKey;

- (CY_TYPE_KEY_BLOCK(NSString))cy_stringKey;
- (CY_TYPE_KEY_BLOCK(NSNumber))cy_numberKey;
- (CYIdKeyBlock)cy_numberOrStringKey;
- (CY_TYPE_KEY_BLOCK(NSDictionary))cy_dictionaryKey;
- (CY_TYPE_KEY_BLOCK(NSArray))cy_arrayKey;
- (CY_TYPE_KEY_BLOCK(NSNumber))cy_booleanKey;
- (CY_TYPE_KEY_BLOCK(NSNull))cy_nullKey;

- (NSInteger (^)(NSString *))cy_integerKey;
- (double (^)(NSString *))cy_doubleKey;
- (float (^)(NSString *))cy_floatKey;
- (int (^)(NSString *))cy_intKey;
- (long long (^)(NSString *))cy_longLongKey;
- (BOOL (^)(NSString *))cy_boolKey;

@end

