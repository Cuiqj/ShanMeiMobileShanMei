//
//  CaseCount.m
//  GDRMMobile
//
//  Created by 高 峰 on 13-7-7.
//
//

#import "CaseCount.h"
#import "NSNumber+NumberConvert.h"
#define CHINESE_ARRAY @[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"]


@implementation CaseCount

@dynamic caseinfo_id;
@dynamic citizen_name;
@dynamic sum;
@dynamic chinese_sum;
@synthesize case_count_list;

-(NSString *) chinese_sum_w{
    int i=  ([self.sum intValue] *100)/1000000 ;
    if (i < 10) {
         return CHINESE_ARRAY[i];
    }
    NSString * str = [[NSNumber numberWithDouble:i] numberConvertToChineseCapitalNumberString];
    return [str stringByReplacingOccurrencesOfString:@"元整" withString:@""];;
}
-(NSString *) chinese_sum_q{
    int i=  (([self.sum intValue] *100)%1000000 )/100000;
    return CHINESE_ARRAY[i];
}
-(NSString *) chinese_sum_b{
    int i=  (([self.sum intValue] *100)%100000 )/10000;
    return CHINESE_ARRAY[i];
}
-(NSString *) chinese_sum_s{
    int i=  (([self.sum intValue] *100)%10000 )/1000;
    return CHINESE_ARRAY[i];
}
-(NSString *) chinese_sum_y{
    int i=  (([self.sum intValue] *100)%1000 )/100;
    return CHINESE_ARRAY[i];
}
-(NSString *) chinese_sum_j{
    NSDecimalNumber * sum = [NSDecimalNumber decimalNumberWithString:[self.sum stringValue]];
    NSDecimalNumber * tempmid =[NSDecimalNumber decimalNumberWithString:@"100"];
    NSDecimalNumber * resultmoney = [sum decimalNumberByMultiplyingBy:tempmid];
//    int summ= [self.sum floatValue]*100;
    int i=  ([resultmoney integerValue]%100 )/10;
    return CHINESE_ARRAY[i];
}
-(NSString *) chinese_sum_f{
    NSDecimalNumber * sum = [NSDecimalNumber decimalNumberWithString:[self.sum stringValue]];
    NSDecimalNumber * tempmid =[NSDecimalNumber decimalNumberWithString:@"100"];
    NSDecimalNumber * resultmoney = [sum decimalNumberByMultiplyingBy:tempmid];
//    int summ= [ self.sum floatValue]*100;
    int i=  ([resultmoney integerValue]%10 );
    return CHINESE_ARRAY[i];
}
@end
