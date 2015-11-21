//
//  XZUserTableViewCell.m
//  firstSqLine
//
//  Created by WZZ on 15/11/21.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import "XZUserTableViewCell.h"

@implementation XZUserTableViewCell

- (void)awakeFromNib {

}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self setupSubView];
    }
    return self;
}

+ (instancetype)cellWithtableView:(UITableView *)tableView {
    XZUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubView];
    }
    return self;
}

#pragma mark - 添加子控件
- (void) setupSubView {
    UILabel *namelabel = [UILabel userlabel];
    [self addSubview:namelabel];
    self.nameLabel = namelabel;
    
    UILabel *ageLabel = [UILabel userlabel];
    [self addSubview:ageLabel];
    self.ageLabel = ageLabel;
    
    UILabel *IDlabel = [UILabel userlabel];
    [self addSubview:IDlabel];
    self.IDLabel = IDlabel;
}

#pragma mark - 设置frame
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = XZScreenW / 3;
    CGFloat height = self.frame.size.height;
    self.nameLabel.frame = CGRectMake(0, 0, width, height);
    
    self.ageLabel.frame = CGRectMake(width, 0, width, height);
    
    self.IDLabel.frame = CGRectMake(width * 2, 0, width, height);
}

#pragma mark - set & get
- (void)setUsermodel:(userModel *)usermodel {
    _usermodel = usermodel;
    self.nameLabel.text = usermodel.name;
    self.ageLabel.text = usermodel.age;
    self.IDLabel.text = usermodel.ID;
}

@end
