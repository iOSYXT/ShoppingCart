//
//  YXTShopCartModel.m
//  CoffeeMallAPP--购物车
//
//  Created by 杨小童 on 16/3/2.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import "YXTShopCartModel.h"

@implementation YXTShopCartModel

-(instancetype)initWithShopDic:(NSMutableDictionary *)shopDic
{
    self = [super init];
    
    if (self) {
        self.shop_NameStr = [NSString stringWithFormat:@"%@", [shopDic objectForKey:@"shopName"]];
        self.shop_IdStr = [NSString stringWithFormat:@"%@", [shopDic objectForKey:@"shopId"]];
        self.shop_ImageStr = [NSString stringWithFormat:@"%@", [shopDic objectForKey:@"shopImage"]];
        self.shop_NumStr = [NSString stringWithFormat:@"%@", [shopDic objectForKey:@"shopNum"]];
        self.shop_TitleStr = [NSString stringWithFormat:@"%@", [shopDic objectForKey:@"shopTitle"]];
        self.shop_TotalMoneyStr = [NSString stringWithFormat:@"%@", [shopDic objectForKey:@"shopTotalMoney"]];
        self.goods_Array = [shopDic objectForKey:@"goodsArray"];
        
        self.shop_SelectState = [shopDic objectForKey:@"shopSelectState"];
    }
    
    return self;
}


@end

@implementation YXTGoodCartModel

-(instancetype)initWithGoodDic:(NSMutableDictionary *)goodDic
{
    self = [super init];
    
    if (self) {
        self.good_NameStr = [NSString stringWithFormat:@"%@", [goodDic objectForKey:@"goodName"]];
        self.good_IdStr = [NSString stringWithFormat:@"%@", [goodDic objectForKey:@"goodId"]];
        self.good_ImageStr = [NSString stringWithFormat:@"%@", [goodDic objectForKey:@"goodImage"]];
        self.good_NumStr = [NSString stringWithFormat:@"%@", [goodDic objectForKey:@"goodNum"]];
        self.good_TitleStr = [NSString stringWithFormat:@"%@", [goodDic objectForKey:@"goodTitle"]];
        self.good_TotalMoneyStr = [NSString stringWithFormat:@"%@", [goodDic objectForKey:@"goodTotalMoney"]];
        self.good_SizeStr = [NSString stringWithFormat:@"%@", [goodDic objectForKey:@"goodSize"]];
        self.good_PriceStr = [NSString stringWithFormat:@"%@", [goodDic objectForKey:@"goodPrice"]];
        
        self.good_SelectState = [goodDic objectForKey:@"goodSelectState"];
    }
    
    return self;
}


@end
