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
    
    UIImageView *locationImageView = [[UIImageView alloc] init];
    locationImageView.image = [UIImage imageNamed:@"位置"];
    [self addSubview:locationImageView];
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(25);
        make.left.offset(15);
        make.top.mas_equalTo(self).offset(NavigationBarHeight+25);
    }];
    
    _locationLabel = [[UILabel alloc] init];
    _locationLabel.textColor = [UIColor whiteColor];
    _locationLabel.text = @"位置";
    [self addSubview:_locationLabel];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(locationImageView);
        make.left.mas_equalTo(locationImageView.mas_right).offset(3);
    }];
    
    UIImageView *weatherImageView = [[UIImageView alloc] init];
    weatherImageView.image = [UIImage imageNamed:@"天气"];
    [self addSubview:weatherImageView];
    [weatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(locationImageView);
        make.right.mas_equalTo(self).offset(-60);
        make.bottom.mas_equalTo(locationImageView.mas_centerY).offset(-2);
    }];

    _weatherLabel = [[UILabel alloc] init];
    _weatherLabel.textColor = [UIColor whiteColor];
    _weatherLabel.text = @"天气";
    [self addSubview:_weatherLabel];
    [_weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weatherImageView.mas_right).offset(2);
        make.centerY.mas_equalTo(weatherImageView);
    }];
    
    UIImageView *wenduImageView = [[UIImageView alloc] init];
    wenduImageView.image = [UIImage imageNamed:@"温度"];
    [self addSubview:wenduImageView];
    [wenduImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(locationImageView);
        make.right.mas_equalTo(weatherImageView);
        make.top.mas_equalTo(locationImageView.mas_centerY).offset(2);
    }];
    
    _wenduLabel = [[UILabel alloc] init];
    _wenduLabel.textColor = [UIColor whiteColor];
    _wenduLabel.text = @"气温";
    [self addSubview:_wenduLabel];
    [_wenduLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wenduImageView.mas_right).offset(2);
        make.centerY.mas_equalTo(wenduImageView);
    }];
    
}

@end
