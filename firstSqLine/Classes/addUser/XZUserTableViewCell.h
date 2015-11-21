//
//  XZUserTableViewCell.h
//  firstSqLine
//
//  Created by WZZ on 15/11/21.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userModel.h"
@interface XZUserTableViewCell : UITableViewCell

@property(nonatomic,weak) UILabel *nameLabel;

@property(nonatomic,weak) UILabel *ageLabel;

@property(nonatomic,weak) UILabel *IDLabel;

+ (instancetype)cellWithtableView:(UITableView *)tableView;

// 数据
@property(nonatomic,strong) userModel *usermodel;
@end
