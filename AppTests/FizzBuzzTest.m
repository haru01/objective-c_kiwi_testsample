#import "Kiwi.h"
#import "FizzBuzz.h"


SPEC_BEGIN(FizzBuzzSpec)

describe(@"FizzBuzz", ^{
    __block id f;
    beforeEach(^{
        f = [FizzBuzz new];
    });

    it(@"FizzBuzz配列を返す", ^{
        id nums =  @[ @1, @2, @3, @4, @5, @6,  @9, @10, @12, @15 ];
        [[[f converts:nums] should] equal: @[ @"1", @"2", @"Fizz", @"4", @"Buzz", @"Fizz",  @"Fizz", @"Buzz", @"Fizz", @"FizzBuzz" ]];
    });
});

SPEC_END