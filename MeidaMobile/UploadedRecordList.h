//
//  UploadedRecordList.h
//  GDRMMobile
//
//  Created by 高 峰 on 13-7-11.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


//下载记录表  下载了什么：名字       下载时间     

@interface UploadedRecordList : NSManagedObject

@property (nonatomic, retain) NSString * tableName;
@property (nonatomic, retain) NSDate * uploadedDate;
@property (nonatomic, retain) NSString * findStr;

@end
