//
//  RootViewController.m
//  CoffeeMallAPP--购物车
//
//  Created by 杨小童 on 16/3/2.
//  Copyright © 2016年 YXT. All rights reserved.
//

#define FULL_HEIGHT             [[UIScreen mainScreen] bounds].size.height
#define FULL_WIDTH              [[UIScreen mainScreen] bounds].size.width
#define NAVBAR_HEIGHT           64
#define BOTTOM_HEIGHT           49

#import "RootViewController.h"

#import "YXTShopCartView.h"

@interface RootViewController ()

@property (strong, nonatomic) NSDictionary *plistDic;

@end

@implementation RootViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ShopCart" ofType:@"plist"];
        self.plistDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"购物车";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    // 加载购物车
    YXTShopCartView *shopCartView = [[YXTShopCartView alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, FULL_HEIGHT - NAVBAR_HEIGHT - BOTTOM_HEIGHT) dataDic:self.plistDic];
    [self.view addSubview:shopCartView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
