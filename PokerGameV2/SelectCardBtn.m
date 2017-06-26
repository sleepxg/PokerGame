//
//  SelectCardBtn.m
//  PokerGameV2
//
//  Created by 鄭文 on 2017/6/11.
//  Copyright © 2017年 Lingo. All rights reserved.
//

#import "SelectCardBtn.h"
#import "Card.h"
#import "CardView.h"


@implementation SelectCardBtn

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    // 判斷是否為功能牌
    if (!self.currentCard.isEffectCard) {
        
        // 判斷數字牌是否可以出牌
        if( (self.currentCard.value + self.nowValue) > 99) {
            return;
        }else{
            [self.allBtns enumerateObjectsUsingBlock:^(SelectCardBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SelectCardBtn *tmp = obj;
                [tmp setTitle:@"" forState:UIControlStateNormal];
                [tmp setUserInteractionEnabled:NO];
            }];
            [self.delegate thePlayerOutCard:self.currentCard isAdding:self.isAdding indexOfCard:self.whichCard];
        }
    }else{
        // 功能牌
        
        // 若是+10 / +20
        if (self.currentCard.value == 10 && self.isAdding ) {
            if ((self.nowValue + 10 ) > 99) {
                return;
            }
        }
        if (self.currentCard.value == 12 && self.isAdding ) {
            if ((self.nowValue + 20 ) > 99) {
                return;
            }
        }
        
        [self.allBtns enumerateObjectsUsingBlock:^(SelectCardBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SelectCardBtn *tmp = obj;
            [tmp setTitle:@"" forState:UIControlStateNormal];
            [tmp setUserInteractionEnabled:NO];
        }];
        
        [self.delegate thePlayerOutCard:self.currentCard isAdding:self.isAdding indexOfCard:self.whichCard];
    }
}

@end









