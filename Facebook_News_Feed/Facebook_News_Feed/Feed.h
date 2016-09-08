//
//  Feed.h
//  Facebook_News_Feed
//
//  Created by 蒋永忠 on 16/9/7.
//  Copyright © 2016年 bigcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feed : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *profileImageName;
@property (nonatomic, copy) NSString *feedText;
@property (nonatomic, copy) NSString *feedImageName;
@property (nonatomic, copy) NSString *feedImageUrl;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)feedWithDict:(NSDictionary *)dict;
+ (NSArray *)feeds;
@end
