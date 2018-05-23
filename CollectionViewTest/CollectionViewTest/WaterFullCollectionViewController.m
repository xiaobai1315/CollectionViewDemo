//
//  WaterFullCollectionViewController.m
//  CollectionViewTest
//
//  Created by Jermy on 2018/5/23.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import "WaterFullCollectionViewController.h"
#import "Item.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HJWaterFullLayout.h"

@interface WaterFullCollectionViewController ()<HJWaterFullLayoutDelegate>
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation WaterFullCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    _imageArray = [NSMutableArray array];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil]];
    
    for (NSDictionary *dic in array) {
        Item *item = [Item ItemWithDict:dic];
        [_imageArray addObject:item];
    }
    
    //设置代理
    HJWaterFullLayout *layout = (HJWaterFullLayout *)self.collectionViewLayout;
    layout.delegate = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UICollectionViewCell alloc] init];
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = cell.contentView.bounds;
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = YES;
    [cell addSubview:imageView];
    
    Item *item = _imageArray[indexPath.item];
    NSURL *url = [NSURL URLWithString: item.img];
    [imageView sd_setImageWithURL:url];
    
    return cell;
}

-(CGFloat)HJWaterFullLayoutItemHeightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    Item *item = _imageArray[indexPath.item];
    return (item.h.floatValue * width / item.w.floatValue);
    
}

@end
