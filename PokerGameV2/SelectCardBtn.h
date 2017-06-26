//
//  SelectCardBtn.h
//  PokerGameV2
//
//  Created by 鄭文 on 2017/6/11.
//  Copyright © 2017年 Lingo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Card;

@protocol SelectCardBtnDelegate <NSObject>

-(void)thePlayerOutCard:(Card*)card isAdding:(Boolean)isAdding indexOfCard:(NSInteger)index;

@end

@interface SelectCardBtn : UIButton

@property (nonatomic,weak) NSArray <SelectCardBtn*> * allBtns;
@property (nonatomic) Card * currentCard;
@property (nonatomic) Boolean isAdding;
@property (nonatomic) NSInteger nowValue;
@property (nonatomic) NSInteger whichCard;

@property (nonatomic) id <SelectCardBtnDelegate> delegate;
@end
