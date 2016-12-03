//
//  XMGFileTool.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/1.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGFileTool.h"

@implementation XMGFileTool


+ (void)removeDirectoryPath:(NSString *)directoryPath{


    NSFileManager *mgr = [NSFileManager defaultManager];
    
    
    BOOL isDirectory;
    
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory){
        
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入的是文件夹路径，并且路径要存在" userInfo:nil];
        [excp raise];
        
    }

    //获取该目录下的所有文件  不包括子路径的子路径
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *subPath in subPaths) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        [mgr removeItemAtPath:filePath error:nil];
    }
}



//给一个文件夹路径 算该文件夹下所有文件的大小
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion{
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    
    BOOL isDirectory;
    
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory){
    
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入的是文件夹路径，并且路径要存在" userInfo:nil];
        [excp raise];
    
    }
   
   dispatch_async(dispatch_get_global_queue(0, 0), ^{
       NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
       NSInteger totalSize = 0;
       for (NSString *subPath in subPaths) {
           NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
           
           
           if ([filePath containsString:@".DS"]) continue;
           
           BOOL isDirectory;
           
           BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
           
           if (!isExist || isDirectory) continue;
           
           //只能获取文件尺寸  文件夹不行
           NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
           
           NSInteger fileSize = [attr fileSize];
           totalSize += fileSize;
           
           
       }
       
       dispatch_sync(dispatch_get_main_queue(), ^{
           if (completion) {
               completion(totalSize);
           }
       });
       
   });
    
    
   
    
    
    
}


@end
