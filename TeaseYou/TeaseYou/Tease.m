//
//  Tease.m
//  TeaseYou
//
//  Created by Jane on 2017/3/29.
//  Copyright © 2017年 Jane. All rights reserved.
//

#import "Tease.h"

@implementation Tease

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImage *img = [UIImage imageNamed:@"11.jpg"];
        CALayer *imgLayer = [CALayer layer];
        imgLayer.frame = CGRectMake(0, 6, 70, 70);
        imgLayer.contents = (id)img.CGImage;
        imgLayer.cornerRadius = 35;
        imgLayer.masksToBounds = YES;
        imgLayer.borderWidth = 1;
        imgLayer.borderColor = [UIColor orangeColor].CGColor;
        
        [self.layer addSublayer:imgLayer];
    }
    
    return self;
}


@end
