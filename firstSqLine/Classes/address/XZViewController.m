//
//  XZViewController.m
//  firstSqLine
//
//  Created by WZZ on 15/11/21.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import "XZViewController.h"
#import "userModel.h"
@interface XZViewController() <UITextFieldDelegate>

@end
@implementation XZViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addsubView];
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewUserInfo)];
    self.navigationItem.rightBarButtonItem = addBtn;
    
    // 删除数据按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"点击删除数据" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(deletaUserInfo) forControlEvents:UIControlEventTouchDown];
    
    self.navigationItem.titleView = button;
    
    [self addNewUserInfo];
}

- (void) addsubView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [doc stringByAppendingPathComponent:@"USER.sqlite"];
    NSLog(@"path===%@",path);
    self.dbPath = path;
    
    NSArray *array = [NSArray arrayWithObjects:@"姓名",@"年龄",@"ID", nil];
    for (int i = 0; i < 3 ; i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake( 70,i * 40 + 134, 100, 30)];
        label.text = [array objectAtIndex:i];
        [self.view addSubview:label];
    }
    
    _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(150, 138, 100, 30)];
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.placeholder = @"请输入姓名";
    _nameTextField.delegate = self;
    [self.view addSubview:_nameTextField];
    _ageTextField = [[UITextField alloc]initWithFrame:CGRectMake(150, 178, 100, 30)];
    _ageTextField.borderStyle = UITextBorderStyleRoundedRect;
    _ageTextField.placeholder = @"请输入年龄";
    _ageTextField.delegate = self;
    [self.view addSubview:_ageTextField];
    _IDTextField = [[UITextField alloc]initWithFrame:CGRectMake(150, 218, 100, 30)];
    _IDTextField.borderStyle = UITextBorderStyleRoundedRect;
    _IDTextField.placeholder = @"请输入ID";
    _IDTextField.delegate = self;
    [self.view addSubview:_IDTextField];
    if (self.model != nil) {
        self.nameTextField.text = self.model.name;
        self.ageTextField.text = self.model.age;
        self.IDTextField.text = self.model.ID;
    }
}

//添加详细信息
- (void)addNewUserInfo {

    FMDatabase *db = [[FMDatabase alloc] initWithPath:self.dbPath];
    if ([db open]) {
        
        if (_nameTextField.text.length == 0||_ageTextField.text.length == 0||_IDTextField.text.length == 0) {
            NSLog(@"不能为空");
        } else {
            NSLog(@"姓名==%@,年龄==%@,ID==%@",_nameTextField.text,_ageTextField.text,_IDTextField.text);
            NSString *sql = nil;
            if (self.operateType == 0) { // 执行插入操作
                sql = @"INSERT INTO USER (name,age,idcode) VALUES (?,?,?) ";
            } else if (_operateType == 1) { // 执行更新操作
                sql = @"UPDATE USER  SET name = ? , age = ? where idcode = ?";
            }
            BOOL res = [db executeUpdate:sql,_nameTextField.text,_ageTextField.text,_IDTextField.text];
            if (!res) {
                NSLog(@"数据插入错误");
            } else {
                if (self.operateType == 1) {
                    NSLog(@"%@",@"数据更新成功");
                } else {
                    NSLog(@"数据插入成功");
                }
            }
        }
    } else {
        NSLog(@"数据库打开失败");
    }
    [db close];
}

// 删除数据
- (void) deletaUserInfo {
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        
        NSString *sql = @"DELETE FROM USER WHERE name = ? and age = ? and idcode = ?";
        BOOL rs = [db executeUpdate:sql,self.nameTextField.text,self.ageTextField.text,self.IDTextField.text];// 后面三个参数就是sql语句的三个问号
        if (rs) {
            NSLog(@"删除成功");
            // 删除成功回到上一个
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"删除失败");
        }
    }
    [db close];
}

@end
