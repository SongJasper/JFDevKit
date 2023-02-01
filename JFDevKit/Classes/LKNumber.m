//
//  LKNumber.m
//  JFCalculate
//
//  Created by 宋金峰 on 2020/9/27.
//  Copyright © 2020 宋金峰. All rights reserved.
//

#import "LKNumber.h"

@interface LKNumber ()
@property (nonatomic, strong) NSDecimalNumber *number;
@property (nonatomic, assign) NSInteger digits;
@end

@implementation LKNumber
+ (instancetype)numberWithString:(NSString *)string {
    return [[LKNumber alloc]initWithString:string];
}
- (instancetype)initWithString:(NSString *)string  {
    self = [super init];
    if (self) {
        self.number = [self formart:string];
        self.digits = -1;
    }
    return self;
}

- (NSDecimalNumber *)formart:(NSString *)string {
    NSDecimalNumber *tmp = nil;
    if (string.length) {
        tmp = [NSDecimalNumber decimalNumberWithString:string];
    }
    if (!tmp || [tmp isEqualToNumber:NSDecimalNumber.notANumber]) {
        tmp = [NSDecimalNumber zero];
    }
    return tmp;
}

- (JFSetStringBlock)adding {
    return ^(NSString *number) {
        self.number = [self.number decimalNumberByAdding:[self formart:number]];
        return self;
    };
}

- (JFSetStringBlock)subtracting {
    return ^(NSString *number) {
        self.number = [self.number decimalNumberBySubtracting:[self formart:number]];
        return self;
    };
}

- (JFSetStringBlock)multiplying {
    return ^(NSString *number) {
        self.number = [self.number decimalNumberByMultiplyingBy:[self formart:number]];
        return self;
    };
}
- (JFSetStringBlock)dividing {
    return ^(NSString *number) {
        if ([[self formart:number] compare:[NSDecimalNumber zero]] == NSOrderedSame) {
            return self;
        }
        self.number = [self.number decimalNumberByDividingBy:[self formart:number]];
        return self;
    };
}

- (NSString *)stringValue {
    NSDecimalNumber *number = self.number;
    if (self.digits >= 0) {
        NSDecimalNumberHandler *handler = [[NSDecimalNumberHandler alloc]initWithRoundingMode:(NSRoundPlain) scale:self.digits raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        number = [self.number decimalNumberByRoundingAccordingToBehavior:handler];
    }
    return [number stringValue];
}
- (NSNumber *)value {
    return self.number;
}
- (NSString *)description {
    return self.stringValue;
}

- (JFSetIntegerBlock)decimal {
    return ^(NSUInteger decimal){
        self.digits = decimal;
        return self;
    };
}

- (JFSetIntegerBlock)power {
    return ^(NSUInteger power){
        self.number = [self.number decimalNumberByRaisingToPower:power];
        return self;
    };
}
- (JFSetVoidBlock)square {
    return ^(){
        self.power(2);
        return self;
    };
}

+ (NSComparisonResult)number:(NSString *)number1 compareNumber:(NSString *)number2 {
    LKNumber *num1 = [LKNumber numberWithString:number1];
    LKNumber *num2 = [LKNumber numberWithString:number2];
    return [num1.number compare:num2.number];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.number forKey:@"number"];
    [aCoder encodeObject:@(self.digits) forKey:@"digits"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.number = [aDecoder decodeObjectForKey:@"number"];
        self.digits = [[aDecoder decodeObjectForKey:@"digits"] integerValue];
    }
    return self;
}

@end
