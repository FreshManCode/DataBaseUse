//
//  JJBaseCollectionViewCell.m
//  UICollectionViewTest
//
//  Created by zhangjj on 15/12/24.
//  Copyright © 2015年 KingNet. All rights reserved.
//

#import "JJBaseCollectionViewCell.h"

@implementation JJBaseCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor purpleColor];
        [self addSubview:[self bgPicture]];
        [self addSubview:[self numBtn]];
        [self addSubview:[self nameLabel]];
    }
    
    return self;
}


- (UIImageView *)bgPicture{
    if(!_bgPicture){
        _bgPicture = [[UIImageView alloc]init];
    }
    
    return _bgPicture;
}

- (UIButton *)numBtn{
    if(!_numBtn){
        _numBtn = [[UIButton alloc]init];
        [_numBtn setBackgroundImage:[UIImage imageNamed:@"gift_icon"] forState:UIControlStateNormal];
        [_numBtn addTarget:self action:@selector(addGoodsInfo:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _numBtn;
}

- (UILabel *)nameLabel{
    if(!_nameLabel)
{
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        
    }
    
    return _nameLabel;
}

- (void)setBaseModel:(JJBaseModel *)baseModel{
    _baseModel = baseModel;
    _nameLabel.text = baseModel.titleName;
    _bgPicture.image = [UIImage imageNamed:baseModel.imageName];
}

- (void)layoutSubviews{
    _bgPicture.frame = CGRectMake(5, 5, CGRectGetWidth(self.frame)-5, CGRectGetHeight(self.frame)-35);
    _nameLabel.frame = CGRectMake(5, CGRectGetMaxY(_bgPicture.frame), CGRectGetWidth(self.frame)-35-5, 30);
    [_nameLabel sizeToFit];
    _numBtn.frame = CGRectMake(CGRectGetWidth(self.frame)-35, _nameLabel.frame.origin.y, 25,25);
}

- (void)addGoodsInfo:(UIButton *)sender{
    NSLog(@"加入到购物车,开启本地的数据库存住");
    JJBaseCollectionViewCell *cell =(JJBaseCollectionViewCell *)(sender.superview);
    if (_delegate &&[_delegate respondsToSelector:@selector(addGoodsToShoopingList:)]) {
        [_delegate addGoodsToShoopingList:cell.baseModel];
    }
    NSString *message = [NSString stringWithFormat:@"%@已经加入购物车了",_nameLabel.text];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}




@end
