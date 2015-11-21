//
//  XZViewController.h
//  firstSqLine
//
//  Created by WZZ on 15/11/21.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userModel.h"
@interface XZViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *textFieldArray;

@property (nonatomic, strong) NSString *dbPath;

@property (nonatomic, strong) UITextField *nameTextField;

@property (nonatomic, strong) UITextField *ageTextField;

@property (nonatomic, strong) UITextField *IDTextField;

//保存操作类型，0是添加，1是修改
@property (nonatomic, assign) NSInteger operateType;

@property(nonatomic,strong) userModel *model;
@end
