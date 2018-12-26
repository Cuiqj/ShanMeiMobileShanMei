//
//  InitCaseInfo.m
//  ShanMeiMobile
//
//  Created by xiaoxiaojia on 15/8/4.
//
//

#import "InitCaseInfo.h"
#import "TBXML.h"
#import "CaseInfo.h"
@implementation InitCaseInfo


-(void)downLoadCaseInfo{
    WebServiceInit;
    [service downloadDataSet:@"select * from CaseInfo"];
}

- (void)xmlParser:(NSString *)webString{
    [self autoParserForDataModel:@"CaseInfo" andInXMLString:webString];
}

@end
