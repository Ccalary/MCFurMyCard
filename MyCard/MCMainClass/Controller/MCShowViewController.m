//
//  MCShowViewController.m
//  MyCard
//
//  Created by caohouhong on 2018/7/10.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCShowViewController.h"
#import "MCModel.h"
#import "MCDataBase.h"
#import "MCCardInfoVC.h"

@interface MCShowViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//保存原始数据
@property (strong, nonatomic) NSMutableArray *dataArray;
//保存搜索数据
@property (nonatomic, strong) NSMutableArray *searchArray;
//是否是搜索状态
@property (nonatomic, assign) BOOL isSearch;
@end

@implementation MCShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.searchArray = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([MCUserHelper mc_isLogin]){
       [self requestData];
    }else {
        [LCProgressHUD showMessage:@"未登录"];
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //是否搜索状态
    if (_isSearch){
        return _searchArray.count;
    }else {
        return _dataArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    MCModel *model = _isSearch ? self.searchArray[indexPath.row] : self.dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%@",model.name,model.type];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MCModel *model = _isSearch ? self.searchArray[indexPath.row] : self.dataArray[indexPath.row];
    MCCardInfoVC *vc = [[MCCardInfoVC alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)requestData {
    NSArray *array = [[MCDataBase sharedDataBase] getAllModel];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:array];
    [self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate
//取消按钮的点击事件
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //取消搜索状态
    _isSearch = NO;
    searchBar.text = @"";
    //关闭键盘
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}

//当搜索框内的文本改变时激发该方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self filterBySubstring:searchText];
}
//点击search按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self filterBySubstring:searchBar.text];
    //关闭键盘
    [searchBar resignFirstResponder];
}

//过滤
- (void)filterBySubstring:(NSString *)substr{
    //设置搜索状态
    _isSearch = YES;
    //定义搜索谓词
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", substr];
    [self.searchArray removeAllObjects];
    if (substr.length == 0){
        [self.searchArray addObjectsFromArray:self.dataArray];
    }else {
        //使用谓词过滤NSArray
        for (MCModel *model in self.dataArray){
            if ([model.name containsString:substr] || [model.type containsString:substr]){
                [self.searchArray addObject:model];
            }
        }
    }
    //让表格重新加载数据
    [self.tableView reloadData];
}

@end
