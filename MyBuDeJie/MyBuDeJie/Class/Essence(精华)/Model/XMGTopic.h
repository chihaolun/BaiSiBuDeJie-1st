//
//  XMGTopic.h
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/5.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XMGTopicType){

    /** 全部 */
    XMGTopicTypeAll = 1,
    /** 图片 */
    XMGTopicTypePicture = 10,
    /** 段子 */
    XMGTopicTypeWord = 29,
    /** 声音 */
    XMGTopicTypeVoice = 31,
    /** 视频 */
    XMGTopicTypeVideo = 41
};



@interface XMGTopic : NSObject

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

@property (nonatomic, strong) NSArray *top_cmt;

@property (nonatomic, assign) NSInteger type;


@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

//在模型cellheight属性的get方法中计算高度和尺寸 把尺寸保存到自己属性中  这样模型传递的时候就把尺寸传出去了

@property (nonatomic, assign) CGRect middleFrame;

@property (nonatomic, assign) CGFloat cellHeight;



@property (nonatomic, copy) NSString *image0;
@property (nonatomic, copy) NSString *image2;
@property (nonatomic, copy) NSString *image1;

@property (nonatomic, assign) NSInteger voicetime;
@property (nonatomic, assign) NSInteger videotime;
@property (nonatomic, assign) NSInteger playcount;

@end
