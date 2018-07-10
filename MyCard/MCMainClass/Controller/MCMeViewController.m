//
//  MCMeViewController.m
//  MyCard
//
//  Created by caohouhong on 2018/7/10.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCMeViewController.h"
#import "MCNoticeViewController.h"
#import "MCHeaderView.h"
#import "MCEmailViewController.h"
#import "MCUserInfoViewController.h"
#import "MCLoginViewController.h"

@interface MCMeViewController ()<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) NSArray *sourceArray;
@property (strong, nonatomic) MCHeaderView *headerView;
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation MCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _headerView = [[MCHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250)];
    [_headerView.headerBtn addTarget:self action:@selector(mc_headerAction) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.tableHeaderView = _headerView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(-NavigationBarHeight);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    self.sourceArray = @[@"个人资料",@"绑定邮箱",@"公告",@"版本",@"退出登录"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessNotice) name:@"loginSuccess" object:nil];
    
    [self loginSuccessNotice];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.detailTextLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.sourceArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.sourceArray[indexPath.row]];
    if (indexPath.row == self.sourceArray.count - 2){//
        cell.detailTextLabel.text = [NSString stringWithFormat:@"v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            if ([self judegLogin]){
                 [self.navigationController pushViewController:[[MCUserInfoViewController alloc] init] animated:YES];
            }
            break;
        case 1:
            if ([self judegLogin]){
                [self.navigationController pushViewController:[[MCEmailViewController alloc] init] animated:YES];
            }
           
            break;
        case 2:
            [self.navigationController pushViewController:[[MCNoticeViewController alloc] init] animated:YES];
            break;
        case 3:
            break;
        case 4:
            [self mc_exit];
            break;
        default:
            break;
    }
}

- (void)mc_exit{
    if (![MCUserHelper mc_isLogin]) return;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MCUserHelper mc_setHeaderData:nil];
        [MCUserHelper mc_setUserName:nil];
        [MCUserHelper mc_setLoginWithString:@"0"];
        [self loginSuccessNotice];
        [LCProgressHUD showSuccess:@"退出成功"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)mc_headerAction {
    if ([self judegLogin]){
        UIAlertController *alVC = [UIAlertController alertControllerWithTitle:@"更改头像" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alVC addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self goWithcamera];
        }]];
        
        [alVC addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self goWithPhoto];
        }]];
        
        [alVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alVC animated:YES completion:nil];
    }
}

- (void)loginBtnAction:(UIButton *)button {
    if ([self judegLogin]){
        
    }
}

- (BOOL)judegLogin {
    if ([MCUserHelper mc_isLogin]){
        return YES;
    }else {
       [self.navigationController pushViewController:[[MCLoginViewController alloc] init] animated:YES];
        return NO;
    }
}

/** 相机 */
- (void)goWithcamera
{
    UIImagePickerControllerSourceType st = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        //设置拍照后的图片可被编辑
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = st;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
    }
}

/** 相册 */
- (void)goWithPhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    //设置拍照后的图片可被编辑
    imagePicker.sourceType = sourceType;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.headerView.headerBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.tableView reloadData];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = UIImageJPEGRepresentation(image, 0.1);
        [MCUserHelper mc_setHeaderData:data];
    });
}

- (void)loginSuccessNotice {
    if ([MCUserHelper mc_isLogin]){
        NSData *imagedata = [MCUserHelper mc_getHeaderData];
        UIImage *image = (imagedata) ? [UIImage imageWithData:imagedata] : [UIImage imageNamed:@"头像"];
        [_headerView.headerBtn setBackgroundImage:image forState:UIControlStateNormal];
        NSString *title = [MCUserHelper mc_getUsername];
        [_headerView.loginBtn setTitle:title forState:UIControlStateNormal];
    }else {
        [_headerView.headerBtn setBackgroundImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
        [_headerView.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    }
}

@end
