//
//  ViewController.m
//  CollectionViewTest
//
//  Created by Jermy on 2018/5/22.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"
#include "HJCollectionViewLayout.h"
#include "WaterFullCollectionViewController.h"
#include "HJWaterFullLayout.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
//    HJCollectionViewLayout *layout = [[HJCollectionViewLayout alloc] init];
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.minimumLineSpacing = 10;
//    layout.minimumInteritemSpacing = 10;
//    layout.itemSize = CGSizeMake(100, 100);
    
    HJWaterFullLayout *layout = [[HJWaterFullLayout alloc] init];
    layout.numberOfCol = 5;
    layout.margin = 15;
    
    WaterFullCollectionViewController *collView = [[WaterFullCollectionViewController alloc] initWithCollectionViewLayout:layout];
    
    [self presentViewController:collView animated:YES completion:nil];
}
@end
