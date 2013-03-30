#import "Kiwi.h"
#import "Underscore.h"

#define _ Underscore

@interface RomanNumber : NSObject

@property (readonly) NSNumber *number;
@property (readonly) NSString *romanStr;

@end

@implementation RomanNumber

-(id)initWithNum:(NSNumber *)aNumber {
    // TODO 引数が 1-3999 以外の場合
    self = [super init];
    if (self) {
        _number = aNumber;
        _romanStr = [self convertRomanStr:_number];
    }
    return self;
}

-(id)initWithRomanStr:(NSString *)aRomanStr {
    // TODO 引数がローマ数字でないばあい
    self = [super init];
    if (self) {
        _romanStr = aRomanStr;
        _number = [self convertNumber: _romanStr];
    }
    return self;
}

-(NSString *) toString {
    return [self convertRomanStr:_number];
}


-(NSNumber *) convertNumber:(NSString *)aRomanStr {
    // 総当たりでマッチするものを探す方法
    for(int i=0; i<4000; i++ ) {
        NSNumber *n = @(i);
        NSString *other = [self convertRomanStr:@(i)];
        if ([other isEqualToString: aRomanStr]) {
            return n;
        }
    }
    return @(-1);
}

-(NSString *) convertRomanStr:(NSNumber *)aNumber {
    NSDictionary *nums = @{
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
    id romanStr = [nums objectForKey:aNumber];
    if (romanStr) {
        return romanStr;
    }
    
    for (NSNumber *base in [self keysDesc:nums]) {
        int diff = [aNumber intValue] - [base intValue];
        if (diff > 0) {
            return [NSString stringWithFormat:@"%@%@",[self convertRomanStr:base], [self convertRomanStr:[NSNumber numberWithInt:diff]]];
        }
    }
    return @"";
}

-(NSArray *) keysDesc:(NSDictionary *) dictionary {
    NSMutableArray *keysDesc =[NSMutableArray arrayWithArray:Underscore.keys(dictionary)];
    [keysDesc sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj2 compare:obj1];
    }];
    return keysDesc;
}

-(RomanNumber *) plus:(RomanNumber *) other {
    return [[RomanNumber alloc] initWithNum:@([self.number intValue] + [other.number intValue])];
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
@end


SPEC_BEGIN(RomanNumberSpec)

describe(@"RomanNumber", ^{
    
    // 数字をローマ数字に変換できること
    _.dictEach(@{
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

               @3: @"III",
               @6: @"VI",
               @11: @"XI",
               @39: @"XXXIX",
               @44: @"XLIV",
               @95: @"XCV",
               @345: @"CCCXLV",
               @3999: @"MMMCMXCIX",
               }, ^(NSNumber *number, NSString *expected) {
        NSString *itStr = [NSString stringWithFormat:@"数字:%@をローマ数字:%@に変換できること", number, expected];
        it(itStr, ^{
            RomanNumber *roman =  [[RomanNumber alloc] initWithNum:number];
            [[[roman romanStr] should] equal: expected];
        });
    });

    it(@"ローマ数字の文字列から数値変換ができること", ^{
        RomanNumber *romanA =  [[RomanNumber alloc] initWithRomanStr:@"CCCXLV"];
        [[[romanA number] should] equal: @345];

        RomanNumber *romanB =  [[RomanNumber alloc] initWithRomanStr:@"MMMCMXCIX"];
        [[[romanB number] should] equal: @3999];
    });

    it(@"ローマ数字の足し算ができること", ^{
        RomanNumber *one =  [[RomanNumber alloc] initWithRomanStr:@"I"];
        RomanNumber *three =  [[RomanNumber alloc] initWithRomanStr:@"III"];
        RomanNumber *four =  [[RomanNumber alloc] initWithRomanStr:@"IV"];
        [[[one plus:three] should] equal:four];
        [[[[one plus:three] number] should] equal:@(4)];
    });
    
    // TODO
    // - 引き算
    // - ローマ数字のソート
});

SPEC_END