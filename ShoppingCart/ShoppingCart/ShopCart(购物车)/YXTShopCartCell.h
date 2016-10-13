//
//  YXTShopCartCell.h
//  CoffeeMallAPP--购物车
//
//  Created by 杨小童 on 16/3/2.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YXTShopCartModel.h"

@protocol YXTShopCartCellDelegate <NSObject>

- (void)addButtonShop_goodCell:(UITableViewCell *)cell;
- (void)reduceButtonShop_goodCell:(UITableViewCell *)cell;

@end

@interface YXTShopCartCell : UITableViewCell

@property (nonatomic,assign) id<YXTShopCartCellDelegate> delegate;

@property(strong,nonatomic) UILabel *goodIdLabel;//商品id
@property(strong,nonatomic) UIImageView *goodImageImageView;//商品图片
@property(strong,nonatomic) UILabel *goodNameLabel;//商品名称
@property(strong,nonatomic) UILabel *goodNumLabel;//这个商品购物的商品总数
@property(strong,nonatomic) UILabel *goodTitleLabel;//商品内容
@property(strong,nonatomic) UILabel *goodSizeLabel;//这个商品购物的总钱数
@property(strong,nonatomic) UILabel *goodPriceLabel;//商品内容
@property(strong,nonatomic) UILabel *goodTotalMoneyLabel;//这个商品购物的总钱数
//@property(strong,nonatomic) UILabel *titleLabel;//商品id
@property(strong,nonatomic) UIButton *goodSelectStateImageViewButton;//商品图片

@property(strong,nonatomic) UIButton *reduceButton;
@property(strong,nonatomic) UIButton *addButton;

- (void)addGoodsModel:(YXTGoodCartModel *)goodsModel;


//typedef void (^couponblock)(UITableViewCell *cell);
//
//@property (nonatomic, copy) couponblock block;

//@property(strong,nonatomic) UILabel *shopIdLabel;//商店id
//@property(strong,nonatomic) UIImageView *shopImageImageView;//商店图片
//@property(strong,nonatomic) UILabel *shopNameLabel;//商店名称
//@property(strong,nonatomic) UILabel *shopNumLabel;//这个商店购物的商品总数
//@property(strong,nonatomic) UILabel *shopTitleLabel;//商店内容
//@property(strong,nonatomic) UILabel *shopTotalMoneyLabel;//这个商店购物的总钱数
////@property(strong,nonatomic) UILabel *titleLabel;//商店id
//@property(assign,nonatomic)BOOL selectState;//选中状态
//
//- (void)addShopsModel:(YXTShopCartModel *)shopsModel;

@end
