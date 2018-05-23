//
//  Item.m
//  CollectionViewTest
//
//  Created by Jermy on 2018/5/23.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import "Item.h"

@implementation Item

- (instancetype) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    self.w = dict[@"w"];
    self.h = dict[@"h"];
    self.img = dict[@"img"];
    
    return self;
}

+ (instancetype) ItemWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
