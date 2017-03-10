//
//  ViewController.m
//  LYSDropMenu
//
//  Created by jk on 2017/3/8.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "ViewController.h"
#import "LYSDropMenu.h"
#import "MyCell.h"

@interface ViewController ()<LYSDropMenuDelegate>

@property(nonatomic,strong)LYSDropMenu *dropMenu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.dropMenu];
    self.dropMenu.selectedIndex = 3;
    self.dropMenu.items = @[@{@"name":@"李焱生1"},@{@"name":@"李焱生2"},@{@"name":@"李焱生3"},@{@"name":@"李焱生4"},@{@"name":@"李焱生5"},@{@"name":@"李焱生6"},@{@"name":@"李焱生7"},@{@"name":@"李焱生8"}];

}


-(LYSDropMenu*)dropMenu{
    if (!_dropMenu) {
        _dropMenu = [[LYSDropMenu alloc]initWithFrame:CGRectMake(20, 120, self.view.bounds.size.width - 40, 44.f)];
        _dropMenu.delegate = self;
        _dropMenu.layer.borderWidth = 1;
        _dropMenu.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _dropMenu.maxShowCount = 4;
        _dropMenu.mainItemClazz = [UILabel class];
        _dropMenu.itemClazz = [MyCell class];

    }
    return _dropMenu;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMainItemViewStyle:(UIView*)view{
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *_mainView = ((UILabel *)view);
        _mainView.textColor = [UIColor redColor];
        _mainView.font = [UIFont systemFontOfSize:14];
        _mainView.frame = CGRectMake( 10 , 0, _mainView.superview.frame.size.width - 20, _mainView.superview.frame.size.height);
    }
//    view.backgroundColor = [UIColor redColor];
}

-(void)handleItemView:(UITableViewCell*)itemView item:(NSMutableDictionary *)item{
//    itemView.backgroundColor = [UIColor greenColor];
    if([itemView isKindOfClass:[MyCell class]]){
        ((MyCell *)itemView).item = item;
    }
}

-(void)itemDidSelected:(LYSDropMenu*)menu item:(NSMutableDictionary*)item{
    NSLog(@"you picked %@",item);
}

-(void)dropdownMenuWillShow:(LYSDropMenu*)menu{
    NSLog(@"dropdownMenuWillShow");
}

-(void)dropdownMenuDidShow:(LYSDropMenu*)menu{
    NSLog(@"dropdownMenuDidShow");
}

-(void)dropdownMenuWillHide:(LYSDropMenu*)menu{
    NSLog(@"dropdownMenuWillHide");
}

-(void)dropdownMenuDidHide:(LYSDropMenu*)menu{
    NSLog(@"dropdownMenuDidHide");
}

-(void)updateMainItem:(UIView *)mainItemView item:(NSMutableDictionary *)item{
    if ([mainItemView isKindOfClass:[UILabel class]]) {
        ((UILabel *)mainItemView).text = [item objectForKey:@"name"];
    }
}


@end
