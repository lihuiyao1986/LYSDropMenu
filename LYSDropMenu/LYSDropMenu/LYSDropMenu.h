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

#pragma mark - 设置主itemview的样式
-(void)setMainItemViewStyle:(UIView*)view;

#pragma mark - 处理itemView
-(void)handleItemView:(UITableViewCell*)itemView item:(NSMutableDictionary*)item;

#pragma mark - 菜单被选中
-(void)itemDidSelected:(LYSDropMenu*)menu item:(NSMutableDictionary*)item;

#pragma mark - 下拉菜单即将出现
-(void)dropdownMenuWillShow:(LYSDropMenu*)menu;

#pragma mark - 下拉菜单已出现
-(void)dropdownMenuDidShow:(LYSDropMenu*)menu;

#pragma mark - 下拉菜单即将隐藏
-(void)dropdownMenuWillHide:(LYSDropMenu*)menu;

#pragma mark - 下拉菜单已隐藏
-(void)dropdownMenuDidHide:(LYSDropMenu*)menu;

#pragma mark - 更新mainview
-(void)updateMainItem:(UIView*)mainItemView item:(NSMutableDictionary*)item;

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
-(void)showDropDownMenu:(void(^)())completeBlock;

#pragma mark - 隐藏下拉菜单
-(void)hideDropDownMenu:(void(^)())completeBlock;

@end
