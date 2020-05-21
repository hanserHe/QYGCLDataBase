//
//  HSTableViewCell.m
//  FMDBDemo
//
//  Created by Hanser on 2020/5/1.
//  Copyright © 2020 Hanser. All rights reserved.
//

#import "HSSqliteModel.h"
#import "HSTableViewCell.h"

@interface HSTableViewCell ()

@property (nonatomic, strong) UILabel *uuid;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *phone;
@property (nonatomic, strong) UILabel *score;

@end

@implementation HSTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configViews];
        [self setupFrames];

    }
    return self;
}


- (void)configViews {
    _uuid = [self createLabel];
    _name = [self createLabel];
    _phone = [self createLabel];
    _score = [self createLabel];
    
    [self addSubview:_uuid];
    [self addSubview:_name];
    [self addSubview:_phone];
    [self addSubview:_score];
}

- (void)setupFrames {
    _uuid.sd_layout.leftSpaceToView(self, 10).centerYEqualToView(self).widthIs(20).heightIs(12);
    _name.sd_layout.leftSpaceToView(_uuid, 10).centerYEqualToView(self).widthIs(60).heightIs(12);
    _phone.sd_layout.leftSpaceToView(_name, 10).centerYEqualToView(self).widthIs(120).heightIs(12);
    _score.sd_layout.leftSpaceToView(_phone, 10).centerYEqualToView(self).widthIs(30).heightIs(12);
}

- (UILabel *)createLabel {
    UILabel *label = UILabel.new;
    label.textColor = UIColor.blackColor;
    label.font = [UIFont systemFontOfSize:12];
    return label;
}


- (void)update:(HSSqliteModel *)model {
    _uuid.text = model.ID;
    _name.text = model.name;
    _phone.text = model.phone;
    _score.text = model.score;
    
}

@end
