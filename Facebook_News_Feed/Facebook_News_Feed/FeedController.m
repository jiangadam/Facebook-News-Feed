//
//  FeedController.m
//  Facebook_News_Feed
//
//  Created by 蒋永忠 on 16/9/7.
//  Copyright © 2016年 bigcode. All rights reserved.
//

#import "FeedController.h"
#import "Feed.h"
#import "FeedCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface FeedController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *feeds;
@property (nonatomic, strong) UIImageView *feedImageView;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) UIImageView *zoomImageView;
@end

@implementation FeedController

- (NSArray *)feeds
{
    if (!_feeds) {
        _feeds = [Feed feeds];
    }
    return _feeds;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Facebook News Feed";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    NSLog(@"%@", self.feeds);
    self.collectionView.alwaysBounceVertical = true;
    
    // 注册cell
    [self.collectionView registerClass:[FeedCell class] forCellWithReuseIdentifier:@"FEEDCELL"];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.feeds.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FeedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FEEDCELL" forIndexPath:indexPath];
    cell.feed = self.feeds[indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *feedText = [self.feeds[indexPath.item] feedText];
    if (feedText) {
        NSString *feedTextS = [feedText stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
        CGRect rect = [feedTextS boundingRectWithSize:CGSizeMake(WIDTH, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        
        NSLog(@" feedContent:%f", rect.size.height);
        
        CGFloat knownHeight = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 1 + 44;
        
        NSLog(@"%f", rect.size.height + knownHeight);
        
        return CGSizeMake(WIDTH, rect.size.height + knownHeight + 16);
        
    }
    return CGSizeMake(WIDTH, 400);
}

- (UIView *)blackView
{
    if (!_blackView) {
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0;
    }
    return _blackView;
}

- (UIImageView *)zoomImageView
{
    if (!_zoomImageView) {
        _zoomImageView = [[UIImageView alloc] init];
        _zoomImageView.userInteractionEnabled = YES;
        _zoomImageView.contentMode = UIViewContentModeScaleAspectFill;
        _zoomImageView.clipsToBounds = YES;
    }
    return _zoomImageView;
}

// 放大图片
- (void)animateImageView:(UIImageView *)feedImageView
{
    self.feedImageView = feedImageView;
    

    [[UIApplication sharedApplication].keyWindow addSubview:self.blackView];
    
    self.zoomImageView.image = feedImageView.image;
    
    CGRect startFrame = [feedImageView.superview convertRect:feedImageView.frame toView:nil];
    
    CGFloat newHeight = (WIDTH / startFrame.size.width) * startFrame.size.height;
    CGFloat y = HEIGHT / 2 - newHeight / 2;
    self.zoomImageView.frame = startFrame;
    
    [self.blackView addSubview:self.zoomImageView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.blackView.alpha = 1;
        self.zoomImageView.alpha = 1;
        self.zoomImageView.frame = CGRectMake(0, y, WIDTH, newHeight);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOut)];
    [self.zoomImageView addGestureRecognizer:tap];
}

// 缩小图片
- (void)zoomOut
{
    CGRect startFrame = [self.feedImageView.superview convertRect:self.feedImageView.frame toView:nil];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.zoomImageView.frame = startFrame;
        self.zoomImageView.alpha = 0;
        self.blackView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.zoomImageView removeFromSuperview];
        [self.blackView removeFromSuperview];
    }];
}

@end
