//
//  CustomerTabBarController.m
//  Facebook_News_Feed
//
//  Created by 蒋永忠 on 16/9/7.
//  Copyright © 2016年 bigcode. All rights reserved.
//

#import "CustomerTabBarController.h"
#import "FeedController.h"
#import "RequestController.h"

@implementation CustomerTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    FeedController *feed = [[FeedController alloc] initWithCollectionViewLayout:layout];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:feed];
    nav.tabBarItem.title = @"News Feed";
    nav.tabBarItem.image = [UIImage imageNamed:@"Image"];
    [self addChildViewController:nav];
    
    RequestController *request = [[RequestController alloc] init];
    UINavigationController *requestNav = [[UINavigationController alloc] initWithRootViewController:request];
    requestNav.tabBarItem.title = @"Request";
    requestNav.tabBarItem.image = [UIImage imageNamed:@"requestsIcon"];
    [self addChildViewController:requestNav];
    
    UIViewController *message = [[UIViewController alloc] init];
    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:message];
    messageNav.tabBarItem.title = @"Message";
    messageNav.tabBarItem.image = [UIImage imageNamed:@"messengerIcon"];
    [self addChildViewController:messageNav];
    
    UIViewController *more = [[UIViewController alloc] init];
    UINavigationController *moreNav = [[UINavigationController alloc] initWithRootViewController:more];
    moreNav.tabBarItem.title = @"More";
    moreNav.tabBarItem.image = [UIImage imageNamed:@"moreIcon"];
    [self addChildViewController:moreNav];
}

@end
