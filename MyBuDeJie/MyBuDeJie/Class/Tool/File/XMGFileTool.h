//
//  XMGFileTool.h
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/1.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGFileTool : NSObject

+ (void)removeDirectoryPath:(NSString *)directoryPath;

+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;

@end
