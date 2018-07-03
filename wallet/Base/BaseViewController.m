//
//  BaseViewController.m
//  Keepcaring
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic,strong) UIImageView* noDataView;
@property(nonatomic,strong)ErrorView *errorView;

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    /**<设置导航栏背景颜色*/
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
	[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    [self.view addSubview:self.errorView];
}

- (void)refreshData {
    
    [self.view.subviews enumerateObjectsUsingBlock:^(UITableView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITableView class]]) {
            obj.hidden = YES;
            obj.hidden = NO;
            self.errorView.hidden = YES;
        }
    }];
}

-(void)showImagePage:(BOOL)show withIsError:(BOOL)error {

    self.errorView.isError = error;
    [self.view.subviews enumerateObjectsUsingBlock:^(UITableView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITableView class]]) {
            obj.hidden = YES;
            self.errorView.frame = obj.frame;
            self.errorView.hidden = NO;
        }
    }];
    if (error) {
        self.errorView.backgroudImageView.image = [UIImage imageNamed:@"loaderror_icon"];
    }else{
        self.errorView.backgroudImageView.image = [UIImage imageNamed:@"loaderror"];
    }
    
}

- (ErrorView *)errorView {
    if (_errorView == nil) {
        _errorView = [[ErrorView alloc] initWithFrame:CGRectZero];
        _errorView.backgroudImageView.image = [UIImage imageNamed:@"loaderror"];
        _errorView.contentMode = UIViewContentModeScaleAspectFit;
        _errorView.hidden = YES;
        typeof(self) weekSelf = self;
        _errorView.block = ^(NSInteger tag){
            weekSelf.errorView.hidden = YES;
            [weekSelf refreshData];
        };
    }
    return _errorView;
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
