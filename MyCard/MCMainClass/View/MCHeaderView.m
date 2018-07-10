//
//  MCHeaderView.m
//  MyCard
//
//  Created by caohouhong on 2018/7/10.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCHeaderView.h"
@interface MCHeaderView()

@end
@implementation MCHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        [self mc_view];
    }
    return self;
}

- (void)mc_view {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"me_Bg"];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    
    _headerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _headerBtn.layer.cornerRadius = 30;
    _headerBtn.layer.masksToBounds = YES;
    _headerBtn.center = imageView.center;
    [_headerBtn setBackgroundImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    [imageView addSubview:_headerBtn];
    
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerBtn.frame) + 10, ScreenWidth, 30)];
    _loginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [imageView addSubview:_loginBtn];
}

@end
