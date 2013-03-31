#import "RomanNumber.h"
#import "Underscore.h"
#import "Kiwi.h"

#define _ Underscore

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