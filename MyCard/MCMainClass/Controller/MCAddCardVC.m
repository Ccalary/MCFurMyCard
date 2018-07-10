//
//  MCAddCardVC.m
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCAddCardVC.h"
#import "MCModel.h"
#import "MCDataBase.h"
#import "MCUserHelper.h"

@interface MCAddCardVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *numberText;
@property (weak, nonatomic) IBOutlet UITextField *remarkText;
@property (weak, nonatomic) IBOutlet UIButton *frontBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (assign, nonatomic) int type;
@property (strong, nonatomic) NSMutableDictionary *mDictionary;
@property (strong, nonatomic) MCModel *model;

@end

@implementation MCAddCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[MCModel alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (IBAction)frontViewAction:(UIButton *)sender {
    [self.view endEditing:YES];
    self.type = 1;
    [self photoViewActionWithTitle:@"正面图片"];
}

- (IBAction)backViewAction:(UIButton *)sender {
    [self.view endEditing:YES];
    self.type = 2;
    [self photoViewActionWithTitle:@"背面图片"];
}

// Done
- (void)rightBarAction {
    self.model.name = self.nameText.text;
    self.model.numbers = self.numberText.text;
    self.model.remarks = self.remarkText.text;
    self.model.type = self.navigationItem.title;
    [[MCDataBase sharedDataBase] addMCModel:self.model];
   
    [LCProgressHUD showSuccess:@"添加成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

// 点击事件
- (void)photoViewActionWithTitle:(NSString *)title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camerAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotoLibrary];
    }];
    [alertController addAction:camerAction];
    UIAlertAction *almAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }];
    [alertController addAction:almAction];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction: cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

/** 相机 */
- (void)openCamera
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        
        [LCProgressHUD showInfoMsg:@"无法拍照"];
    }
}

/** 相册 */
- (void)openPhotoLibrary
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //设置拍照后的图片可被编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHMMss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    self.model.addTime = dateStr;
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (self.type == 1){
        [self.frontBtn setTitle:@"" forState:UIControlStateNormal];
        self.frontImageView.image = image;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = UIImageJPEGRepresentation(image, 0.1);
            [MCUserHelper mc_setImageData:data WithKey:[NSString stringWithFormat:@"front%@",dateStr]];
        });
       
    }else {
        [self.backBtn setTitle:@"" forState:UIControlStateNormal];
        self.backImageView.image = image;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = UIImageJPEGRepresentation(image, 0.1);
            [MCUserHelper mc_setImageData:data WithKey:[NSString stringWithFormat:@"back%@",dateStr]];
        });
    }
}
@end
