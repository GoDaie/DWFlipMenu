//
//  DWTopSegementView.h
//  FlipMenu
//
//  Created by gskl on 16/9/13.
//  Copyright © 2016年 gsklDW. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DWTopSegementViewDelegate <NSObject>
/**
 *  选择回调
 *
 *  @param index
 */
-(void)selectedIndex:(NSInteger)index;
@end
@interface DWTopSegementView : UIView
@property (nonatomic , weak) id<DWTopSegementViewDelegate>delegate;

/**
 *  视图Array
 */
@property (nonatomic, strong) NSArray *dataArray;
/**
 *  字体非选中时颜色(默认黑色)
 */
@property (nonatomic, strong) UIColor *textNomalColor;
/**
 *  字体选中时颜色(默认红色)
 */
@property (nonatomic, strong) UIColor *textSelectedColor;
/**
 *  横线颜色(默认红色)
 */
@property (nonatomic, strong) UIColor *lineColor;
/**
 *  字体大小
 */
@property (nonatomic, assign) CGFloat titleFont;
/**
 *  横线边距(默认没有0)
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 *  初始化
 *
 *  @param frame      frame
 *  @param dataArray  标题数组
 *  @param font       标题字体大小
 *  @param itemsWidth 每个标题按钮宽度
 *
 *  @return instance
 */
- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray withFont:(CGFloat)font itemsWidth:(CGFloat)itemsWidth;
/**
 *  手动选择
 *
 *  @param index 从 1 开始
 */
- (void)selectIndex:(NSInteger)index;
/**
 *  下面横线滑动
 *
 *  @param y
 */
- (void)setLineY:(CGFloat)y;

@end
