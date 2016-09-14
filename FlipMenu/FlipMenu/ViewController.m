//
//  ViewController.m
//  FlipMenu
//
//  Created by gskl on 16/9/13.
//  Copyright © 2016年 gsklDW. All rights reserved.
//

#import "ViewController.h"

#import "DWFlipCollectionView.h"
#import "DWTopSegementView.h"

#import "FirstViewController.h"
#import "SecondViewController.h"


#define SCRENN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCRENN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<DWTopSegementViewDelegate,DWFlipCollectionViewDelegate>

@property (nonatomic , strong) DWTopSegementView *segmentView;

@property (nonatomic , strong) DWFlipCollectionView *collectView;

@end

@implementation ViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstClick) name:@"firstClick" object:nil];
    
    [self.view addSubview:self.segmentView];
    FirstViewController *first = [FirstViewController new];
    first.currenVc = self;
    SecondViewController *second = [SecondViewController new];
    
    NSArray *controllerArray = @[first,second];//将要展现的视图控制器  初始化
    self.collectView = [[DWFlipCollectionView alloc]initWithFrame:CGRectMake(0, 60, SCRENN_WIDTH, SCRENN_HEIGHT - 40) withArray:controllerArray];
    self.collectView.delegate = self;
    [self.view addSubview:self.collectView];

}
#pragma mark Notification

- (void)firstClick{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"这里是第三个Vc.View" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -------- DWTopSegementViewDelegate,DWFlipCollectionViewDelegate  这三个代理方法都要实现
/**
 *  Segment Click 点击回调
 *
 *  @param index  从 0 开始
 */
-(void)selectedIndex:(NSInteger)index{
    [self.collectView selectIndex:index];
    if (index == 2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ThirdViewShow" object:nil];
    }
}
/**
 *  Collection 滑动回调
 *
 *  @param index 从 1 开始
 */
-(void)scrollChangeToIndex:(NSInteger)index{
    [self.segmentView selectIndex:index];
    if (index == 3) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ThirdViewShow" object:nil];
    }
}
/**
 *  Collection 滑动偏移量回调
 */
- (void)scrollContentOffSetX:(CGFloat)x{
    [self.segmentView setLineY:x];
}



#pragma mark Getters
- (DWTopSegementView *)segmentView{
    if (!_segmentView) {
        NSArray *array = @[@"订单1",@"订单2"];
        _segmentView = [[DWTopSegementView alloc]initWithFrame:CGRectMake(0, 20, SCRENN_WIDTH, 40) withDataArray:array withFont:18 itemsWidth:SCRENN_WIDTH / 2];
        _segmentView.delegate = self;
    }
    return _segmentView;
}
@end
