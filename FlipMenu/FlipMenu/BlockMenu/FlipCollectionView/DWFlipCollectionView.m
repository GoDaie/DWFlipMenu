//
//  DWFlipCollectionView.m
//  FlipMenu
//
//  Created by gskl on 16/9/13.
//  Copyright © 2016年 gsklDW. All rights reserved.
//

#import "DWFlipCollectionView.h"

@implementation DWFlipCollectionView
#pragma mark Init
- (instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)contentArray{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] init];
        [self.dataArray addObjectsFromArray:contentArray];
        self.frame = frame;
        [self addSubview:self.collectView];
    }
    return self;
}
#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    UIViewController *vc = [_dataArray objectAtIndex:indexPath.row];
    vc.view.frame = cell.bounds;
    [cell.contentView addSubview:vc.view];//将控制器的  视图添加到Item 上
    return cell;
}

#pragma mark --- scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(scrollChangeToIndex:)]) {
        int index = scrollView.contentOffset.x / self.frame.size.width;
        
        [self.delegate scrollChangeToIndex:index + 1];
    }
}
/**
 *  滑动偏移量 回调
 *
 *  @param scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(scrollContentOffSetX:)]) {
        [self.delegate scrollContentOffSetX:scrollView.contentOffset.x];
    }
}
#pragma mark --- select onesIndex
- (void)selectIndex:(NSInteger)index{
    [_collectView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}
#pragma mark Getter
- (UICollectionView *)collectView{
    if (!_collectView) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.scrollDirection = 1;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _collectView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:flowLayout];
        _collectView.frame = self.bounds;
        _collectView.pagingEnabled = YES;
        _collectView.showsHorizontalScrollIndicator = NO;
        _collectView.backgroundColor = [UIColor clearColor];
        _collectView.delegate = self;
        _collectView.dataSource = self;
        [_collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    }
    return _collectView;
}
@end
