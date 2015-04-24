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

- (instancetype)cy_isArray;
- (instancetype)cy_isDictionary;

- (CYValidatorBlock)cy_validatorKey;

- (CYIdKeyBlock)cy_stringKey;
- (CYIdKeyBlock)cy_numberKey;
- (CYIdKeyBlock)cy_numberOrStringKey;
- (CYIdKeyBlock)cy_dictionaryKey;
- (CYIdKeyBlock)cy_arrayKey;
- (CYIdKeyBlock)cy_booleanKey;
- (CYIdKeyBlock)cy_nullKey;

- (NSInteger (^)(NSString *))cy_integerKey;
- (double (^)(NSString *))cy_doubleKey;
- (float (^)(NSString *))cy_floatKey;
- (int (^)(NSString *))cy_intKey;
- (long long (^)(NSString *))cy_longLongKey;
- (BOOL (^)(NSString *))cy_boolKey;

@end

