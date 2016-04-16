//
//  ViewController.m
//  轮播图
//
//  Created by lanou on 16/4/13.
//  Copyright © 2016年 MR.K. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<UIScrollViewDelegate>//添加监听协议（协议里是一些方法）

#define Width self.view.frame.size.width
#define Height self.view.frame.size.height
#define pageControlW 200//设置页面指示器的宽度
#define pageControlH 30
#define pageControlX (Width-pageControlW)/2
#define pageControlY Height-80
//声明属性
@property(nonatomic,strong)UIScrollView*scrollView;//声明滑动视图属性
@property(nonatomic,strong)UIPageControl*pageControl;//声明滑动页面指示器属性


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];//滑动视图大小
    self.scrollView.pagingEnabled=YES;//设置使用一页一页翻转模式
    self.scrollView.bounces=NO;//关闭边界回弹效果
    
    for (int i=0; i<8; i++){
        UIImage*image;
        if (i==0) {
            image=[UIImage imageNamed:@"6.jpg"];//i=0时载入6.jpg图片
        }else if (i==7){
            image=[UIImage imageNamed:@"1.jpg"];//i=7时载入1.jpg图片
        }else{
            image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];//i=1~6时，循环载入图片
        }
        UIImageView*myImageView=[[UIImageView alloc]initWithFrame:CGRectMake(Width*i, 0, Width, Height)];
        myImageView.image=image;//显示图片
        [self.scrollView addSubview:myImageView];//将图片加载到滑动视图
    }
    
    self.scrollView.contentSize=CGSizeMake(8*Width, Height);//总框架大小（滑动区域）
    
    self.scrollView.delegate=self;//设置滑动视图代理，监听滑动过程
    
    self.scrollView.contentOffset=CGPointMake(Width, 0);//设置最初始偏移量
    
    //self.scrollView.backgroundColor=[UIColor redColor];//设置背景颜色
    [self.view addSubview:self.scrollView];//添加滑动视图到屏幕
    
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH)];//创建页面指示器
    self.pageControl.numberOfPages=6;//页面指示器有几个点
    self.pageControl.currentPageIndicatorTintColor=[UIColor redColor];//当前页面的小圆点颜色为红色
    self.pageControl.pageIndicatorTintColor=[UIColor greenColor];//设置默认页面的小圆点颜色
    [self.view addSubview:self.pageControl];//添加指示器到屏幕
    
    //开启一个定时器
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoShow:) userInfo:@"cycle" repeats:YES];
}

//下列为定义的所有方法

-(void)autoShow:(NSTimer*)timer{//定义定时器方法
    NSString*str=timer.userInfo;
    NSLog(@"%@",str);
    int index=self.scrollView.contentOffset.x / Width;      //得到当前页面数
    int next=index+1;                                                    //获取下一个页面数
    [self.scrollView setContentOffset:CGPointMake(next*Width, 0) animated:YES];//获取偏移
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{//监听滑动偏移
    //NSLog(@"%f",self.scrollView.contentOffset.x);//打印偏移量x坐标
    //self.scrollView.contentOffset
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{//监听滑动停止
    //NSLog(@"End!!!");
    int index=self.scrollView.contentOffset.x / Width;//获取偏移量x坐标，除以屏幕宽度得到当前页面数
    //NSLog(@"当前页面：%d",index);
    
    if(index==0){
        [self.scrollView setContentOffset:CGPointMake(6*Width, 0) animated:NO];
        self.pageControl.currentPage=5;//设置页面数为5，跳转到第6张图片
    }else if (index==7) {
        [self.scrollView setContentOffset:CGPointMake(Width, 0) animated:NO];
        self.pageControl.currentPage=0;//设置页面数为0，跳转到第1张图片
    }else{
        self.pageControl.currentPage=index-1;//设置页面当前页数
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{//设置滑动停止时调用
    int index=self.scrollView.contentOffset.x / Width;//获取偏移量x坐标，除以屏幕宽度得到当前页面数
    if(index==0){
        [self.scrollView setContentOffset:CGPointMake(6*Width, 0) animated:NO];
        self.pageControl.currentPage=5;//设置页面数为5，跳转到第6张图片
    }else if (index==7) {
        [self.scrollView setContentOffset:CGPointMake(Width, 0) animated:NO];
        self.pageControl.currentPage=0;//设置页面数为0，跳转到第1张图片
    }else{
        self.pageControl.currentPage=index-1;//设置页面当前页数
    }
}

@end
