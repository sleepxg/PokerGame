//
//  Card.h
//  PokerGameV2
//
//  Created by 鄭文 on 2017/6/11.
//  Copyright © 2017年 Lingo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic) NSString * cardName;
@property (nonatomic) NSString * type;
@property (nonatomic) NSInteger typeValue;
@property (nonatomic) NSInteger value;
@property (nonatomic) Boolean isEffectCard;


-(void) setTheInitValue:(NSInteger)value initType:(NSInteger)type;

@end
