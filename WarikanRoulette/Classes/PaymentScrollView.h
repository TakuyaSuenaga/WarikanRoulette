//
//  PaymentScrollView.h
//  WarikanRoulette
//
//  Created by Takuya Suenaga on 2014/07/04.
//  Copyright (c) 2014年 Takuya Suenaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentScrollView : UIScrollView

@property (nonatomic) int contentsCount;

- (id)initPaymentScrollViewWithFrame:(CGRect)frame;
+ (id)makePaymentScrollViewWithFrame:(CGRect)frame persons:(int)persons;
- (void)addContentViewWithColor:(UIColor*)color payment:(int)payment;

@end
