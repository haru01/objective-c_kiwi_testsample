#import <Foundation/Foundation.h>
#import "FizzBuzz.h"
#import "RomanNumber.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        RomanNumber *one = [[RomanNumber alloc] initWithRomanStr:@"I"];
        RomanNumber *two = [[RomanNumber alloc] initWithRomanStr:@"II"];
        NSLog(@"%@", [one plus:two]);
    }
    return 0;
}

