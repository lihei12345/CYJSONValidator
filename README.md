# CYJSONValidator

A simple and safe wrapper for RPJSONValidator on iOS JSON data parsing. In practice, it's very verbose on handling JSON data. We wanna both safty and flexibility.This Project can make this. What's more, I make it very easy to use.


## Example

```obj-c
NSDictionary *json = @{
                           @"tag1": @"star",
                           @"tag2": @"jason",
                           @"totalNum": @(1616),
                           @"start_index": @"60",
                           @"return_number": @(30),
                           @"data" : @[],
                           @"tags" : [NSNull null],
                           @"config" : @{
                                   @"max_num" : @(30000),
                                   @"tag" : [NSNull null]
                                   }
                           };
```
For example, wo wanna get the value of "max_num" in "config" of json;

## Normal way

```obj-c
NSDictionary *configDic1 = [json objectForKey:@"config"];
    if (configDic1 != nil && [configDic1 isKindOfClass:[NSDictionary class]]) {
        id number = [configDic1 objectForKey:@"max_num"];
        if ([number isKindOfClass:[NSNumber class]] || [number isKindOfClass:[NSString class]]) {
            NSInteger maxNum = [number integerValue];
            NSLog(@"maxNum 1: %@", @(maxNum));
        }
    }
```

## CYJSONValidator way

In Cbjective-c, `id` doesn't support `dot notation`. This is very very upset for me. So I changed return value to actual type to support `chainable syntax` gracefully. 

```obj-c
	// first way
    NSDictionary *configDic2 = json.cy_dictionaryKey(@"config");
    NSInteger maxNum2 = configDic2.cy_integerKey(@"max_num");
    NSLog(@"maxNum 2: %@", @(maxNum2));
    // second way
    NSInteger maxNum3 = [[json cy_dictionaryKey](@"config") cy_integerKey](@"max_num");
    NSLog(@"maxNum 3: %@", @(maxNum3));
```

#### `finally, just this!`
   
```obj-c
    NSInteger maxNum4 = json.cy_dictionaryKey(@"config").cy_integerKey(@"max_num");
    NSLog(@"maxNum 4: %@", @(maxNum4));
```




