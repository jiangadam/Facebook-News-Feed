//
//  RequestController.m
//  Facebook_News_Feed
//
//  Created by 蒋永忠 on 16/9/8.
//  Copyright © 2016年 bigcode. All rights reserved.
//

#import "RequestController.h"
#import "SDImageCache.h"

@interface RequestController ()
@property (nonatomic, strong) UILabel *cacheView;
@property (nonatomic, strong) UIButton *deleteBtn;
@end

@implementation RequestController

- (UILabel *)cacheView
{
    if (!_cacheView) {
        _cacheView = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 200, 24)];
        _cacheView.tintColor = [UIColor redColor];
    }
    return _cacheView;
}

- (UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _deleteBtn.frame = CGRectMake(20, 140, 100, 24);
    }
    return _deleteBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Request";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.cacheView];
    [self showCacheFileSize];
    
    [self.view addSubview:self.deleteBtn];
    [self.deleteBtn addTarget:self action:@selector(deleteCachaFile) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showCacheFileSize
{
    float tmpSize = [[SDImageCache sharedImageCache] getSize];
    NSLog(@"%f", tmpSize);
    
    NSLog(@"cache: %.1fM", tmpSize / 1024 / 1024);
    
    self.cacheView.text = [NSString stringWithFormat:@"cache:%.1f M", tmpSize / 1024 / 1024];
    
}

- (void)deleteCachaFile
{
    
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    
    [self showCacheFileSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
