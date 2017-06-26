//
//  Card.m
//  PokerGameV2
//
//  Created by 鄭文 on 2017/6/11.
//  Copyright © 2017年 Lingo. All rights reserved.
//

#import "Card.h"

@implementation Card

-(void)setTheInitValue:(NSInteger)value initType:(NSInteger)type{

    // Set the card value and type
    self.value = value;
    self.typeValue = type;
    
    // Check the card whether is effect card
    switch (value) {
        case 4:
        case 5:
        case 10:
        case 11:
        case 12:
        case 13:
            self.isEffectCard = YES;
            break;
            
        default:
            self.isEffectCard = NO;
            break;
    }
    
    // Set the card type
    switch (type) {
        case 0:
            self.type = @"club";
            break;
        case 1:
            self.type = @"diamond";
            break;
        case 2:
            self.type = @"heart";
            break;
        case 3:
            self.type = @"spade";
            break;
        default:
            self.type = @"joker";
            break;
    }
    
    // Set the card name
    self.cardName = [NSString stringWithFormat:@"%@%ld",self.type,self.value];
    
    
    
    

}


@end
