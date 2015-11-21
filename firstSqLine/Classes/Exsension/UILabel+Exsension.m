//
//  UILabel+Exsension.m
//  firstSqLine
//
//  Created by WZZ on 15/11/21.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import "UILabel+Exsension.h"

@implementation UILabel (Exsension)

+ (instancetype) userlabel {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    return label;
}

@end
