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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)rightBarAction {
    
    [self deleteInfo];
}

- (void)deleteInfo {
    [[MCDataBase sharedDataBase] deleteModel:self.model];
    [LCProgressHUD showSuccess:@"删除成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}
@end
