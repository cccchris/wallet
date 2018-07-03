//
//  MnemonicVC.m
//  wallet
//
//  Created by yanghuan on 2018/6/14.
//  Copyright © 2018年 wyChirs. All rights reserved.
//

#import "MnemonicVC.h"
#import "BackUpViewController.h"

@interface MnemonicVC ()
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation MnemonicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.navigationItem.title = @"助记词";
	self.lab.text = self.mnemonic;
}
- (IBAction)Action:(id)sender {
	BackUpViewController *vc = [[BackUpViewController alloc] initWithNibName:@"BackUpViewController" bundle:nil];
	vc.wordsAry = [self.lab.text componentsSeparatedByString:@" "];
	[self.navigationController pushViewController:vc animated:YES];
	
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
