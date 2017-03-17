//
//  JJBaseCell.m
//  UICollectionViewTest
//
//  Created by zhangjj on 15/12/25.
//  Copyright © 2015年 KingNet. All rights reserved.
//

#import "JJBaseCell.h"

@implementation JJBaseCell


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *indentifier = CustomCellIdentifier;
    JJBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if(!cell){
        cell = [[JJBaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
    return cell;
    
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:[self topSepratorLine]];
        [self.contentView addSubview:[self picture]];
        [self.contentView addSubview:[self nameLabel]];
        [self.contentView addSubview:[self numIcon]];
        [self.contentView addSubview:[self numAmount]];
         _contentHeight = CGRectGetMaxY(_picture.frame)+CGRectGetMaxY(_bottomSepratorLine.frame);
        
    }
    
    return self;
}

//- (void)layoutSubviews{
//    
//}

- (UIImageView *)picture{
    if(!_picture)
    {
        _picture = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, fDeviceWidth-150, 80-0.5)];
        
    }
    return _picture;
}

- (UILabel *)nameLabel{
    if(!_nameLabel){
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_picture.frame), 5, 120, 30)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor greenColor];
    }
    return _nameLabel;
}

- (UIImageView *)numIcon{
    if(!_numIcon){
        
        _numIcon = [[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth-130, CGRectGetMaxY(_nameLabel.frame), 30, 30)];
        _numIcon.image = [UIImage imageNamed:@"apply_icon"];
    }
    return _numIcon;
}

- (UILabel *)numAmount{
    if(!_numAmount){
        _numAmount = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numIcon.frame), CGRectGetMaxY(_numIcon.frame)-25, 60, 20)];
        
    }
    return _numAmount;
}

- (UIView *)topSepratorLine{
    if(!_topSepratorLine){
        _topSepratorLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1.0)];
        _topSepratorLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _topSepratorLine;
}

- (UIView *)bottomSepratorLine{
    if(!_bottomSepratorLine){
        _bottomSepratorLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentHeight-0.5*2, self.frame.size.width, 0.5*2)];
        _bottomSepratorLine.backgroundColor = [UIColor redColor];
        
    }
    return _bottomSepratorLine;
}



- (void)setBaseModel:(JJBaseModel *)baseModel{
    _baseModel = baseModel;
    self.nameLabel.text = baseModel.titleName;
    self.picture.image = [UIImage imageNamed:baseModel.imageName];
    self.numAmount.text = [NSString stringWithFormat:@"%d",baseModel.menuNum + 1];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
