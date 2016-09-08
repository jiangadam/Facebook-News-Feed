//
//  FeedCell.m
//  Facebook_News_Feed
//
//  Created by 蒋永忠 on 16/9/7.
//  Copyright © 2016年 bigcode. All rights reserved.
//

#import "FeedCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "FeedController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface FeedCell ()
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextView *feedTextView;
@property (nonatomic, strong) UIImageView *feedImageView;
@property (nonatomic, strong) UILabel *likeCommentsLabel;
@property (nonatomic, strong) UIView *dividerLine;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) FeedController *feedController;
@end

@implementation FeedCell

- (FeedController *)feedController
{
    if (!_feedController) {
        _feedController = [[FeedController alloc] init];
    }
    return _feedController;
}

- (void) animate
{
    [self.feedController animateImageView:self.feedImageView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubViews];
    }
    return self;
}

- (UIImageView *)profileImageView
{
    if (!_profileImageView) {
        _profileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Targaryen"]];
        _profileImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _profileImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}

- (UITextView *)feedTextView
{
    if (!_feedTextView) {
        _feedTextView = [[UITextView alloc] init];
        _feedTextView.font = [UIFont systemFontOfSize:14];
        _feedTextView.scrollEnabled = false;
    }
    return _feedTextView;
}

- (UIImageView *)feedImageView
{
    if (!_feedImageView) {
        _feedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pokemon"]];
        _feedImageView.contentMode = UIViewContentModeScaleAspectFill;
        _feedImageView.layer.masksToBounds = YES;
        _feedImageView.userInteractionEnabled = YES;
    }
    return _feedImageView;
}

- (UILabel *)likeCommentsLabel
{
    if (!_likeCommentsLabel) {
        _likeCommentsLabel = [[UILabel alloc] init];
        _likeCommentsLabel.text = @"100 Likes 19k Comments";
        _likeCommentsLabel.font = [UIFont boldSystemFontOfSize:12];
        _likeCommentsLabel.textColor = [UIColor colorWithRed:0.61 green:0.63 blue:0.67 alpha:1.00];
    }
    return _likeCommentsLabel;
}

- (UIView *)dividerLine
{
    if (!_dividerLine) {
        _dividerLine = [[UIView alloc] init];
        _dividerLine.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.91 alpha:1.00];
    }
    return _dividerLine;
}

- (UIButton *)likeButton
{
    if (!_likeButton) {
        _likeButton = [self buttonForTitle:@"Like" andImage:[UIImage imageNamed:@"like"]];
    }
    return _likeButton;
}

- (UIButton *)commentButton
{
    if (!_commentButton) {
        _commentButton = [self buttonForTitle:@"Comment" andImage:[UIImage imageNamed:@"comment"]];
    }
    return _commentButton;
}

- (UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [self buttonForTitle:@"Share" andImage:[UIImage imageNamed:@"share"]];
    }
    return _shareButton;
}

- (void)setFeed:(Feed *)feed
{
    _feed = feed;

    NSString *name = feed.name;
    if (name) {
        NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        [attributeText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\nAugust 17,Shanghai" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12], NSForegroundColorAttributeName:[UIColor colorWithRed:0.61 green:0.63 blue:0.67 alpha:1.00]}]];
        self.nameLabel.attributedText = attributeText;
    }
    
    if (feed.feedText) {
        self.feedTextView.text = [feed.feedText stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    }
    
    if (feed.profileImageName) {
        self.profileImageView.image = [UIImage imageNamed:feed.profileImageName];
    }
    
    if (feed.feedImageUrl) {
        [self.feedImageView sd_setImageWithURL:[NSURL URLWithString:feed.feedImageUrl] placeholderImage:[UIImage imageNamed:@"Pokemon"]];
    }
}

- (void)setSubViews
{
    __weak __typeof(self) weakSelf = self;
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.profileImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.feedTextView];
    [self addSubview:self.feedImageView];
    [self addSubview:self.likeCommentsLabel];
    [self addSubview:self.dividerLine];
    [self addSubview:self.likeButton];
    [self addSubview:self.commentButton];
    [self addSubview:self.shareButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animate)];
    [self.feedImageView addGestureRecognizer:tap];
    
    [self.profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
        make.top.equalTo(weakSelf.mas_top).offset(8);
        make.left.equalTo(weakSelf.mas_left).offset(8);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.profileImageView.mas_right).offset(12);
        make.top.equalTo(weakSelf.profileImageView.mas_top);
        make.height.equalTo(weakSelf.profileImageView.mas_height);
        make.right.equalTo(weakSelf.mas_right);
    }];
    
    [self.feedTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.profileImageView.mas_bottom).offset(4);
        make.left.equalTo(weakSelf.mas_left).offset(4);
        make.right.equalTo(weakSelf.mas_right).offset(-4);
        make.bottom.equalTo(weakSelf.feedImageView.mas_top).offset(-4);
    }];
    
    [self.feedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.likeCommentsLabel.mas_top).offset(-8);
        make.height.mas_equalTo(200);
    }];
    
    [self.likeCommentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(12);
        make.right.equalTo(weakSelf.mas_right).offset(12);
        make.height.mas_equalTo(24);
        make.bottom.equalTo(weakSelf.dividerLine.mas_top).offset(-8);
    }];
    
    [self.dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(12);
        make.right.equalTo(weakSelf.mas_right).offset(-12);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(weakSelf.likeButton.mas_top);
    }];
    
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.mas_equalTo(44);
        make.width.equalTo(weakSelf.commentButton.mas_width);
    }];
    
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.likeButton.mas_top);
        make.width.equalTo(weakSelf.likeButton.mas_width);
        make.height.equalTo(weakSelf.likeButton.mas_height);
        make.left.equalTo(weakSelf.likeButton.mas_right);
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.likeButton.mas_top);
        make.right.equalTo(weakSelf.mas_right);
        make.width.equalTo(weakSelf.likeButton.mas_width);
        make.height.equalTo(weakSelf.likeButton.mas_height);
        make.left.equalTo(weakSelf.commentButton.mas_right);
    }];
}

- (UIButton *)buttonForTitle:(NSString *)title andImage:(UIImage *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.56 green:0.59 blue:0.64 alpha:1.00] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    return button;
}

@end
