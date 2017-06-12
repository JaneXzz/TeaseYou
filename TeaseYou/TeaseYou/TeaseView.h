//
//  TeaseView.h
//  TeaseYou
//
//  Created by Jane on 2017/3/29.
//  Copyright © 2017年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 聊天消息类型 */
typedef NS_ENUM(NSUInteger, MessageType) {
    TeaseViewText = 0,        /**< 挑逗文本 */
    TeaseViewGif = 1,      /**< 挑逗动图 */
};

@protocol TeaseViewDelegate <NSObject>

-(void)teaseText:(NSString *)textStr;
-(void)teaseGif:(NSString *)gif;

@end

@interface TeaseView : UIView

@end
