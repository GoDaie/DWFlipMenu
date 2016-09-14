//
//  DWFlipCollectionView.h
//  FlipMenu
//
//  Created by gskl on 16/9/13.
//  Copyright © 2016年 gsklDW. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DWFlipCollectionViewDelegate <NSObject>
/**
 *  Collect 滑动回调
 */
- (void)scrollChangeToIndex:(NSInteger)index;
/**
 *  偏移量回调
 *
 *  @param x
 */
- (void)scrollContentOffSetX:(CGFloat)x;
@end
@interface DWFlipCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic , assign) id<DWFlipCollectionViewDelegate> delegate;

@property (nonatomic,strong) UICollectionView *collectView;
/**
 *  存放对应的内容控制器
 */
@property (nonatomic,strong) NSMutableArray *dataArray;


/**
 *  初始化
 *
 *  @param frame
 *  @param contentArray 内容控制器数组
 */
- (instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)contentArray;
/**
 *  手动选择某个
 *
 *  @param index 从1开始
 */
- (void)selectIndex:(NSInteger)index;
@end
