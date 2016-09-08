//
//  Feed.m
//  Facebook_News_Feed
//
//  Created by 蒋永忠 on 16/9/7.
//  Copyright © 2016年 bigcode. All rights reserved.
//

#import "Feed.h"

@implementation Feed

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)feedWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)feeds
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"feeds.plist" ofType:nil];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        Feed *feed = [Feed feedWithDict:dict];
        [tempArr addObject:feed];
    }
    return tempArr;
}

@end
