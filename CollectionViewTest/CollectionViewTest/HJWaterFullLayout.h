//
//  HJWaterFullLayout.h
//  CollectionViewTest
//
//  Created by Jermy on 2018/5/23.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HJWaterFullLayoutDelegate<NSObject>

-(CGFloat) HJWaterFullLayoutItemHeightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface HJWaterFullLayout : UICollectionViewLayout
@property (nonatomic, assign) NSInteger numberOfCol;    //列数
@property (nonatomic, assign) NSInteger margin;         //行、列之间的填充

@property (nonatomic, weak) id<HJWaterFullLayoutDelegate> delegate;
@end
