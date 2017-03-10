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
    self.dropMenu.items = @[@{@"name":@"李焱生"},@{@"name":@"李焱生"},@{@"name":@"李焱生"},@{@"name":@"李焱生"},@{@"name":@"李焱生"},@{@"name":@"李焱生"},@{@"name":@"李焱生"},@{@"name":@"李焱生"}];

}


-(LYSDropMenu*)dropMenu{
    if (!_dropMenu) {
        _dropMenu = [[LYSDropMenu alloc]initWithFrame:CGRectMake(20, 120, self.view.bounds.size.width - 40, 44.f)];
        _dropMenu.delegate = self;
        _dropMenu.layer.borderWidth = 1;
        _dropMenu.maxShowCount = 4;
        _dropMenu.itemClazz = [MyCell class];

    }
    return _dropMenu;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMainItemViewStyle:(UIView*)view{
    view.backgroundColor = [UIColor redColor];
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


@end
