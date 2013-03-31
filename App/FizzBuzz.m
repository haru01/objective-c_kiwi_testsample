#import "FizzBuzz.h"
#import "Underscore.h"

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
