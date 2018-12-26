//
//  NSArray+NewCaseDescArray.m
//  GDRMMobile
//
//  Created by yu hongwu on 12-6-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSArray+NewCaseDescArray.h"
#import "LawbreakingAction.h"
#import "CaseInfo.h"

@implementation NSArray(NewCaseDescArray)

+(NSArray *)newCaseDescArray{
    NSArray *actionArray = [LawbreakingAction LawbreakingActionsForCasetype:CaseTypeIDDefault];
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:[actionArray count]];
    for (LawbreakingAction *action in actionArray) {
        CaseDescString *cds = [[CaseDescString alloc] init];
        cds.caseDesc = action.caption;
        cds.caseDescID = action.myid;
        cds.isSelected = NO;
        [tempArray addObject:cds];
    }
    
    if (tempArray.count > 4) {
        [tempArray removeObjectAtIndex:4];
    }
    if (tempArray.count >= 4) {
    ((CaseDescString*)tempArray[0]).caseDesc = @"损坏公路附属设施";
    ((CaseDescString*)tempArray[1]).caseDesc = @"造成公路路产损坏、污染公路路面";
    ((CaseDescString*)tempArray[2]).caseDesc = @"造成公路路面损坏";
    ((CaseDescString*)tempArray[3]).caseDesc = @"造成公路路面污染";
    }
    return [NSArray arrayWithArray:tempArray];
}

@end
