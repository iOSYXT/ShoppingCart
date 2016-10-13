//
//  YXTShopCartCell.m
//  CoffeeMallAPP--购物车
//
//  Created by 杨小童 on 16/3/2.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import "YXTShopCartCell.h"

#define FULL_HEIGHT             [[UIScreen mainScreen] bounds].size.height
#define FULL_WIDTH              [[UIScreen mainScreen] bounds].size.width
#define NAVBAR_HEIGHT           64
#define BOTTOM_HEIGHT           49

@implementation YXTShopCartCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *goodView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 60)];
        [goodView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:goodView];
        
        _goodImageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
        [goodView addSubview:_goodImageImageView];
        
        _goodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 80, 20)];
        _goodNameLabel.font = [UIFont systemFontOfSize:16];
        [goodView addSubview:_goodNameLabel];
        
        _goodTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 80, 20)];
        _goodTitleLabel.font = [UIFont systemFontOfSize:13];
        [goodView addSubview:_goodTitleLabel];
        
        _goodSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 40, 20)];
        _goodSizeLabel.font = [UIFont systemFontOfSize:13];
        [goodView addSubview:_goodSizeLabel];
        
        _goodPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 30, 40, 20)];
        _goodPriceLabel.font = [UIFont systemFontOfSize:13];
        [goodView addSubview:_goodPriceLabel];
        
        self.reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.reduceButton setFrame:CGRectMake(180, 5, 40, 40)];
        [self.reduceButton setImage:[UIImage imageNamed:@"减少.png"] forState:UIControlStateNormal];
        [self.reduceButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [self.reduceButton addTarget:self action:@selector(reduceButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [goodView addSubview:self.reduceButton];
        
        _goodNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 5, 30, 40)];
        _goodNumLabel.font = [UIFont systemFontOfSize:13];
        [_goodNumLabel setTextAlignment:NSTextAlignmentCenter];
        [goodView addSubview:_goodNumLabel];
        
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addButton setFrame:CGRectMake(230, 5, 40, 40)];
        [self.addButton setImage:[UIImage imageNamed:@"增加.png"] forState:UIControlStateNormal];
        [self.addButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [self.addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [goodView addSubview:self.addButton];
        
        _goodTotalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 30, 30, 20)];
        _goodTotalMoneyLabel.font = [UIFont systemFontOfSize:13];
        [_goodTotalMoneyLabel setTextAlignment:NSTextAlignmentCenter];
        [goodView addSubview:_goodTotalMoneyLabel];
        
        _goodSelectStateImageViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goodSelectStateImageViewButton setFrame:CGRectMake(FULL_WIDTH - 35, 20, 20, 20)];
        [_goodSelectStateImageViewButton setImage:[UIImage imageNamed:@"复选框-未选中"] forState:UIControlStateNormal];
        [_goodSelectStateImageViewButton setImage:[UIImage imageNamed:@"复选框-选中"] forState:UIControlStateSelected];
        [goodView addSubview:_goodSelectStateImageViewButton];
        
    }
    return self;
}

- (void)reduceButtonClick
{
    if (_goodSelectStateImageViewButton.selected == YES) {
        [self.delegate reduceButtonShop_goodCell:self];
    } else {
        
    }
    
}

- (void)addButtonClick
{
    if (_goodSelectStateImageViewButton.selected == YES) {
        [self.delegate addButtonShop_goodCell:self];
    } else {
        
    }
    
}

- (void)addGoodsModel:(YXTGoodCartModel *)goodsModel
{
    _goodImageImageView.image = [UIImage imageNamed:goodsModel.good_ImageStr];
    _goodNameLabel.text = goodsModel.good_NameStr;
    _goodTitleLabel.text = goodsModel.good_TitleStr;
    _goodSizeLabel.text = goodsModel.good_SizeStr;
    _goodPriceLabel.text = goodsModel.good_PriceStr;
    _goodNumLabel.text = goodsModel.good_NumStr;
    _goodTotalMoneyLabel.text = goodsModel.good_TotalMoneyStr;
    
    if (goodsModel.good_SelectState == YES) {
        _goodSelectStateImageViewButton.selected = YES;
    } else {
        _goodSelectStateImageViewButton.selected = NO;
    }
}

- (void)awakeFromNib {
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
