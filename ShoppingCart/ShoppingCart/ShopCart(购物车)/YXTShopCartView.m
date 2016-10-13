//
//  YXTShopCartView.m
//  CoffeeMallAPP--购物车
//
//  Created by 杨小童 on 16/3/2.
//  Copyright © 2016年 YXT. All rights reserved.
//

#define FULL_HEIGHT             [[UIScreen mainScreen] bounds].size.height
#define FULL_WIDTH              [[UIScreen mainScreen] bounds].size.width
#define NAVBAR_HEIGHT           64
#define BOTTOM_HEIGHT           49

#import "YXTShopCartView.h"

#import "YXTShopCartModel.h"
#import "YXTShopCartCell.h"

@interface YXTShopCartView ()<UITableViewDataSource, UITableViewDelegate, YXTShopCartCellDelegate>

@property (strong, nonatomic) UITableView *shopCartTableView;

@property (strong, nonatomic) NSMutableArray *shopCartArray;

@property (strong, nonatomic) UIButton *allSelectButton;

@property (strong, nonatomic) UILabel *allTotalMoney;

@end

@implementation YXTShopCartView

-(instancetype)initWithFrame:(CGRect)frame dataDic:(NSDictionary *)dataDic
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.shopCartArray = [NSMutableArray array];
        
        self.shopCartTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, FULL_HEIGHT - NAVBAR_HEIGHT - BOTTOM_HEIGHT - 50) style:UITableViewStylePlain];
        self.shopCartTableView.dataSource = self;
        self.shopCartTableView.delegate = self;
        self.shopCartTableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.shopCartTableView];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, FULL_HEIGHT - NAVBAR_HEIGHT - BOTTOM_HEIGHT - 50, FULL_WIDTH, 50)];
        [bottomView setBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1]];
        [self addSubview:bottomView];
        
        self.allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.allSelectButton setFrame:CGRectMake(0, 0, 50, 50)];
        [self.allSelectButton setImage:[UIImage imageNamed:@"复选框-选中.png"] forState:UIControlStateNormal];
        self.allSelectButton.selected = YES;
        self.allSelectButton.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
        [self.allSelectButton addTarget:self action:@selector(allSelectButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:self.allSelectButton];
        
        self.allTotalMoney = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 140, 50)];
        [self.allTotalMoney setText:@"合计："];
        [bottomView addSubview:self.allTotalMoney];

        if ([[dataDic objectForKey:@"status"] intValue] == 1) {

            NSMutableDictionary *shopDic = [NSMutableDictionary dictionary];
            NSMutableDictionary *goodDic = [NSMutableDictionary dictionary];
            
            NSMutableArray *shopsArray = [dataDic objectForKey:@"shopsArray"];
            
            for (int i = 0; i < shopsArray.count; i++) {
                
                NSMutableArray *goodsDataArray = [shopsArray[i] objectForKey:@"goodsArray"];

                NSMutableArray *goodsArray = [NSMutableArray array];
                for (int j = 0; j < goodsDataArray.count; j++) {
                    [goodDic setValue:[goodsDataArray[j] objectForKey:@"goodId"] forKey:@"goodId"];
                    [goodDic setValue:[goodsDataArray[j] objectForKey:@"goodImage"] forKey:@"goodImage"];
                    [goodDic setValue:[goodsDataArray[j] objectForKey:@"goodName"] forKey:@"goodName"];
                    [goodDic setValue:[goodsDataArray[j] objectForKey:@"goodNum"] forKey:@"goodNum"];
                    [goodDic setValue:[goodsDataArray[j] objectForKey:@"goodPrice"] forKey:@"goodPrice"];
                    [goodDic setValue:[goodsDataArray[j] objectForKey:@"goodSize"] forKey:@"goodSize"];
                    [goodDic setValue:[goodsDataArray[j] objectForKey:@"goodTitle"] forKey:@"goodTitle"];
                    [goodDic setValue:[goodsDataArray[j] objectForKey:@"goodTotalMoney"] forKey:@"goodTotalMoney"];
                    
                    [goodDic setValue:[NSNumber numberWithBool:YES] forKey:@"goodSelectState"];
                    
                    YXTGoodCartModel *model = [[YXTGoodCartModel alloc] initWithGoodDic:goodDic];
                    [goodsArray addObject:model];

                }
                
                [shopDic setValue:[shopsArray[i] objectForKey:@"shopId"] forKey:@"shopId"];
                [shopDic setValue:[shopsArray[i] objectForKey:@"shopName"] forKey:@"shopName"];
                [shopDic setValue:[shopsArray[i] objectForKey:@"shopImage"] forKey:@"shopImage"];
                [shopDic setValue:[shopsArray[i] objectForKey:@"shopNum"] forKey:@"shopNum"];
                [shopDic setValue:[shopsArray[i] objectForKey:@"shopTitle"] forKey:@"shopTitle"];
                [shopDic setValue:[shopsArray[i] objectForKey:@"shopTotalMoney"] forKey:@"shopTotalMoney"];
                [shopDic setValue:goodsArray forKey:@"goodsArray"];
                
                [shopDic setValue:[NSNumber numberWithBool:YES] forKey:@"shopSelectState"];
                
                YXTShopCartModel *model = [[YXTShopCartModel alloc] initWithShopDic:shopDic];
                [self.shopCartArray addObject:model];
                
            }
            
            [self getTotalMoney];
            
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"购物车为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }
        
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.shopCartArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YXTShopCartModel *model = self.shopCartArray[section];
    
    UIView *heardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 40)];
    [heardView setBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:241 / 255.0  blue:242 / 255.0  alpha:1]];
    heardView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapClick:)];
    [heardView addGestureRecognizer:singleTap];
    heardView.tag = section;
    
    UIImageView *shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
    if (model.shop_SelectState == YES) {
        shopImageView.image = [UIImage imageNamed:@"复选框-选中.png"];
    } else {
        shopImageView.image = [UIImage imageNamed:@"复选框-未选中.png"];
    }
    
    [heardView addSubview:shopImageView];
    
    UILabel *shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 120, 40)];
    shopNameLabel.text = model.shop_NameStr;
    [heardView addSubview:shopNameLabel];
    
    UILabel *shopTotalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(FULL_WIDTH - 100, 0, 85, 40)];
    shopTotalMoneyLabel.text = model.shop_TotalMoneyStr;
//    shopTotalMoneyLabel.font = [UIFont systemFontOfSize:13];
    [shopTotalMoneyLabel setTextAlignment:NSTextAlignmentRight];
    [heardView addSubview:shopTotalMoneyLabel];
    
    
    return heardView;
}

- (void)singleTapClick:(UIGestureRecognizer *)ges
{

    YXTShopCartModel *shopModel = self.shopCartArray[ges.view.tag];
    if (shopModel.shop_SelectState == NO) {
        shopModel.shop_SelectState = YES;
        for (YXTGoodCartModel *goodModel in shopModel.goods_Array) {
            goodModel.good_SelectState = YES;
        }
        
    } else {
        shopModel.shop_SelectState = NO;
        for (YXTGoodCartModel *goodModel in shopModel.goods_Array) {
            goodModel.good_SelectState = NO;
        }
    }
    
    
    float shopTotalMoney = 0;
    for (YXTGoodCartModel *goodModel in shopModel.goods_Array) {
        if (goodModel.good_SelectState == YES) {
            shopTotalMoney = shopTotalMoney + [goodModel.good_TotalMoneyStr floatValue];
        }
    }
    shopModel.shop_TotalMoneyStr = [NSString stringWithFormat:@"%.f", shopTotalMoney];
    
    [self allSelectOrNoselect];
    
    
    [self getTotalMoney];
    
    [self.shopCartTableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YXTShopCartModel *model = self.shopCartArray[section];
    
    return model.goods_Array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"reuse";
    YXTShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[YXTShopCartCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
        cell.delegate = self;
    }

    //调用方法，给单元格赋值
    YXTShopCartModel *shopModel = self.shopCartArray[indexPath.section];
    YXTGoodCartModel *goodModel = shopModel.goods_Array[indexPath.row];
    [cell addGoodsModel:goodModel];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXTShopCartModel *shopModel = self.shopCartArray[indexPath.section];

    YXTGoodCartModel *goodModel = shopModel.goods_Array[indexPath.row];
    if (goodModel.good_SelectState == NO) {
        goodModel.good_SelectState = YES;
    } else {
        goodModel.good_SelectState = NO;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (YXTGoodCartModel *goodModel in shopModel.goods_Array) {
        
        [array addObject:[NSString stringWithFormat:@"%@", [NSNumber numberWithBool:goodModel.good_SelectState]]];
        
    }

    if ([array containsObject:@"0"]) {
        shopModel.shop_SelectState = NO;
    } else {
        shopModel.shop_SelectState = YES;
    }
    
    float shopTotalMoney = 0;
    for (YXTGoodCartModel *goodModel in shopModel.goods_Array) {
        if (goodModel.good_SelectState == YES) {
            shopTotalMoney = shopTotalMoney + [goodModel.good_TotalMoneyStr floatValue];
        }
    }
    shopModel.shop_TotalMoneyStr = [NSString stringWithFormat:@"%.f", shopTotalMoney];
    
    [self getTotalMoney];
    
    
    [self allSelectOrNoselect];
    
    [self.shopCartTableView reloadData];
}

- (void)getTotalMoney
{
    float totalMoney = 0;
    for (YXTShopCartModel *shopModel in self.shopCartArray) {
        for (YXTGoodCartModel *goodModel in shopModel.goods_Array) {
            if (goodModel.good_SelectState == YES) {
                totalMoney = totalMoney + [goodModel.good_TotalMoneyStr floatValue];
            }
        }
    }
    [self.allTotalMoney setText:[NSString stringWithFormat:@"合计：%.f元", totalMoney]];

}

- (void)allSelectButtonClick
{
    
    for (YXTShopCartModel *shopModel in self.shopCartArray) {
        if (self.allSelectButton.selected == YES) {
            shopModel.shop_SelectState = NO;
            [self.allSelectButton setImage:[UIImage imageNamed:@"复选框-未选中.png"] forState:UIControlStateNormal];
        } else {
            shopModel.shop_SelectState = YES;
            [self.allSelectButton setImage:[UIImage imageNamed:@"复选框-选中.png"] forState:UIControlStateNormal];
        }
        
    }
    
    
    for (YXTShopCartModel *shopModel in self.shopCartArray) {
        for (YXTGoodCartModel *goodModel in shopModel.goods_Array) {
            if (self.allSelectButton.selected == YES) {
                goodModel.good_SelectState = NO;
                [self.allSelectButton setImage:[UIImage imageNamed:@"复选框-未选中.png"] forState:UIControlStateNormal];
            } else {
                goodModel.good_SelectState = YES;
                [self.allSelectButton setImage:[UIImage imageNamed:@"复选框-选中.png"] forState:UIControlStateNormal];
            }
        }
        
    }
    
    if (self.allSelectButton.selected == YES) {
        self.allSelectButton.selected = NO;
    } else {
        self.allSelectButton.selected = YES;
    }
    
    float shopTotalMoney = 0;
    for (YXTShopCartModel *shopModel in self.shopCartArray) {
        for (YXTGoodCartModel *goodModel in shopModel.goods_Array) {
            if (goodModel.good_SelectState == YES) {
                shopTotalMoney = shopTotalMoney + [goodModel.good_TotalMoneyStr floatValue];
            }
        }
        shopModel.shop_TotalMoneyStr = [NSString stringWithFormat:@"%.f", shopTotalMoney];
        shopTotalMoney = 0;
    }
    
    
    [self getTotalMoney];
    
    [self.shopCartTableView reloadData];
}

-(void)reduceButtonShop_goodCell:(UITableViewCell *)cell
{
    
    int num = 0;
    NSIndexPath *indexPath = [self.shopCartTableView indexPathForCell:cell];
    
    YXTShopCartModel *shopModel = self.shopCartArray[indexPath.section];
    
    YXTGoodCartModel *goodModel = shopModel.goods_Array[indexPath.row];
    num = [goodModel.good_NumStr intValue];
    num--;
    if (num < 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"不能再少了" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        return;
    }
    
    goodModel.good_NumStr = [NSString stringWithFormat:@"%d", num];
    
    float shopTotalMoney = 0;
    for (YXTGoodCartModel *goodModel in shopModel.goods_Array) {
        if (goodModel.good_SelectState == YES) {
            shopTotalMoney = shopTotalMoney + [goodModel.good_NumStr floatValue] * [goodModel.good_PriceStr floatValue];
            goodModel.good_TotalMoneyStr = [NSString stringWithFormat:@"%.f", [goodModel.good_NumStr floatValue] * [goodModel.good_PriceStr floatValue]];
        }
    }
    shopModel.shop_TotalMoneyStr = [NSString stringWithFormat:@"%.f", shopTotalMoney];
    
    [self getTotalMoney];
    
    [self.shopCartTableView reloadData];
    
}

-(void)addButtonShop_goodCell:(UITableViewCell *)cell
{
    int num = 0;
    NSIndexPath *indexPath = [self.shopCartTableView indexPathForCell:cell];
    
    YXTShopCartModel *shopModel = self.shopCartArray[indexPath.section];
    
    YXTGoodCartModel *goodModel = shopModel.goods_Array[indexPath.row];
    num = [goodModel.good_NumStr intValue];
    num++;
    if (num > 99) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"不能再多了" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    
    goodModel.good_NumStr = [NSString stringWithFormat:@"%d", num];
    
    float shopTotalMoney = 0;
    for (YXTGoodCartModel *goodModel in shopModel.goods_Array) {
        if (goodModel.good_SelectState == YES) {
            shopTotalMoney = shopTotalMoney + [goodModel.good_NumStr floatValue] * [goodModel.good_PriceStr floatValue];
            goodModel.good_TotalMoneyStr = [NSString stringWithFormat:@"%.f", [goodModel.good_NumStr floatValue] * [goodModel.good_PriceStr floatValue]];
        }
    }
    shopModel.shop_TotalMoneyStr = [NSString stringWithFormat:@"%.f", shopTotalMoney];
    
    [self getTotalMoney];
    
    [self.shopCartTableView reloadData];
}

- (void)allSelectOrNoselect
{
    NSMutableArray *allSelectArray = [NSMutableArray array];
    for (YXTShopCartModel *shopModel in self.shopCartArray) {
        
        [allSelectArray addObject:[NSString stringWithFormat:@"%@", [NSNumber numberWithBool:shopModel.shop_SelectState]]];
        
    }
    
    if ([allSelectArray containsObject:@"0"]) {
        self.allSelectButton.selected = NO;
        [self.allSelectButton setImage:[UIImage imageNamed:@"复选框-未选中.png"] forState:UIControlStateNormal];
    } else {
        self.allSelectButton.selected = YES;
        [self.allSelectButton setImage:[UIImage imageNamed:@"复选框-选中.png"] forState:UIControlStateNormal];
    }
}


@end
