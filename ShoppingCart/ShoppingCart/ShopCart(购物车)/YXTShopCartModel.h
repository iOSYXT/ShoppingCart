//
//  YXTShopCartModel.h
//  CoffeeMallAPP--购物车
//
//  Created by 杨小童 on 16/3/2.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXTShopCartModel : NSObject

@property (copy, nonatomic) NSString *shop_IdStr;
@property (copy, nonatomic) NSString *shop_NameStr;
@property (copy, nonatomic) NSString *shop_ImageStr;
@property (copy, nonatomic) NSString *shop_NumStr;
@property (copy, nonatomic) NSString *shop_TitleStr;
@property (copy, nonatomic) NSString *shop_TotalMoneyStr;
@property (strong, nonatomic) NSMutableArray *goods_Array;
@property(assign,nonatomic)BOOL shop_SelectState;//选中状态

-(instancetype)initWithShopDic:(NSMutableDictionary *)shopDic;

@end

@interface YXTGoodCartModel : NSObject

@property (copy, nonatomic) NSString *good_IdStr;
@property (copy, nonatomic) NSString *good_NameStr;
@property (copy, nonatomic) NSString *good_ImageStr;
@property (copy, nonatomic) NSString *good_NumStr;
@property (copy, nonatomic) NSString *good_TitleStr;
@property (copy, nonatomic) NSString *good_TotalMoneyStr;
@property (copy, nonatomic) NSString *good_PriceStr;
@property (copy, nonatomic) NSString *good_SizeStr;

@property(assign,nonatomic)BOOL good_SelectState;//选中状态

-(instancetype)initWithGoodDic:(NSMutableDictionary *)goodDic;

@end
