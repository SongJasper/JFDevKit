//
//  LKNumber.h
//  JFCalculate
//
//  Created by 宋金峰 on 2020/9/27.
//  Copyright © 2020 宋金峰. All rights reserved.
//

#import <Foundation/Foundation.h>

///< ⚠️ 计算顺序按照调用的顺序来,表达式中乘除优于加减,请自行调整调用方法顺序
@class LKNumber;
typedef LKNumber *(^JFSetStringBlock)(NSString *string);
typedef LKNumber *(^JFSetVoidBlock)(void);
typedef LKNumber *(^JFSetIntegerBlock)(NSUInteger number);
@interface LKNumber : NSObject <NSCoding>
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)numberWithString:(NSString *)string;

- (JFSetStringBlock)adding; ///< 加
- (JFSetStringBlock)subtracting; ///< 减
- (JFSetStringBlock)multiplying; ///< 乘
- (JFSetStringBlock)dividing; ///< 除 如果除数是0 不处理

- (JFSetIntegerBlock)power; ///< 次方计算
- (JFSetVoidBlock)square; ///< 平方

- (JFSetIntegerBlock)decimal; ///< 保留的小数的位数 默认保留方式四舍五入

@property (nonatomic, strong, readonly) NSNumber *value;
@property (nonatomic, copy, readonly) NSString *stringValue; ///< 最终的结果 会受decimal设置的位数影响
+ (NSComparisonResult)number:(NSString *)number1 compareNumber:(NSString *)number2;

@end

