//
//  ViewController.m
//  MyTomCat
//
//  Created by lanou on 16/4/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *tomCatView;




@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    int a=[self m1:@"aaaaa" m2:@"222222"];
    NSLog(@"%d",a);


    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)eatBirdAction:(id)sender {
    //创建数组用来存入图片
    NSMutableArray*eatImages=[NSMutableArray array];
    
    for (int i=0; i<40; i++) {
        //循环创建每一张图片的名字，格式化数字i 循环拼接出来
        NSString*name=[NSString stringWithFormat:@"eat_%d.jpg",i];
        
        //根据图片名字创建图片对象，加载进内存
        UIImage*image=[UIImage imageNamed:name];
        
        //将图片添加到数组中
        [eatImages addObject:image];
    }
    
    //设置播放动画图片的图片数组
    self.tomCatView.animationImages=eatImages;
    //动画时长
    self.tomCatView.animationDuration=40*0.1;
    //动画次数
    self.tomCatView.animationRepeatCount=1;
    //启动动画
    [self.tomCatView startAnimating];
}

- (IBAction)cymbal:(id)sender {
    NSMutableArray*cymbalImages=[NSMutableArray array];
    for (int i; i<13; i++) {
        NSString*name=[NSString stringWithFormat:@"cymbal_%d.jpg",i];
        UIImage*image=[UIImage imageNamed:name];
        [cymbalImages addObject:image];
        
    }
    //动画图片
    self.tomCatView.animationImages=cymbalImages;
    //动画时长
    self.tomCatView.animationDuration=13*0.1;
    //动画次数
    self.tomCatView.animationRepeatCount=1;
    //启动动画
    [self.tomCatView startAnimating];
}


- (IBAction)drink:(id)sender {
    NSMutableArray*drinkImages=[NSMutableArray array];
    for (int i; i<81; i++) {
        NSString*name=[NSString stringWithFormat:@"drink_%d.jpg",i];
        UIImage*image=[UIImage imageNamed:name];
        [drinkImages addObject:image];
        
    }
    //动画图片
    self.tomCatView.animationImages=drinkImages;
    //动画时长
    self.tomCatView.animationDuration=81*0.1;
    //动画次数
    self.tomCatView.animationRepeatCount=1;
    //启动动画
    [self.tomCatView startAnimating];
}

- (IBAction)fart:(id)sender {
    NSMutableArray*fartImages=[NSMutableArray array];
    for (int i; i<28; i++) {
        NSString*name=[NSString stringWithFormat:@"fart_%d.jpg",i];
        UIImage*image=[UIImage imageNamed:name];
        [fartImages addObject:image];
        
    }
    //动画图片
    self.tomCatView.animationImages=fartImages;
    //动画时长
    self.tomCatView.animationDuration=28*0.1;
    //动画次数
    self.tomCatView.animationRepeatCount=1;
    //启动动画
    [self.tomCatView startAnimating];
    
    
}


- (IBAction)pie:(id)sender {
    NSMutableArray*pieImages=[NSMutableArray array];
    for (int i; i<24; i++) {
        NSString*name=[NSString stringWithFormat:@"pie_%d.jpg",i];
        UIImage*image=[UIImage imageNamed:name];
        [pieImages addObject:image];
        
    }
    //动画图片
    self.tomCatView.animationImages=pieImages;
    //动画时长
    self.tomCatView.animationDuration=24*0.1;
    //动画次数
    self.tomCatView.animationRepeatCount=1;
    //启动动画
    [self.tomCatView startAnimating];
}
- (IBAction)angry:(id)sender {
    NSMutableArray*angryImages=[NSMutableArray array];
    for (int i; i<26; i++) {
        NSString*name=[NSString stringWithFormat:@"angry_%d.jpg",i];
        UIImage*image=[UIImage imageNamed:name];
        [angryImages addObject:image];
        
    }
    //动画图片
    self.tomCatView.animationImages=angryImages;
    //动画时长
    self.tomCatView.animationDuration=26*0.1;
    //动画次数
    self.tomCatView.animationRepeatCount=1;
    //启动动画
    [self.tomCatView startAnimating];
}
- (IBAction)footleft:(id)sender {
    NSMutableArray*footleftImages=[NSMutableArray array];
    for (int i; i<30; i++) {
        NSString*name=[NSString stringWithFormat:@"footLeft_%d.jpg",i];
        UIImage*image=[UIImage imageNamed:name];
        [footleftImages addObject:image];
        
    }
    //动画图片
    self.tomCatView.animationImages=footleftImages;
    //动画时长
    self.tomCatView.animationDuration=30*0.1;
    //动画次数
    self.tomCatView.animationRepeatCount=1;
    //启动动画
    [self.tomCatView startAnimating];
}
- (IBAction)footright:(id)sender {
    NSMutableArray*footrightImages=[NSMutableArray array];
    for (int i; i<30; i++) {
        NSString*name=[NSString stringWithFormat:@"footRight_%d.jpg",i];
        UIImage*image=[UIImage imageNamed:name];
        [footrightImages addObject:image];
        
    }
    //动画图片
    self.tomCatView.animationImages=footrightImages;
    //动画时长
    self.tomCatView.animationDuration=30*0.1;
    //动画次数
    self.tomCatView.animationRepeatCount=1;
    //启动动画
    [self.tomCatView startAnimating];
}

- (IBAction)scratch:(id)sender {
    NSMutableArray*scratchImages=[NSMutableArray array];
    for (int i; i<56; i++) {
        NSString*name=[NSString stringWithFormat:@"scratch_%d.jpg",i];
        UIImage*image=[UIImage imageNamed:name];
        [scratchImages addObject:image];
        
    }
    //动画图片
    self.tomCatView.animationImages=scratchImages;
    //动画时长
    self.tomCatView.animationDuration=56*0.1;
    //动画次数
    self.tomCatView.animationRepeatCount=1;
    //启动动画
    [self.tomCatView startAnimating];
}


-(int)m1:(NSString*)str1 m2:(NSString*)str2{
//  第一种方法：先字符串拼接再取长度
//    NSString*str3=[NSString stringWithFormat:@"%@%@",str1,str2];
//    int len=str3.length;
//    return len;
    return str1.length+str2.length;
}


@end
