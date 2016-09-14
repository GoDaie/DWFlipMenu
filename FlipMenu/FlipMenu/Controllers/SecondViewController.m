//
//  SecondViewController.m
//  FlipMenu
//
//  Created by gskl on 16/9/14.
//  Copyright © 2016年 gsklDW. All rights reserved.
//

#import "SecondViewController.h"

#import "DWFlipCollectionView.h"
#import "DWTopSegementView.h"

#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"

#define SCRENN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCRENN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface SecondViewController ()<DWTopSegementViewDelegate,DWFlipCollectionViewDelegate>
@property (nonatomic , strong) DWTopSegementView *segmentView;

@property (nonatomic , strong) DWFlipCollectionView *collectView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.segmentView];

    ThirdViewController *third = [ThirdViewController new];
    FourthViewController *four = [FourthViewController new];
    FifthViewController *fif = [FifthViewController new];
    NSArray *controllerArray = @[third,four,fif];
    self.collectView = [[DWFlipCollectionView alloc]initWithFrame:CGRectMake(0, 40, SCRENN_WIDTH, SCRENN_HEIGHT - 80) withArray:controllerArray];
    self.collectView.delegate = self;
    [self.view addSubview:self.collectView];
}

#pragma mark -------- DWTopSegementViewDelegate,DWFlipCollectionViewDelegate
-(void)selectedIndex:(NSInteger)index{
    [self.collectView selectIndex:index];
    switch (index) {
        case 0:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ThirdViewShow" object:nil];
        }
            break;
        case 1:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FourthViewShow" object:nil];
        }
            break;
        case 2:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FifthViewShow" object:nil];
        }
            break;
        default:
            break;
    }
}

-(void)scrollChangeToIndex:(NSInteger)index{
    [self.segmentView selectIndex:index];
    switch (index) {
        case 1:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ThirdViewShow" object:nil];
        }
            break;
        case 2:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FourthViewShow" object:nil];
        }
            break;
        case 3:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FifthViewShow" object:nil];
        }
            break;
        default:
            break;
    }
}

- (void)scrollContentOffSetX:(CGFloat)x{
    [self.segmentView setLineY:x];
}



#pragma mark Getters
- (DWTopSegementView *)segmentView{
    if (!_segmentView) {
        NSArray *array = @[@"订单3",@"订单4",@"订单5"];
        _segmentView = [[DWTopSegementView alloc]initWithFrame:CGRectMake(0, 0, SCRENN_WIDTH, 40) withDataArray:array withFont:15 itemsWidth:SCRENN_WIDTH / 2.5];
        _segmentView.delegate = self;
        _segmentView.textNomalColor = [UIColor grayColor];
        _segmentView.textSelectedColor = [UIColor orangeColor];
        _segmentView.lineColor = [UIColor orangeColor];
//        _segmentView.titleFont = 15;
        _segmentView.lineWidth = 30;
    }
    return _segmentView;
}

@end
