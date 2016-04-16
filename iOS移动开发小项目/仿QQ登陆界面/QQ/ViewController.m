//
//  ViewController.m
//  QQ
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

<UINavigationControllerDelegate, UIImagePickerControllerDelegate>//添加监听协议（协议里是一些方法）

//用户头像
#define Width  self.view.frame.size.width//宏定义，全局变量，屏幕的宽度
#define Height self.view.frame.size.height//屏幕的高度
#define userImageW  0.25*Width//用户头像的宽度
#define userImageH  0.25*Width//用户头像高度
#define userImageX  (0.75*Width)/2//用户头像的X坐标---True
#define userImageY 80//用户头像的Y坐标

//账号输入框
#define acountW Width//账号宽度
#define acountH 50//高度
#define acountX 0//X坐标
#define acountY userImageY+userImageH+20//Y坐标

//密码输入框
#define passwordW Width//密码宽度
#define passwordH 50//高度
#define passwordX 0 //X坐标
#define passwordY acountY+acountH//Y坐标

//登陆按钮
#define loginX 30//X坐标
#define loginH 50//高度
#define loginY passwordY+passwordH+20//Y坐标
#define loginW Width-loginX*2//登陆宽度

//做出声明属性
@property(nonatomic,strong)UIButton *userImageBtn;//用户头像按钮
@property(nonatomic,strong)UITextField *acountTextField;//账户输入框
@property(nonatomic,strong)UITextField *passwordTextField;//密码输入框
@property(nonatomic,strong)UIButton *loginBtn;//登陆按钮
@end

@implementation ViewController

- (void)viewDidLoad {         //视图加载方法
    
    [super viewDidLoad];
    
    NSLog(@"ScreenWidth=%f,ScreenHeight=%f",Width,Height);//打印出视图屏幕的宽和高
    
    
    self.userImageBtn = [[UIButton alloc]initWithFrame:CGRectMake(userImageX, userImageY, userImageW, userImageH)];
    //定位用户头像按钮的坐标
    
    [self.userImageBtn addTarget:self action:@selector(setUserImageBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //添加一个用户头像监听事件
    
    //self.userImageBtn.backgroundColor=[UIColor redColor];//设置背景颜色
    UIImage*headerImage=[UIImage imageNamed:@"login_header@2x.png"];//给用户头像设置图片
    [self.userImageBtn setBackgroundImage:headerImage forState:(UIControlStateNormal)];//正常状态
    self.userImageBtn.layer.cornerRadius=userImageH/2;//切割成圆形
    self.userImageBtn.layer.masksToBounds=1;//布尔型 True 切割边角
    
    [self.view addSubview:self.userImageBtn];//为用户头像按钮添加到视图上
    
    //账户输入框
    self.acountTextField=[[UITextField alloc]initWithFrame:CGRectMake(acountX, acountY, acountW , acountH)];
    
    self.acountTextField.placeholder=@"请输入QQ号";//输入框的占位字符
    self.acountTextField.textAlignment=NSTextAlignmentCenter;//字符居中
    
    self.acountTextField.keyboardType=UIKeyboardTypeNumberPad;//设置键盘为数字键盘
    
    //self.acountTextField.backgroundColor=[UIColor redColor];//设置背景颜色
    
    UIImage*acountImage=[UIImage imageNamed:@"login_textfield@2x.png"];//给输入文本框设置图片
    [self.acountTextField setBackground:acountImage];//文本框设置背景且不要状态
    [self.view addSubview:self.acountTextField];//为账户输入框添加到视图上
    
    //密码输入框
    self.passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(passwordX, passwordY, passwordW , passwordH)];
    
    self.passwordTextField.placeholder=@"请输入QQ密码";//输入框的占位符
    self.passwordTextField.textAlignment=NSTextAlignmentCenter;//字符居中
    
    self.passwordTextField.secureTextEntry=1;//设置密文保护，不显示密码
    
    //self.passwordTextField.backgroundColor=[UIColor blueColor];//设置背景颜色
    
    //UIImage*passwordImage=[UIImage imageNamed:@"login_textfield@2x.png"];//给输入文本框设置图片
    //[self.passwordTextField setBackground:passwordImage];//文本框设置背景且不要状态
    [self.view addSubview:self.passwordTextField];//为密码输入框添加到视图上
    
    //登陆按钮
    self.loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(loginX, loginY, loginW , loginH)];
    //self.loginBtn.backgroundColor=[UIColor blackColor];//设置背景颜色
    
    UIImage*norImage=[UIImage imageNamed:@"login_btn_blue_nor@2x.png"];//给登陆按钮设置图片
    [self.loginBtn setBackgroundImage:norImage forState:(UIControlStateNormal)];//正常状态
    UIImage*pressImage=[UIImage imageNamed:@"login_btn_blue_press@2x.png"];
    [self.loginBtn setBackgroundImage:pressImage forState:(UIControlStateHighlighted)];//高亮状态
    
    [self.view addSubview:self.loginBtn];//为登陆按钮添加到视图上
    
    [self.loginBtn addTarget:self action:@selector(loginBtnClickListen) forControlEvents:(UIControlEventTouchUpInside)];//增加一个弹框监听事件
    
}
-(void)loginBtnClickListen{//定义弹框监听方法
    NSString*a=self.acountTextField.text;//获取输入的账户
    NSString*p=self.passwordTextField.text;//获取输入的密码
    if (a.length>0 && p.length>0) {
        //判断输入的长度不为0,否则....
        NSString*info=[NSString stringWithFormat:@"账号：%@ \n 密码：%@",a,p];
        
        UIAlertController*alertinfo=[UIAlertController alertControllerWithTitle:@"提示" message:info preferredStyle:(UIAlertControllerStyleAlert)];//弹出账户密码提示
        
        UIAlertAction*ok=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {//增加确定按钮
            NSLog(@"Are You kiding me??");
        }];
        [alertinfo addAction:ok];//添加ok行为
        [self presentViewController:alertinfo animated:1 completion:nil];//弹出

        
    }else{
        UIAlertController*alerterror=[UIAlertController alertControllerWithTitle:@"错误" message:@"账户密码不能为空！" preferredStyle:(UIAlertControllerStyleAlert)];//弹框属性
        
        UIAlertAction*ok=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Are You kiding me??");
        }];//添加弹框的确定按钮
        [alerterror addAction:ok];//添加ok行为
        [self presentViewController:alerterror animated:1 completion:nil];//弹出
        
    }
}

//定义头像设置的监听事件，已经在上面把这个方法添加进去了
-(void)setUserImageBtnAction:(UIButton*)userImageBtn{
    //图片选择器UIImagePickerController
    UIImagePickerController*imagePicker=[[UIImagePickerController alloc]init];//定义对象imagePicker
    
    imagePicker.delegate=self;//设置代理，监听图片选择器的操作过程，最上面已经添加了协议
    
    imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;//设置图片来源默认为相册
    
    [self presentViewController:imagePicker animated:YES completion:nil];//弹出图片选择器
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{  //调用代理协议中的方法
    
    [self.userImageBtn setBackgroundImage:image forState:(UIControlStateNormal)];//设置获取的图片为头像
    
    [picker dismissViewControllerAnimated:YES completion:nil];//退出图片控制器
}

@end
