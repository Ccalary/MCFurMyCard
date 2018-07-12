//
//  MCCardInfoVC.m
//  MyCard
//
//  Created by caohouhong on 2018/7/10.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCCardInfoVC.h"
#import "MCUserHelper.h"
#import "MCDataBase.h"

@interface MCCardInfoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@property (strong, nonatomic) UIImageView *holdImageView;
@end

@implementation MCCardInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.model.type;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    self.frontImageView.image = [UIImage imageWithData:[MCUserHelper mc_getImagedataWithKey:[NSString stringWithFormat:@"front%@",self.model.addTime]]];
    self.backImageView.image = [UIImage imageWithData:[MCUserHelper mc_getImagedataWithKey:[NSString stringWithFormat:@"back%@",self.model.addTime]]];
    self.nameLabel.text = self.model.name;
    self.numberLabel.text = self.model.numbers;
    self.remarkLabel.text = self.model.remarks;
    [self addTap];
}

- (void)addTap {
    self.frontImageView.userInteractionEnabled = YES;
    self.backImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *atap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(frontTap)];
    [self.frontImageView addGestureRecognizer:atap];
    
    UITapGestureRecognizer *atap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTap)];
    [self.backImageView addGestureRecognizer:atap1];
    
    _holdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _holdImageView.contentMode = UIViewContentModeScaleAspectFit;
    _holdImageView.hidden = YES;
    _holdImageView.userInteractionEnabled = YES;
    _holdImageView.backgroundColor = [UIColor mc_colorWithHex:0x000000 alpha:0.8];
    [[[UIApplication sharedApplication] keyWindow] addSubview:_holdImageView];
     UITapGestureRecognizer *atapHold = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(holdTap)];
    [_holdImageView addGestureRecognizer:atapHold];
}

- (void)frontTap {
    _holdImageView.image = self.frontImageView.image;
    _holdImageView.hidden = NO;
}

- (void)backTap {
    _holdImageView.image = self.backImageView.image;
    _holdImageView.hidden = NO;
}

- (void)holdTap {
    _holdImageView.hidden = YES;
    _holdImageView.image = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)rightBarAction {
    
    [self deleteInfo];
}
- (IBAction)copy:(id)sender {
    UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
    pastboard.string = self.numberLabel.text;
    [LCProgressHUD showSuccess:@"卡号复制成功"];
}

- (void)deleteInfo {
    [[MCDataBase sharedDataBase] deleteModel:self.model];
    [LCProgressHUD showSuccess:@"删除成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}
@end
