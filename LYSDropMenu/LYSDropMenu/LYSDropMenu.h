//
//  LYSDropMenu.h
//  LYSDropMenu
//
//  Created by jk on 2017/3/8.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYSDropMenu;

@protocol LYSDropMenuDelegate <NSObject>

@optional

-(void)setMainItemViewStyle:(UIView*)view;

-(void)handleItemView:(UITableViewCell*)itemView item:(NSMutableDictionary*)item;

-(void)itemDidSelected:(LYSDropMenu*)menu item:(NSMutableDictionary*)item;

-(void)dropdownMenuWillShow:(LYSDropMenu*)menu;

-(void)dropdownMenuDidShow:(LYSDropMenu*)menu;

-(void)dropdownMenuWillHide:(LYSDropMenu*)menu;

-(void)dropdownMenuDidHide:(LYSDropMenu*)menu;

@end

@interface LYSDropMenu : UIButton

#pragma mark - 每个Item高度
@property(nonatomic,assign)CGFloat itemH;

#pragma mark - 数据
@property(nonatomic,copy)NSArray<NSMutableDictionary*> *items;

#pragma mark - 显示最大的个数
@property(nonatomic,assign)NSUInteger maxShowCount;

#pragma mark - 当前选中item的索引
@property(nonatomic,assign)NSUInteger selectedIndex;

#pragma mark - 每个item对应的视图Class
@property(nonatomic,assign)Class itemClazz;

#pragma mark - 主item对应的视图Class
@property(nonatomic,assign)Class mainItemClazz;

#pragma mark - 代理
@property(nonatomic,weak)id<LYSDropMenuDelegate> delegate;

#pragma mark - 显示下拉列表
-(void)showDropDownMenu;

#pragma mark - 隐藏下拉菜单
-(void)hideDropDownMenu;

@end
