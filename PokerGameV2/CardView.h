//
//  CardView.h
//  PokerGameV2
//
//  Created by 鄭文 on 2017/6/11.
//  Copyright © 2017年 Lingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
#import "SelectCardBtn.h"


@interface CardView : UIImageView

@property (nonatomic) Card * currentCard;
@property (nonatomic) NSInteger whichCard;
@property (nonatomic,weak) NSArray <SelectCardBtn*> *allBtns;
@property (nonatomic,weak) NSArray <CardView*> *allCards;
@property (nonatomic) NSInteger nowValue;
-(void)setTheCard:(Card*)card indexOfCard:(NSInteger)index;
-(void)toOrigionLocation;
-(void)setTheImage;
@end
