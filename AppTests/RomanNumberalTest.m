#import "Kiwi.h"
#import "Underscore.h"

#define _ Underscore

@interface RomanNumber : NSObject

@property (readonly) NSNumber *number;
@property (readonly) NSString *romanStr;

- (id)initWithNum:(NSNumber *)aNumber;
- (id)initWithRomanStr:(NSString *)aRomanStr;
- (RomanNumber *)plus:(RomanNumber *)other;
- (RomanNumber *)minus:(RomanNumber *)other;
- (BOOL)isEqual:(id)other;

@end

@implementation RomanNumber

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

- (NSArray *)keysDesc:(NSDictionary *)dictionary {
    NSMutableArray *keysDesc =[NSMutableArray arrayWithArray:_.keys(dictionary)];
    [keysDesc sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj2 compare:obj1];
    }];
    return keysDesc;
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
@end

@interface TestHelper : NSObject
@end

@implementation TestHelper

+ (NSDictionary *)nums {
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
      
      @3: @"III",
      @6: @"VI",
      @11: @"XI",
      @39: @"XXXIX",
      @44: @"XLIV",
      @95: @"XCV",
      @345: @"CCCXLV",
      @3999: @"MMMCMXCIX",
      };
}

@end

SPEC_BEGIN(RomanNumberSpec)

describe(@"RomanNumber", ^{
    // 数字をローマ数字に変換できること
    _.dictEach([TestHelper nums], ^(NSNumber *number, NSString *expected) {
        NSString *itStr = [NSString stringWithFormat:@"数字:%@をローマ数字:%@に変換できること", number, expected];
        it(itStr, ^{
            id roman =  [[RomanNumber alloc] initWithNum:number];
            [[[roman romanStr] should] equal: expected];
        });
    });

    //ローマ数字の文字列から数値に変換ができること
    _.dictEach([TestHelper nums], ^(NSNumber *expected, NSString *romanStr) {
        NSString *itStr = [NSString stringWithFormat:@"ローマ数字:%@を数字:%@に変換できること", romanStr, expected];
        it(itStr, ^{
            id roman =  [[RomanNumber alloc] initWithRomanStr:romanStr];
            [[[roman number] should] equal: expected];
        });
    });

    it(@"ローマ数字の足し算ができること", ^{
        id one =  [[RomanNumber alloc] initWithRomanStr:@"I"];
        id three =  [[RomanNumber alloc] initWithRomanStr:@"III"];
        id four =  [[RomanNumber alloc] initWithRomanStr:@"IV"];
        [[[one plus:three] should] equal:four];
        [[[[one plus:three] number] should] equal:@(4)];
    });

    it(@"ローマ数字の引き算ができること", ^{
        id ten =  [[RomanNumber alloc] initWithRomanStr:@"X"];
        id three =  [[RomanNumber alloc] initWithRomanStr:@"III"];
        id seven =  [[RomanNumber alloc] initWithRomanStr:@"VII"];
        [[[ten minus:three] should] equal:seven];
        [[[[ten minus:three] number] should] equal:@(7)];
    });

    // TODO
    // - ローマ数字のソート
    // - 引数が 1-3999 以外の場合の初期化
    // − 引数がローマ数字でない場合の初期化
});

SPEC_END