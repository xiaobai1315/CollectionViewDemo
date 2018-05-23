//
//  HJWaterFullLayout.m
//  CollectionViewTest
//
//  Created by Jermy on 2018/5/23.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import "HJWaterFullLayout.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width

@implementation HJWaterFullLayout
{
    NSMutableArray *_elementsAttributes;    //保存每个item的布局属性
    NSMutableDictionary *_ColHeightDict; //存储每列的元素的总高度
    CGFloat _itemWidth; //根据列数计算item的宽度
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    _elementsAttributes = [NSMutableArray array];

    _itemWidth = (ScreenW - 6 * _margin) / _numberOfCol;
    
    //每列的初始高度都是_margin
    _ColHeightDict = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < _numberOfCol; i++) {
        [_ColHeightDict setObject:@(_margin) forKey:@(i)];
    }
    
    //布局item
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++){
        UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [_elementsAttributes addObject:att];
    }
}

//collectionView的滚动区域
-(CGSize)collectionViewContentSize
{
    NSNumber *temp = @(0);
    for (NSInteger i = 0; i < _numberOfCol; i++) {
        NSNumber *item = [_ColHeightDict objectForKey:@(i)];
        if (temp.floatValue < item.floatValue) {
            temp = item;
        }
    }
    
    return CGSizeMake(0, temp.floatValue);
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //查找最短的列，将item加到最短列最后
    NSNumber *temp = [_ColHeightDict objectForKey:@(0)];
    NSInteger index = 0;
    for (NSInteger i = 0; i < _numberOfCol; i++) {
        NSNumber *item = [_ColHeightDict objectForKey:@(i)];
        if (temp.floatValue > item.floatValue) {
            temp = item;
            index = i;
        }
    }
    
    CGFloat itemHeight = 0;
    if ([self.delegate respondsToSelector:@selector(HJWaterFullLayoutItemHeightForWidth:atIndexPath:)]) {
         itemHeight = [self.delegate HJWaterFullLayoutItemHeightForWidth:_itemWidth atIndexPath:indexPath];
    }
    
    CGFloat x = (_itemWidth + _margin) * index + _margin;
    CGFloat y = temp.floatValue;
    
    att.frame = CGRectMake(x, y, _itemWidth, itemHeight);
    
    //更新列高度数据
    CGFloat _newHeight = temp.floatValue + itemHeight + _margin;
    [_ColHeightDict setObject:@(_newHeight) forKey:@(index)];
    
    return att;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _elementsAttributes;
}



@end
