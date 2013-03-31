#import "RomanNumber.h"
#import "Underscore.h"

#define _ Underscore

@interface RomanNumber ()

+ (NSDictionary *)baseNums;
- (NSNumber *)convertNumber:(NSString *)aRomanStr;
- (NSString *)convertRomanStr:(NSNumber *)aNumber;
- (NSArray *)keysDesc:(NSDictionary *)dictionary;

@end


@implementation RomanNumber

+ (NSDictionary *)baseNums {
    return @{
             @1: @"I",
             @4: @"IV",
             @5: @"V",
             @9: @"IX",
             @10: @"X",
             @40: @"XL",
             @50: @"L",
             @90: @"XC",
             @100: @"C",
             @400: @"CD",
             @500: @"D",
             @900: @"CM",
             @1000: @"M",
             };
}

- (id)initWithNum:(NSNumber *)aNumber {
    self = [super init];
    if (self) {
        _number = aNumber;
        _romanStr = [self convertRomanStr:_number];
    }
    return self;
}

- (id)initWithRomanStr:(NSString *)aRomanStr {
    self = [super init];
    if (self) {
        _romanStr = aRomanStr;
        _number = [self convertNumber: _romanStr];
    }
    return self;
}

- (RomanNumber *)plus:(RomanNumber *)other {
    return [[RomanNumber alloc] initWithNum:@([self.number intValue] + [other.number intValue])];
}

- (RomanNumber *)minus:(RomanNumber *)other {
    return [[RomanNumber alloc] initWithNum:@([self.number intValue] - [other.number intValue])];
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
    if (!other || ![other isKindOfClass:[self class]]) {
        return NO;
    }
    if ([[self number] intValue] != [[other number] intValue] ) {
        return NO;
    }
    return YES;
}

- (NSString *)description {
    return self.romanStr;
}

- (NSNumber *)convertNumber:(NSString *)aRomanStr {
    // 総当たりでマッチするものを探す方法
    for(int i=0; i<4000; i++ ) {
        NSNumber *num = @(i);
        NSString *other = [self convertRomanStr:num];
        if ([other isEqualToString: aRomanStr]) {
            return num;
        }
    }
    return @(-1);
}

- (NSString *)convertRomanStr:(NSNumber *)aNumber {
    NSDictionary *baseNums = [RomanNumber baseNums];
    id romanStr = [baseNums objectForKey:aNumber];
    if (romanStr) {
        return romanStr;
    }
    
    for (NSNumber *base in [self keysDesc:baseNums]) {
        int diff = [aNumber intValue] - [base intValue];
        if (diff > 0) {
            return [NSString stringWithFormat:@"%@%@", [self convertRomanStr:base], [self convertRomanStr:@(diff)]];
        }
    }
    return @"";
}

- (NSArray *)keysDesc:(NSDictionary *)dictionary {
    NSMutableArray *keysDesc =[NSMutableArray arrayWithArray:_.keys(dictionary)];
    [keysDesc sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj2 compare:obj1];
    }];
    return keysDesc;
}

@end
