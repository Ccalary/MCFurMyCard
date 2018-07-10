//
//  MCUserInfoViewController.m
//  MyCard
//
//  Created by caohouhong on 2018/7/10.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCUserInfoViewController.h"

@interface MCUserInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation MCUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    NSData *imagedata = [MCUserHelper mc_getHeaderData];
    UIImage *image = (imagedata) ? [UIImage imageWithData:imagedata] : [UIImage imageNamed:@"头像"];
    self.headerImageView.image = image;
    NSString *title = [MCUserHelper mc_getUsername];
    self.nameLabel.text = title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
@end
