//
//  CardView.m
//  PokerGameV2
//
//  Created by 鄭文 on 2017/6/11.
//  Copyright © 2017年 Lingo. All rights reserved.
//

#import "CardView.h"

@implementation CardView
{
    CGPoint originalLoc;
}

-(void)toOrigionLocation{
    
    self.frame = CGRectMake(originalLoc.x, originalLoc.y, self.frame.size.width, self.frame.size.height);
}

-(void)setTheImage{
    NSString *cardName = self.currentCard.cardName;
    originalLoc = self.frame.origin;
    self.image = [UIImage imageNamed:cardName];
}

-(void)setTheCard:(Card *)card indexOfCard:(NSInteger)index{
    self.currentCard = card;
    self.whichCard = index;
    originalLoc = self.frame.origin;
    self.image = [UIImage imageNamed:self.currentCard.cardName];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    // All my cards back to origin location
    [self.allCards enumerateObjectsUsingBlock:^(CardView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CardView *tmp = obj;
        tmp.frame = CGRectMake(tmp->originalLoc.x, tmp->originalLoc.y, tmp.frame.size.width, tmp.frame.size.height);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y-20, self.frame.size.width, self.frame.size.height);
    }];
    
    SelectCardBtn *tmp1 = self.allBtns[0];
    SelectCardBtn *tmp2 = self.allBtns[1];
    
    tmp1.currentCard = self.currentCard;
    tmp2.currentCard = self.currentCard;
    
    tmp1.nowValue = self.nowValue;
    tmp2.nowValue = self.nowValue;
    
    tmp1.whichCard = self.whichCard;
    tmp2.whichCard = self.whichCard;
    
    [tmp1 setUserInteractionEnabled:YES];
    
    if (!self.currentCard.isEffectCard) {
        [tmp1 setTitle:@"出牌" forState:UIControlStateNormal];
        [tmp2 setTitle:@"" forState:UIControlStateNormal];
        [tmp2 setUserInteractionEnabled:NO];
    }else{
        
        [tmp2 setTitle:@"" forState:UIControlStateNormal];
        [tmp2 setUserInteractionEnabled:NO];
        
        switch (self.currentCard.value) {
            case 4:
                [tmp1 setTitle:@"迴轉" forState:UIControlStateNormal];
                break;
            case 5:
                [tmp1 setTitle:@"下個玩家" forState:UIControlStateNormal];
                break;
            case 10:
                [tmp1 setTitle:@"+10" forState:UIControlStateNormal];
                [tmp2 setUserInteractionEnabled:YES];
                [tmp2 setTitle:@"-10" forState:UIControlStateNormal];
                break;
            case 11:
                [tmp1 setTitle:@"PASS" forState:UIControlStateNormal];
                break;
            case 12:
                [tmp1 setTitle:@"+20" forState:UIControlStateNormal];
                [tmp2 setUserInteractionEnabled:YES];
                [tmp2 setTitle:@"-20" forState:UIControlStateNormal];
                break;
            case 13:
                [tmp1 setTitle:@"99" forState:UIControlStateNormal];
                break;
            default:
                
                NSLog(@"!@#$&*(    ERRRRRRRRRRRRRRORRRRRRRR");
                break;
        } // end switch
    }
    
    
}

@end







