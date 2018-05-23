//
//  Item.h
//  CollectionViewTest
//
//  Created by Jermy on 2018/5/23.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject
@property (nonatomic, strong) NSNumber *w;
@property (nonatomic, strong) NSNumber *h;
@property (nonatomic, copy) NSString *img;

+ (instancetype) ItemWithDict:(NSDictionary *)dict;
@end
