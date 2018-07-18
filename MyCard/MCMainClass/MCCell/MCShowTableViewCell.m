//
//  MCShowTableViewCell.m
//  MyCard
//
//  Created by caohouhong on 2018/7/13.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCShowTableViewCell.h"
@interface MCShowTableViewCell()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *addTimeLabel;
@end

@implementation MCShowTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView {
    self.contentView.backgroundColor = [UIColor clearColor];
    _bgImageView = [[UIImageView alloc] init];
    _bgImageView.image = [UIImage imageNamed:@""];
    _bgImageView.layer.masksToBounds = YES;
    _bgImageView.layer.cornerRadius = 8;
    [self.contentView addSubview:_bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
    
    _typeLabel = [[UILabel alloc] init];
    _typeLabel.font = [UIFont boldSystemFontOfSize:18];
    _typeLabel.backgroundColor = [UIColor mc_colorWithHex:0x00000 alpha:0.4];
    _typeLabel.layer.cornerRadius = 13;
    _typeLabel.layer.masksToBounds = YES;
    _typeLabel.textColor = [UIColor whiteColor];
    _typeLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    _typeLabel.layer.borderWidth = 1;
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    _typeLabel.text = @"卡";
    [self.contentView addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView).offset(15);
        make.top.mas_equalTo(self.bgImageView).offset(15);
        make.width.height.mas_equalTo(26);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.text = @"名字";
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.typeLabel);
    }];
    
    _addTimeLabel = [[UILabel alloc] init];
    _addTimeLabel.font = [UIFont systemFontOfSize:13];
    _addTimeLabel.textColor = [UIColor whiteColor];
    _addTimeLabel.text = @"添加日期";
    [self.contentView addSubview:_addTimeLabel];
    [_addTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgImageView).offset(-10);
        make.bottom.mas_equalTo(self.bgImageView).offset(-8);
    }];
    
}

- (void)setModel:(MCModel *)model {
    _model = model;
    if ([model.type isEqualToString:@"电子卡"]){
        _bgImageView.image = [UIImage imageNamed:@"cardCell1"];
        
    }else if ([model.type isEqualToString:@"会员卡"]){
        _bgImageView.image = [UIImage imageNamed:@"cardCell3"];
    }else if ([model.type isEqualToString:@"储蓄卡"] || [model.type isEqualToString:@"信用卡"]){
        _bgImageView.image = [UIImage imageNamed:@"cardCell4"];
    }else {
        _bgImageView.image = [UIImage imageNamed:@"cardCell2"];
    }
    
    _typeLabel.text =  (model.type.length > 0) ? [model.type substringToIndex:1] : @"卡";
    _nameLabel.text = model.name;
    _addTimeLabel.text = [NSString stringWithFormat:@"添加日期:%@",model.addTime];
}

@end
