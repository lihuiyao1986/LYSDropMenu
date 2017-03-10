
//
//  MyCell.m
//  LYSDropMenu
//
//  Created by jk on 2017/3/10.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "MyCell.h"

// 获取16进制的颜色
#define hexColor(s,alpha) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alpha]

@interface MyCell (){
    UILabel *_label;
}

@end

@implementation MyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _label = [[UILabel alloc]init];
        _label.textColor = [UIColor whiteColor];
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
    _label.text = title;
    if ([selected isEqualToString:@"1"]) {
        _label.textColor = [UIColor redColor];
        self.contentView.backgroundColor = [self colorWithHexString:@"7a7a7a" alpha:0.8];
    }else{
        self.contentView.backgroundColor = [self colorWithHexString:@"000000" alpha:0.5];
        _label.textColor = [UIColor whiteColor];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 生成16进制颜色
-(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
