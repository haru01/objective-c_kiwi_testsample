#import "Kiwi.h"
#import "Underscore.h"

@interface FizzBuzz : NSObject
-(NSString *) convert:(int) num;
-(NSArray *) converts:(NSArray *) nums;
@end

@implementation FizzBuzz

-(NSArray *) converts:(NSArray *)nums {
    return Underscore.array(nums)
        .map(^NSString *(NSNumber *num){
            return [self convert:num.intValue];
        }).unwrap;
}

-(NSString *) convert:(int)num {
    if (num % 15  == 0) {
        return @"FizzBuzz";
    }
    if (num % 3  == 0) {
        return @"Fizz";
    }
    if (num % 5  == 0) {
        return @"Buzz";
    }
    return [NSString stringWithFormat:@"%d", num];
}

@end


SPEC_BEGIN(FizzBuzzSpec)

describe(@"FizzBuzz", ^{
    __block FizzBuzz *f;
    beforeEach(^{
        f = [FizzBuzz new];
    });

    it(@"FizzBuzz配列を返す", ^{
        NSArray *nums =  @[ @1, @2, @3, @4, @5, @6,  @9, @10, @12, @15 ];
        [[[f converts:nums] should] equal: @[ @"1", @"2", @"Fizz", @"4", @"Buzz", @"Fizz",  @"Fizz", @"Buzz", @"Fizz", @"FizzBuzz" ]];
    });
});

SPEC_END