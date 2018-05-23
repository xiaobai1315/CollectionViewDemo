//
//  HJCollectionViewLayout.m
//  CollectionViewTest
//
//  Created by Jermy on 2018/5/22.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import "HJCollectionViewLayout.h"

@implementation HJCollectionViewLayout
{
    NSInteger width;
    NSInteger height;
    NSInteger margin;
    NSInteger numPerRow;
    NSInteger totalSection;
    NSMutableDictionary *itemsPerSection;
    NSMutableDictionary *sectionHeight;
    NSInteger headerHeight;
    NSInteger headerWidth;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    width = 80;
    height = 40;
    margin = 10;
    headerHeight = 40;
    headerWidth = 100;
    
    //每行可容纳item个数
    numPerRow = ([UIScreen mainScreen].bounds.size.width - margin) / (width + margin);
    
    //collectionview section个数
    totalSection = [self.collectionView numberOfSections];
    
    //计算每个section item的个数和section的高度
    itemsPerSection = [NSMutableDictionary dictionary];
    sectionHeight = [NSMutableDictionary dictionary];
    
    for (NSInteger i = 0; i < totalSection; i++) {
        
        NSInteger items = [self.collectionView numberOfItemsInSection:i];
        [itemsPerSection setObject:@(items) forKey:@(i)];
        
        CGFloat _height = items / numPerRow * (height + margin);
        [sectionHeight setObject:@(_height) forKey:@(i)];
    }
    
}

-(CGSize)collectionViewContentSize
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    return CGSizeMake(0, 0);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *arr = [NSMutableArray array];
    NSInteger section = self.collectionView.numberOfSections;
    
    for (NSInteger i = 0; i < section; i++) {
        
        UICollectionViewLayoutAttributes *headerAtt = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        [arr addObject:headerAtt];
        
        UICollectionViewLayoutAttributes *footerAtt = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        [arr addObject:footerAtt];
        
        NSInteger rowCount = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0; j < rowCount; j++) {
            UICollectionViewLayoutAttributes *cellAtt = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            [arr addObject:cellAtt];
        }
    }
    
    return arr;
    
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger row = indexPath.item / numPerRow; //行
    NSInteger col = indexPath.item % numPerRow; //列
    
    CGFloat x = width * col + margin * (col + 1);
    CGFloat y = height * row + margin * (row + 1) + headerHeight;
    
    if (indexPath.section == 1) {
        NSNumber *height = [sectionHeight objectForKey:@(1)];
        y = y + height.integerValue;
        y = y + headerHeight;
    }
    
    att.frame = CGRectMake(x, y, width, height);
    
    return att;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
    
    CGFloat y = 0;
    
    if (indexPath.section == 1) {
        NSNumber *height = [sectionHeight objectForKey:@(1)];
        y = y + height.integerValue + headerHeight;
    }
    
    att.frame = CGRectMake(20, y, headerWidth, headerHeight);
    
    return att;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
