//
//  CasePrintController.m
//  GDXERHMMobile
//
//  Created by XU SHIWEN on 13-8-29.
//
//

#import "CasePrintController.h"



/* 常用自定义日期格式化字符串 */
NSString * const NSDateFormatStringCustom1 = @"yyyy年MM月dd日HH时mm分";
/* 公路赔补偿案件 */
NSString * const DocNameKeyPei_PeiBuChangQingDan                      = @"GongLuPeiBuChangQingDan";
NSString * const DocNameKeyPei_AnJianKanYanJianChaBiLu              = @"GongLuPeiBuChangAnJianKanYanJianChaBiLu";
NSString * const DocNameKeyPei_AnJianXunWenBiLu                     = @"GongLuPeiBuChangAnJianXunWenBiLu";
NSString * const DocNameKeyPei_AnJianXunWenBiLuExtra                = @"GongLuPeiBuChangAnJianXunWenBiLuExtra";
NSString * const DocNameKeyPei_AnJianGuanLiWenShuSongDaHuiZheng     = @"GongLuPeiBuChangAnJianGuanLiWenShuSongDaHuiZheng";
NSString * const DocNameKeyPei_PeiBuChangTongZhiShu                   = @"GongLuPeiBuChangTongZhiShu";
NSString * const DocNameKeyPei_LuZhengAnJianXianChangKanYanTu       = @"LuZhengAnJianXianChangKanYanTu";
NSString * const DocNameKeyPei_ZeLingCheLiangTingShiTongZhiShu      = @"ZeLingCheLiangTingShiTongZhiShu";
/* 交通行政处罚案件 */
NSString * const DocNameKeyFa_ZeLingGaiZhengTongZhiShu              = @"ZeLingGaiZhengTongZhiShu";
NSString * const DocNameKeyFa_ZeLingGaizhengTongZhi               = @"ZeLingGaizhengTongZhi";
NSString * const DocNameKeyFa_SheXianWeiFaXingWeiGaoZhiShu          = @"SheXianWeiFaXingWeiGaoZhiShu";
NSString * const DocNameKeyPei_JieChu_ZeLingCheLiangTingShiTongZhiShu=@"JieChuZeLingCheLiangTingShiTongZhiShu";
NSString *const DocNameKeyFa_KanYanJianChaBiLu                      =@"KanYanJianChaBiLu";
/* 默认文档目录 */
NSString * const DefaultTemplateDirectory = @"DocTemplates";


@implementation CasePrintController

- (id)init
{
    self = [super init];
    [GRMustacheConfiguration defaultConfiguration].contentType = GRMustacheContentTypeText;
    NSString *templatesPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DefaultTemplateDirectory];
    self.templateRepo = [GRMustacheTemplateRepository templateRepositoryWithDirectory:templatesPath];
    self.templateNameDictionary = @{
                                    DocNameKeyPei_PeiBuChangQingDan:
                                        @"GongLuPeiBuChangQingDan.xml",
                                    DocNameKeyPei_AnJianKanYanJianChaBiLu:
                                        @"GongLuPeiBuChangAnJianKanYanJianChaBiLu.xml",
                                    DocNameKeyPei_AnJianXunWenBiLu:
                                        @"GongLuPeiBuChangAnJianXunWenBiLu.xml",
                                    DocNameKeyPei_AnJianXunWenBiLuExtra:
                                        @"GongLuPeiBuChangAnJianXunWenBiLuExtra.xml",
                                    DocNameKeyPei_AnJianGuanLiWenShuSongDaHuiZheng:
                                        @"GongLuPeiBuChangAnJianGuanLiWenShuSongDaHuiZheng.xml",
                                    DocNameKeyPei_PeiBuChangTongZhiShu:
                                        @"GongLuPeiBuChangTongZhiShu.xml",
                                    DocNameKeyPei_LuZhengAnJianXianChangKanYanTu:
                                        @"LuZhengAnJianXianChangKanYanTu.xml",
                                    DocNameKeyPei_ZeLingCheLiangTingShiTongZhiShu:
                                        @"ZeLingCheLiangTingShiTongZhiShu.xml",
                                    DocNameKeyPei_JieChu_ZeLingCheLiangTingShiTongZhiShu:
                                        @"JieChuZeLingCheLiangTingShiTongZhiShu.xml",
                                    DocNameKeyFa_SheXianWeiFaXingWeiGaoZhiShu:
                                        @"SheXianWeiFaXingWeiGaoZhiShu.xml",
                                    DocNameKeyFa_KanYanJianChaBiLu:
                                        @"KanYanJianChaBiLu.xml"
                                    };
//     NSLog(@"%@", [[NSBundle mainBundle]pathForResource:@"ZeLingGaizhengTongZhiShu" ofType:@"xml"]);
//     NSLog(@"1111%@", [[NSBundle mainBundle]pathForResource:@"ZeLingCheLiangTingShiTongZhiShu.xml" ofType:@"mustache"]);
    return self;
}
-(BOOL)updateTemple:(NSString*)templeName{
    NSString * remotePath=[NSString stringWithFormat:@"%@/app/DocTemplates/%@%@", [AppDelegate App].serverAddress,templeName,@".xml.mustache"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSString *temp=[templeName stringByAppendingString:@".xml.mustache"];
    // NSString *destPath=[libraryDirectory stringByAppendingString:[@"/DocTemplates/tem/%@",temp]];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/app/DocTemplates/%@.xml.mustache",[AppDelegate App].serverAddress ,templeName]];
    NSError *err;
    //创建动态URL请求,并初始化
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"post"];
    NSData * resData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSData *data =[NSData dataWithContentsOfURL:url];
    NSString * s=[[NSString alloc] initWithBytes: [resData bytes] length:[resData length] encoding:NSUTF8StringEncoding];
    NSString * s2=[[NSString alloc] initWithBytes: [data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    // [s2 writeToFile:destPath atomically:YES encoding:NSUTF8StringEncoding error:&err];
    if(err==nil){
        return YES;
    }
    else{
        return NO;
    }
}
- (BOOL)saveAsPDF:(NSString *)path dataOnly:(BOOL)isDataOnly
{
    if ([self.delegate respondsToSelector:@selector(templateNameKey)]) {
        NSString *templateNameKey = [self.delegate templateNameKey];
        GRMustacheTemplate *template=[[GRMustacheTemplate alloc]init];
         NSError *err = nil;
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        if([defaults boolForKey:@"isDebugingDocFormat"]){
            //if([self updateTemple:templateNameKey]);
            NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/app/DocTemplates/%@.xml.mustache",[AppDelegate App].serverAddress ,templateNameKey]];
            template=[GRMustacheTemplate templateFromContentsOfURL:url error:&err];
            
        }else{
            NSString *templateName = [self.templateNameDictionary objectForKey:templateNameKey];
            //template= [self.templateRepo templateNamed:templateName error:&err];
            NSArray *libs=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            NSString *libPath =[libs objectAtIndex:0];
            //NSString *templeXmlPath=[ NSString stringWithFormat:@"%@/%@.xml.mustache", libPath ,templateNameKey];
            //template=[GRMustacheTemplate templateFromContentsOfFile: templeXmlPath error:nil  ];
            if(template ==nil){
             template= [self.templateRepo templateNamed:templateName error:&err];
            }
            template= [self.templateRepo templateNamed:templateName error:&err];
        }
        if (err == nil && template != nil) {
            if ([self.delegate respondsToSelector:@selector(dataForPDFTemplate)]) {
                id data = [self.delegate dataForPDFTemplate];   // 读取数据
                NSLog(@"%@",data);
                if ([data objectForKey:@"caseInquire"]) {  //CaseInquire.h
                    
                    NSMutableDictionary *dataDic = [[NSMutableDictionary dictionaryWithDictionary:data] mutableCopy];
                    NSMutableDictionary *caseInquire = [NSMutableDictionary dictionaryWithDictionary:[dataDic valueForKey:@"caseInquire"]];
                    NSArray * pagesArray = [caseInquire objectForKey:@"inquireNote"];
                    if (pagesArray.count >= 2) {
                        
                        NSMutableDictionary * dataDic2 = [[NSMutableDictionary dictionaryWithDictionary:data] mutableCopy];
                        
                        NSArray *inquireNotePage1 = [[pagesArray objectAtIndex:0] copy];
                        NSArray *inquireNotePage2 = [[pagesArray objectAtIndex:1] copy];
                        
                        NSMutableDictionary *caseInquire2 = [NSMutableDictionary dictionaryWithDictionary:[dataDic valueForKey:@"caseInquire"]];
                        
                        NSMutableDictionary *page2 = [NSMutableDictionary dictionaryWithDictionary:[dataDic valueForKey:@"page"]];
                        [page2 setObject:@"2" forKey:@"pageNum"];
                        [dataDic2 setObject:page2 forKey:@"page"];
                        
                        [caseInquire setObject:inquireNotePage1 forKey:@"inquireNote"];
                        [dataDic setObject:caseInquire forKey:@"caseInquire"];
                        
                        [caseInquire2 setObject:inquireNotePage2 forKey:@"inquireNote"];
                        [dataDic2 setObject:caseInquire2 forKey:@"caseInquire"];
                        
                        NSString *rendering = [template renderObject:dataDic error:&err];
                        NSString *renderingPage2 = [template renderObject:dataDic2 error:&err];
                        
                        if (err == nil) {
                            self.pdfRenderer = [[XMLPDFRenderer alloc] init];
                            
                            [self.pdfRenderer renderFromXML:rendering XML2:renderingPage2 toPDF:path dataOnly:isDataOnly];
                            return YES;
                            
                        }
                    }
                    
                    
                } 
                    NSString *rendering = [template renderObject:data error:&err];
                    
                    if (err == nil) {
                        self.pdfRenderer = [[XMLPDFRenderer alloc] init];
                        
                        [self.pdfRenderer renderFromXML:rendering toPDF:path dataOnly:isDataOnly];
                        
                        
                        return YES;
                    }
            
            } else {
                NSLog(@"CasePrintController的委托对象未实现相关协议中的dataForPDFTemplate方法");
            }
        }
    } else {
        NSLog(@"CasePrintController的委托对象未实现相关协议中的templateNameKey方法");
    }
    
    return NO;
}

- (NSRange)rangeOfString:(NSString *)str drawInRect:(CGRect)rect withFont:(UIFont *)font headIndent:(CGFloat)indent andLineHeight:(CGFloat)lineHeight
{
    return NSMakeRange(0, 0);
}

@end




