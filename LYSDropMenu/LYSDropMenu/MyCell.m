
//
//  MyCell.m
//  LYSDropMenu
//
//  Created by jk on 2017/3/10.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "MyCell.h"


@interface MyCell (){
    UILabel *_label;
}

@end

@implementation MyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _label = [[UILabel alloc]init];
        _label.textColor = [UIColor blackColor];
//        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:14];
        _label.numberOfLines = 1;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_label];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _label.frame = CGRectMake(10, 0, self.bounds.size.width - 20, self.bounds.size.height);
}

-(void)setItem:(NSMutableDictionary *)item{
    NSString * title = item[@"name"];
    NSString * selected = item[@"selected"];
    if ([selected isEqualToString:@"1"]) {
        _label.textColor = [UIColor redColor];
    }else{
        _label.textColor = [UIColor blackColor];
    }
    _label.text = title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
