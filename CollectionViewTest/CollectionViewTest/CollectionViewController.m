//
//  CollectionViewController.m
//  CollectionViewTest
//
//  Created by Jermy on 2018/5/22.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController
{
    NSMutableArray *myChannel;
    NSMutableArray *recommendChannel;
}

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseSectionHeader = @"SectionHeader";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    NSArray *_mychannel = @[@"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注", @"关注"];
    myChannel = [NSMutableArray arrayWithArray:_mychannel];
    
    NSArray *_recommendChannel = @[@"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐", @"推荐"];
    recommendChannel = [NSMutableArray arrayWithArray:_recommendChannel];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseSectionHeader];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return myChannel.count;
            break;
            
        case 1:
            return recommendChannel.count;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UICollectionViewCell alloc] init];
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = cell.contentView.bounds;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor grayColor];
    
    if (indexPath.section == 1) {
        label.text = recommendChannel[indexPath.row];
    }else {
        label.text = myChannel[indexPath.row];
    }
    
    [cell.contentView addSubview:label];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseSectionHeader forIndexPath:indexPath];
    
    if (view == nil) {
        view = [[UICollectionReusableView alloc] init];
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, 0, 100, 40);
    label.textAlignment = NSTextAlignmentLeft;
    if (indexPath.section == 1) {
        label.text = @"推荐频道";
    }else {
        label.text = @"我的频道";
    }
    
    [view addSubview:label];
    
    return view;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *targetIndex;
    
    //选中section0中某个item
    if (indexPath.section == 0) {
        NSString *title = [myChannel objectAtIndex:indexPath.row];

        //删除选中的item
        [myChannel removeObjectAtIndex:indexPath.row];
        [collectionView deleteItemsAtIndexPaths:@[indexPath]];
        
        //添加到section中
        [recommendChannel addObject:title];
        targetIndex = [NSIndexPath indexPathForRow:(recommendChannel.count - 1) inSection:1];
        [collectionView insertItemsAtIndexPaths:@[targetIndex]];
        
    }else {
        
        NSString *title = [recommendChannel objectAtIndex:indexPath.row];

        //删除选中的item
        [recommendChannel removeObjectAtIndex:indexPath.row];
        [collectionView deleteItemsAtIndexPaths:@[indexPath]];
        
        //添加到section中
        [myChannel addObject:title];
        targetIndex = [NSIndexPath indexPathForRow:(myChannel.count - 1) inSection:0];
        [collectionView insertItemsAtIndexPaths:@[targetIndex]];
    }
    
}
@end
