#import <Foundation/Foundation.h>

@interface RomanNumber : NSObject

@property (readonly) NSNumber *number;
@property (readonly) NSString *romanStr;

- (id)initWithNum:(NSNumber *)aNumber;
- (id)initWithRomanStr:(NSString *)aRomanStr;
- (RomanNumber *)plus:(RomanNumber *)other;
- (RomanNumber *)minus:(RomanNumber *)other;
- (BOOL)isEqual:(id)other;

@end
