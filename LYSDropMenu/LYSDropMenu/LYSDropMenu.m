//
//  LYSDropMenu.m
//  LYSDropMenu
//
//  Created by jk on 2017/3/8.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSDropMenu.h"

#define VIEW_CENTER(aView)       ((aView).center)
#define VIEW_CENTER_X(aView)     ((aView).center.x)
#define VIEW_CENTER_Y(aView)     ((aView).center.y)

#define FRAME_ORIGIN(aFrame)     ((aFrame).origin)
#define FRAME_X(aFrame)          ((aFrame).origin.x)
#define FRAME_Y(aFrame)          ((aFrame).origin.y)

#define FRAME_SIZE(aFrame)       ((aFrame).size)
#define FRAME_HEIGHT(aFrame)     ((aFrame).size.height)
#define FRAME_WIDTH(aFrame)      ((aFrame).size.width)



#define VIEW_BOUNDS(aView)       ((aView).bounds)

#define VIEW_FRAME(aView)        ((aView).frame)

#define VIEW_ORIGIN(aView)       ((aView).frame.origin)
#define VIEW_X(aView)            ((aView).frame.origin.x)
#define VIEW_Y(aView)            ((aView).frame.origin.y)

#define VIEW_SIZE(aView)         ((aView).frame.size)
#define VIEW_HEIGHT(aView)       ((aView).frame.size.height)
#define VIEW_WIDTH(aView)        ((aView).frame.size.width)


#define VIEW_X_Right(aView)      ((aView).frame.origin.x + (aView).frame.size.width)
#define VIEW_Y_Bottom(aView)     ((aView).frame.origin.y + (aView).frame.size.height)

@interface LYSDropMenu ()<UITableViewDataSource,UITableViewDelegate>{
    UIView *_mainView;
    BOOL _isExpanded;
}

@property(nonatomic,strong)UIView *listView;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation LYSDropMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

#pragma mark - 初始化配置
-(void)initConfig{
    _mainItemClazz = [UIView class];
    _itemH = 44.f;
    _maxShowCount = -1;
    _itemClazz = [UITableViewCell class];
    _isExpanded = NO;
    [self setupUI];
}

#pragma mark - 创建ui
-(void)setupUI{
    [self addMainItemView];
    [self addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 按钮被点击
-(void)btnClicked:(UIButton*)sender{
    _isExpanded ? [self hideDropDownMenu] :  [self showDropDownMenu];
}

-(void)setMainItemClazz:(Class)mainItemClazz{
    _mainItemClazz = mainItemClazz;
    [self addMainItemView];
}

#pragma mark - 添加主视图
-(void)addMainItemView{
    NSAssert([self.mainItemClazz isSubclassOfClass:[UIView class]], @"mainItemClazz 类型错误");
    [_mainView removeFromSuperview];
    _mainView = nil;
    _mainView = [[self.mainItemClazz alloc]initWithFrame:self.bounds];
    if (self.delegate && [self.delegate respondsToSelector:@selector(setMainItemViewStyle:)]) {
        [self.delegate setMainItemViewStyle:_mainView];
    }
}

#pragma mark - 设置itemClazz
-(void)setItemClazz:(Class)itemClazz{
    _itemClazz = itemClazz;
    [self.tableView registerClass:_itemClazz forCellReuseIdentifier:NSStringFromClass(_itemClazz)];
}

#pragma mark - 设置数据
-(void)setItems:(NSArray *)items{
   _selectedIndex = _selectedIndex <= 0 ? 0 : (_selectedIndex <= self.items.count -1 ?: self.items.count - 1);
    _items = [self selectedItems:items atIndex:_selectedIndex];
    if (!self.listView.superview) {
        [self.superview addSubview:self.listView];
        if (!self.tableView.superview) {
            [self.listView addSubview:self.tableView];
        }
    }
    self.tableView.contentSize = CGSizeMake(self.tableView.frame.size.width, self.itemH *self.items.count);
    [self.tableView reloadData];
}

#pragma mark - 显示下拉列表
-(void)showDropDownMenu{
    if (_isExpanded) {
        return;
    }
    [self.listView.superview bringSubviewToFront:self.listView];
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillShow:)]) {
        [self.delegate dropdownMenuWillShow:self];
    }
    __weak typeof (self)WeakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        WeakSelf.listView.frame = CGRectMake(VIEW_X(WeakSelf.listView), VIEW_Y(WeakSelf.listView), VIEW_WIDTH(WeakSelf.listView), [WeakSelf dropMenuH]);
        WeakSelf.tableView.frame = CGRectMake(0, 0, VIEW_WIDTH(WeakSelf.listView), [WeakSelf dropMenuH]);
    } completion:^(BOOL finished) {
        _isExpanded = YES;
        if ([WeakSelf.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
            [WeakSelf.delegate dropdownMenuDidShow:WeakSelf];
        }
    }];
}

#pragma mark - 隐藏下拉菜单
-(void)hideDropDownMenu{
    if (!_isExpanded) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillHide:)]) {
        [self.delegate dropdownMenuWillHide:self]; // 将要隐藏回调代理
    }
    __weak typeof (self)WeakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        WeakSelf.listView.frame  = CGRectMake(VIEW_X(WeakSelf.listView), VIEW_Y(WeakSelf.listView), VIEW_WIDTH(WeakSelf.listView), 0);
        WeakSelf.tableView.frame = CGRectMake(0, 0, VIEW_WIDTH(WeakSelf.listView), VIEW_HEIGHT(WeakSelf.listView));
    }completion:^(BOOL finished) {
        _isExpanded = NO;
        if ([WeakSelf.delegate respondsToSelector:@selector(dropdownMenuDidHide:)]) {
            [WeakSelf.delegate dropdownMenuDidHide:WeakSelf]; // 已经隐藏回调代理
        }
    }];

}

#pragma mark - 下拉菜单的高度
-(CGFloat)dropMenuH{
    if (self.maxShowCount != -1) {
        return self.itemH * MIN(self.maxShowCount, self.items.count);
    }else{
        return self.itemH *self.items.count;
    }
}

#pragma mark - 获取列表视图
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,VIEW_WIDTH(_listView), VIEW_HEIGHT(_listView))];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.bounces         = NO;
        [_tableView registerClass:_itemClazz forCellReuseIdentifier:NSStringFromClass(_itemClazz)];
    }
    return _tableView;
}

#pragma mark - 下拉列表背景View
-(UIView*)listView{
    if (!_listView) {
        _listView = [[UIView alloc] init];
        _listView.frame = CGRectMake(VIEW_X(self) , VIEW_Y_Bottom(self), VIEW_WIDTH(self),  0);
        _listView.clipsToBounds       = YES;
        _listView.layer.masksToBounds = NO;
        _listView.layer.borderColor   = [UIColor lightTextColor].CGColor;
        _listView.layer.borderWidth   = 0.5f;
    }
    return _listView;
}


#pragma mark - UITableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemH;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.itemClazz)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleItemView:item:)] ) {
        [self.delegate handleItemView:cell item:self.items[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger preSelectedIndex = self.selectedIndex;
    self.selectedIndex = indexPath.row;
    if (preSelectedIndex == self.selectedIndex && [[self.items[self.selectedIndex] objectForKey:@"selected"] isEqualToString:@"1"]) {
        return;
    }
    [_items enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.selectedIndex == idx) {
            [obj setObject:@"1" forKey:@"selected"];
        }else{
            [obj setObject:@"0" forKey:@"selected"];
        }

    }];
    [tableView reloadRowsAtIndexPaths:@[indexPath,[NSIndexPath indexPathForItem:preSelectedIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self hideDropDownMenu];
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemDidSelected:item:)]) {
        [self.delegate itemDidSelected:self item:self.items[indexPath.row]];
    }
}

#pragma mark 选中某个下标
-(NSArray*)selectedItems:(NSArray<NSMutableDictionary*>*)items atIndex:(NSUInteger)index{
    NSMutableArray *tempArray = [NSMutableArray array];
    [items enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *item = [obj mutableCopy];
        if (index == idx) {
            [item setObject:@"1" forKey:@"selected"];
        }else{
            [item setObject:@"0" forKey:@"selected"];
        }
        [tempArray addObject:item];
    }];
    return [tempArray copy];
}

@end
