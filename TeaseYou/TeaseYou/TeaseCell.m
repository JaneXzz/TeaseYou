
//
//  TeaseCell.m
//  TeaseYou
//
//  Created by Jane on 2017/3/29.
//  Copyright © 2017年 Jane. All rights reserved.
//

#import "TeaseCell.h"

@implementation TeaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"hahhh");
    // Initialization code
}
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
}
+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}
@end
