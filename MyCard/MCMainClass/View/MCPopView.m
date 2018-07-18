//
//  MCPopView.m
//  MyCard
//
//  Created by caohouhong on 2018/7/13.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCPopView.h"
@interface MCPopView()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end
@implementation MCPopView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        [self mc_initView];
    }
    return self;
}

- (void)mc_initView {
    
    self.dataArray = @[@"全部",@"储蓄卡",@"信用卡",@"证件卡",@"会员卡",@"购物卡",@"电子卡",@"其他卡"];
    
    self.backgroundColor = [UIColor mc_colorWithHex:0x000000 alpha:0.3];
    
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-100, TopFullHeight+5, 95, 175)];
    holdView.backgroundColor = [UIColor whiteColor];
    holdView.layer.cornerRadius = 5.0;
    holdView.layer.masksToBounds = YES;
    [self addSubview:holdView];
    // 形状绘制
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    [holdView.layer addSublayer:shapeLayer];
    //绘制背景区域
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(holdView.frame.size.width/3*2, - 5)];
    [bezierPath addLineToPoint:CGPointMake(holdView.frame.size.width/3*2 + 5,0)];
    [bezierPath addLineToPoint:CGPointMake(holdView.frame.size.width/3*2 - 5,0)];
    shapeLayer.path = bezierPath.CGPath;
    
    UITapGestureRecognizer *atap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aTapAction)];
    atap.delegate = self;
    [self addGestureRecognizer:atap];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [holdView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(holdView);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.block){
        self.block(self.dataArray[indexPath.row]);
    }
    [self dismiss];
}

- (void)pop{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
    if([NSStringFromClass([touch.view class]) isEqual:@"UITableViewCellContentView"]){
        return NO;
    }
    return YES;
}

- (void)aTapAction {
    [self dismiss];
}

@end
