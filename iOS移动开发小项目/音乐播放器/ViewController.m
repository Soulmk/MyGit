//
//  ViewController.m
//  音乐播放器
//
//  Created by lanou on 16/4/14.
//  Copyright © 2016年 MR.K. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

#define Width      self.view.frame.size.width
#define Height     self.view.frame.size.height//屏幕高度
#define ButtonW 50//按钮宽度
#define ButtonH 50
#define ButtonX (Width-ButtonW)/2
#define ButtonY 80



@interface ViewController ()
@property(nonatomic,strong)UIButton*playBtn;//创建按钮属性
@property(nonatomic,strong)AVAudioPlayer*player;//创建播放器属性


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //定位坐标
    self.playBtn=[[UIButton alloc]initWithFrame:CGRectMake(ButtonX, ButtonY, ButtonW, ButtonH)];
    UIImage*image1=[UIImage imageNamed:@"play.png"];//载入图片
    [self.playBtn setBackgroundImage:image1 forState:(UIControlStateNormal)];//正常
    UIImage*image2=[UIImage imageNamed:@"play_h.png"];//载入图片
    [self.playBtn setBackgroundImage:image2 forState:(UIControlStateHighlighted)];//高亮
    
    [self.playBtn addTarget:self action:@selector(playOrPause:) forControlEvents:(UIControlEventTouchUpInside)];//添加一个按钮监听
    
    [self.view addSubview:self.playBtn];//将图片加载到视图中
    
    //初始化播放器
    //定义歌曲的文件路径
    NSString*path=[[NSBundle mainBundle] pathForResource:@"林俊杰-背对背拥抱" ofType:@"mp3"];
    
    NSURL*url=[NSURL fileURLWithPath:path];    //定义文件URL
    self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    
    [self.player prepareToPlay];//加载歌曲文件
    
}

//被监听的事件方法
-(void)playOrPause:(UIButton*)btn{
    if ([self.player isPlaying]) {    //判断是否在播放
        [self.player pause];//暂停
        UIImage*image1=[UIImage imageNamed:@"pause.png"];//载入图片
        [self.playBtn setBackgroundImage:image1 forState:(UIControlStateNormal)];//正常
    }else{
        [self.player play];//播放
        UIImage*image1=[UIImage imageNamed:@"play.png"];//载入图片
        [self.playBtn setBackgroundImage:image1 forState:(UIControlStateNormal)];//正常
    }
}
@end
