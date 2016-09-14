//
//  DWTopSegementView.m
//  FlipMenu
//
//  Created by gskl on 16/9/13.
//  Copyright © 2016年 gsklDW. All rights reserved.
//

#import "DWTopSegementView.h"
#import "DWMaskLabel.h"

#define DWSEGEMENT_HEIGHT self.frame.size.height
#define DWSEGEMENT_WIDTH self.frame.size.width
@interface DWTopSegementView ()
/**
 *  Label Array
 */
@property (nonatomic , strong) NSMutableArray *labelsArray;
/**
 *  滑动的横线
 */
@property (nonatomic , strong) UIView *lineImageView;
/**
 *  每个 Label 宽度
 */
@property (nonatomic , assign) CGFloat itemWidth;
/**
 *  Scroll
 */
@property (nonatomic , strong) UIScrollView *scrollV;
/**
 *  滑块
 */
@property (nonatomic , strong) UIView *maskView;
@end
@implementation DWTopSegementView
#pragma arm Init
- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray withFont:(CGFloat)font itemsWidth:(CGFloat)itemsWidth{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        self.itemWidth = itemsWidth;
        self.backgroundColor = [UIColor whiteColor];
        _labelsArray = [[NSMutableArray alloc] init];
        _dataArray = dataArray;
        _titleFont = font;
        _lineWidth = 0;
        
        //默认未选中的 为黑色  选中的为SelectColor
        self.textNomalColor = [UIColor blackColor];
        self.textSelectedColor = [UIColor redColor];
        self.lineColor = [UIColor redColor];
        [self addSubSegmentView];
    }
    return self;
}
- (void)addSubSegmentView{
    float width = self.itemWidth;
    [self addSubview:self.scrollV];
    [self.scrollV addSubview:self.maskView];
    for (int i = 0 ; i < _dataArray.count ; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, DWSEGEMENT_HEIGHT)];
        button.tag = i + 1;
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        DWMaskLabel *label = [[DWMaskLabel alloc]initWithFrame:CGRectMake(i * width, -5, width, DWSEGEMENT_HEIGHT)];
        label.text = [_dataArray objectAtIndex:i];
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:_titleFont];
        label.textAlignment = NSTextAlignmentCenter;
        [self.scrollV addSubview:label];
        [self.labelsArray addObject:label];
        [self.scrollV addSubview:button];
    }
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, DWSEGEMENT_HEIGHT - 2, self.scrollV.contentSize.width, 2)];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    [self.scrollV addSubview:bottomView];
    self.lineImageView = [[UIView alloc] initWithFrame:CGRectMake(self.lineWidth, DWSEGEMENT_HEIGHT - 2, width - self.lineWidth * 2, 2)];
    self.lineImageView.backgroundColor = _lineColor;
    [self.scrollV addSubview:self.lineImageView];
}

/**
 *  Btn Click
 */
- (void)tapAction:(id)sender{
    UIButton *button = (UIButton *)sender;
    [self.scrollV scrollRectToVisible:CGRectMake(button.frame.origin.x, DWSEGEMENT_HEIGHT - 2, button.frame.size.width, 2) animated:YES];
    if ([self.delegate respondsToSelector:@selector(selectedIndex:)]) {
        [self.delegate selectedIndex:button.tag -1];
    }
}
/**
 *  Collection 滑动后 设置选择Item
 */
- (void)selectIndex:(NSInteger)index{
    UILabel *subLabel = self.labelsArray[index - 1];
    [UIView animateWithDuration:0.6 animations:^{
        self.lineImageView.frame = CGRectMake(subLabel.frame.origin.x + self.lineWidth, DWSEGEMENT_HEIGHT - 2, subLabel.frame.size.width - self.lineWidth * 2, 2);
    }];
    [self.scrollV scrollRectToVisible:CGRectMake(subLabel.frame.origin.x, DWSEGEMENT_HEIGHT - 2, subLabel.frame.size.width, 2) animated:YES];
}
/**
 *  Collection 滑动偏移量
 *
 *  @param y Collection 滑动偏移量  设置横线位置
 */
- (void)setLineY:(CGFloat)y{
    CGRect rectL = self.lineImageView.frame;
    CGFloat offSet = y * self.itemWidth / [UIScreen mainScreen].bounds.size.width;
    self.maskView.frame = CGRectMake(offSet, 0, self.itemWidth, DWSEGEMENT_HEIGHT);
    self.lineImageView.frame = CGRectMake(offSet + self.lineWidth, rectL.origin.y, rectL.size.width, rectL.size.height);
}

#pragma mark Setter//-->>具体看.h
- (void)setLineWidth:(CGFloat)lineWidth{
    if (_lineWidth != lineWidth) {
        self.lineImageView.frame = CGRectMake(lineWidth, DWSEGEMENT_HEIGHT - 2, self.itemWidth - lineWidth * 2, 2);
        _lineWidth = lineWidth;
    }
}
- (void)setLineColor:(UIColor *)lineColor{
    if (_lineColor != lineColor) {
        self.lineImageView.backgroundColor = lineColor;
        _lineColor = lineColor;
    }
}

- (void)setTextNomalColor:(UIColor *)textNomalColor{
    if (_textNomalColor != textNomalColor) {
        self.scrollV.backgroundColor = textNomalColor;
        _textNomalColor = textNomalColor;
    }
}

- (void)setTextSelectedColor:(UIColor *)textSelectedColor{
    if (_textSelectedColor != textSelectedColor) {
        _textSelectedColor = textSelectedColor;
        self.maskView.backgroundColor = textSelectedColor;
    }
}

- (void)setTitleFont:(CGFloat)titleFont{
    if (_titleFont != titleFont) {
        for (DWMaskLabel *subLabel in self.labelsArray) {
            subLabel.font = [UIFont systemFontOfSize:titleFont];
        }
        _titleFont = titleFont;
    }
}

#pragma mark Getter
- (UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DWSEGEMENT_WIDTH, DWSEGEMENT_HEIGHT)];
        CGFloat scroWidth = _dataArray.count * self.itemWidth;
        _scrollV.contentSize = CGSizeMake(scroWidth, DWSEGEMENT_HEIGHT);
        _scrollV.backgroundColor = [UIColor clearColor];
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.backgroundColor = [UIColor blackColor];
    }
    return _scrollV;
}
- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.itemWidth, DWSEGEMENT_HEIGHT)];
        _maskView.backgroundColor = [UIColor colorWithRed:25/255.f green:182/255.f blue:158/255.f alpha:1];
    }
    return _maskView;
}
@end
