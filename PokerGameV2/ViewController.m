//
//  ViewController.m
//  PokerGameV2
//
//  Created by 鄭文 on 2017/6/11.
//  Copyright © 2017年 Lingo. All rights reserved.
//

#import "ViewController.h"
#import "Card.h"
#import "CardView.h"
#import "SelectCardBtn.h"



@interface ViewController () <SelectCardBtnDelegate>
{
    NSMutableArray <Card*> *allCardsOnTable;
    NSInteger nowValue;
    NSInteger playerCount;
    NSInteger nowPlayer;
    Boolean isClockwise;
    Boolean isUserLose;
    
    NSMutableArray *isComputerLose;
    NSMutableArray <Card*> *cardOfUserA;
    NSMutableArray <Card*> *cardOfUserB;
    NSMutableArray <Card*> *cardOfUserC;
    
    
}
@property (strong, nonatomic) IBOutletCollection(CardView) NSArray *myCards;
@property (weak, nonatomic) IBOutlet UILabel *nowStateLabel;
@property (strong, nonatomic) IBOutletCollection(SelectCardBtn) NSArray *selectCardBtns;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *userIcons;
@property (weak, nonatomic) IBOutlet UIImageView *centerCard;

@end
@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        isComputerLose = [NSMutableArray array];
        allCardsOnTable = [NSMutableArray array];
        cardOfUserA = [NSMutableArray array];
        cardOfUserB = [NSMutableArray array];
        cardOfUserC = [NSMutableArray array];
        playerCount = 4;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self prepareData];
}

-(void)prepareData{
    nowValue = 0;
    nowPlayer = playerCount - 1;
    isClockwise = YES;
    isUserLose = NO;
    self.centerCard.image = [UIImage imageNamed:@"back"];
    
    // initial the label
    NSString *state = (isClockwise) ? @"順時鐘" : @"逆時鐘";
    self.nowStateLabel.text = [NSString stringWithFormat:@"%@,目前:%ld",state,nowValue];
    
    // initial the user icon
    [self.userIcons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *tmp = obj;
        tmp.image = [UIImage imageNamed:@"user"];
    }];
    
    // initial the cards
    [allCardsOnTable removeAllObjects];
    
    for (int i =0; i<4; i++) {
        for (int j = 1; j<=13; j++) {
            Card *tmp = [[Card alloc]init];
            [tmp setTheInitValue:j initType:i];
            [allCardsOnTable addObject:tmp];
        }
    }
    
    
    // initial the state of computer whether dead or not
    [isComputerLose removeAllObjects];
    for (int i =0; i<playerCount; i++) {
        [isComputerLose addObject:[NSNumber numberWithBool:NO]];
    }
    
    
    // initial computers' cards
    [cardOfUserA removeAllObjects];
    [cardOfUserB removeAllObjects];
    [cardOfUserC removeAllObjects];
    for (int i=0; i<5; i++) {
        int selectIndex = arc4random()%allCardsOnTable.count;
        Card *tmp = allCardsOnTable[selectIndex];
        [allCardsOnTable removeObjectAtIndex:selectIndex];
        [cardOfUserA addObject:tmp];
        
        selectIndex = arc4random()%allCardsOnTable.count;
        tmp = allCardsOnTable[selectIndex];
        [allCardsOnTable removeObjectAtIndex:selectIndex];
        [cardOfUserB addObject:tmp];
        
        selectIndex = arc4random()%allCardsOnTable.count;
        tmp = allCardsOnTable[selectIndex];
        [allCardsOnTable removeObjectAtIndex:selectIndex];
        [cardOfUserC addObject:tmp];
        
    }
    [self cardSorting:cardOfUserA];
    [self cardSorting:cardOfUserB];
    [self cardSorting:cardOfUserC];
    
    
    
    // initial the button
    [self.selectCardBtns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SelectCardBtn *btn = obj;
        btn.delegate = self;
        btn.isAdding = (idx==0) ? YES : NO;
        btn.nowValue = nowValue;
        btn.allBtns = self.selectCardBtns;
        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn setUserInteractionEnabled:NO];
    }];

    // initial my cards 

    NSMutableArray *myCardsInit = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        int selectIndex = arc4random()%allCardsOnTable.count;
        Card *tmp = allCardsOnTable[selectIndex];
        
        [allCardsOnTable removeObjectAtIndex:selectIndex];
        [myCardsInit addObject:tmp];
    }
    [self cardSorting:myCardsInit];
    
    [self.myCards enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CardView *tmp = obj;
        [tmp setUserInteractionEnabled:YES];
        tmp.allCards = self.myCards;
        tmp.allBtns = self.selectCardBtns;
        tmp.whichCard = idx;
        tmp.currentCard = myCardsInit[idx];
        [tmp setTheImage];
    }];
    
    
}

#pragma mark SelectCardBtnDelegate Method
-(void)thePlayerOutCard:(Card *)card isAdding:(Boolean)isAdding indexOfCard:(NSInteger)index{
    //self.nowStateLabel.text
    
    if (!card.isEffectCard) {
        nowValue = nowValue + card.value;
        
    }else{
        NSInteger addingValue = 0;
        switch (card.value) {
            case 4:
                addingValue = 0;
                isClockwise = !isClockwise;
                break;
            case 5:
                // Not Finish Hereeeeeeeeeeeee
                addingValue = 0;
                //[self selectPlayer];
                //return;
                break;
            case 10:
                addingValue = isAdding ? 10 : -10;
                break;
            case 11:
                addingValue = 0;
                break;
            case 12:
                addingValue = isAdding ? 20 : -20;
                break;
            case 13:
                addingValue = 99 - nowValue;
                break;
            default:
                NSLog(@"123456778812903819803");
        
                break;
        }
        nowValue = nowValue + addingValue;
        
    }
    
    [self method2:card index:index];
    
}

-(void)selectPlayer{
    
    //...
    //[self method2];
}

-(void)method2:(Card*)card index:(NSInteger)index{
    NSString *state = isClockwise ? @"順時鐘" : @"逆時鐘";
    self.nowStateLabel.text = [NSString stringWithFormat:@"%@,目前:%ld",state,nowValue];
    
    nowPlayer = (nowPlayer + ((isClockwise) ? 1 : -1) + playerCount) %playerCount;
    
    //無法出牌且回到原位
    [self.myCards enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CardView *tmp = obj;
        [tmp setUserInteractionEnabled:NO];
        [tmp toOrigionLocation];
    }];
    
    // 得到一張新牌
    CardView *tmp = self.myCards[index];
    int selectIndex = arc4random()%allCardsOnTable.count;
    [tmp setTheCard:allCardsOnTable[selectIndex] indexOfCard:index];
    [allCardsOnTable removeObjectAtIndex:selectIndex];
    //[self myCardsSorting];
    
    // 出得牌回到allCardsOnTable
    [allCardsOnTable addObject:card];
    
    // 中間圖的變化
    self.centerCard.image = [UIImage imageNamed:card.cardName];
    
    // 輪到電腦出牌
    [self computerPlay];
    
}

-(void)computerPlay{
    
    // 迴圈是電腦在出牌
    [self computerOutCardOf:nowPlayer];
    
}

-(void) userTurn{
    
    UIAlertController *alert;
    UIAlertAction *restart = [UIAlertAction actionWithTitle:@"start again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self prepareData];
    }];;
    
    Boolean userA,userB,userC;
    userA = [isComputerLose[0] boolValue];
    userB = [isComputerLose[1] boolValue];
    userC = [isComputerLose[2] boolValue];
    
    if (userA && userB && userC) {
        NSLog(@"YOU WINNNNNNNNN");
        alert = [UIAlertController alertControllerWithTitle:@"Good Game" message:@"You WIN" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:restart];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    isUserLose = YES;
    
    // 輪到使用者出牌，使牌可以被點擊出牌
    [self.myCards enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CardView *temp = obj;
        if (temp.currentCard.isEffectCard) {
            isUserLose = NO;
        } else if( (temp.currentCard.value+nowValue) <= 99){
            isUserLose = NO;
        }
        
        [temp setUserInteractionEnabled:YES];
        temp.nowValue = nowValue;
    }];
    if (isUserLose) {
        NSLog(@"YOU LOSEEEEEEEEEEEEEEEEEEEE");
        alert = [UIAlertController alertControllerWithTitle:@"Good Game" message:@"You Lose" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:restart];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

// 輪到第 userID 個電腦出牌
-(void)computerOutCardOf:(NSInteger)userID{
    
    if (userID == 3) {
        [self userTurn];
        return;
    }
    
    Boolean check = [isComputerLose[userID] boolValue];
    if (check) {
        nowPlayer = (nowPlayer + ((isClockwise) ? 1 : -1) + playerCount) %playerCount;
        [self computerOutCardOf:nowPlayer];
        return;
    }
    
    
    NSMutableArray <Card*>*cards;
    UIImageView *view = [[UIImageView alloc]init];
    CGRect userFrame;
    // 分別取得其中一個電腦的手牌，以及其位置
    switch (userID) {
        case 0:
            //134
            cards = cardOfUserA;
            userFrame = CGRectMake(0,self.view.frame.size.height/2, 74, 107);
            break;
        case 1:
            //298
            cards = cardOfUserB;
            userFrame = CGRectMake(self.view.frame.size.width/2,0, 74, 107);
            break;
        case 2:
            cards = cardOfUserC;
            userFrame = CGRectMake(self.view.frame.size.width,self.view.frame.size.height/2, 74, 107);
            break;
            
        default:
            userFrame = CGRectMake(593,134, 74, 107);
            NSLog(@"userFrame = CGRectMake(593,134, 74, 107); error");
            break;
    }
    Card * tmp;
    Boolean cardCanOut = NO;
    for ( tmp  in cards) {
        cardCanOut = NO;
        if (!tmp.isEffectCard && (tmp.value+nowValue)<=99) {
            cardCanOut = YES;
            nowValue = nowValue + tmp.value;
            nowPlayer = (nowPlayer + ((isClockwise) ? 1 : -1) + playerCount) %playerCount;
        
            // 出卡後將卡片移除，加到原來的牌裡
            Card *outCard = tmp;
            [cards removeObject:tmp];
            [allCardsOnTable addObject:outCard];
            int selectCard = arc4random()%allCardsOnTable.count;
            Card *newCard = allCardsOnTable[selectCard];
            [allCardsOnTable removeObject:newCard];
            [cards addObject:newCard];
            [self cardSorting:cards];
            
//            view.frame = userFrame;
//            UIImage *img = [UIImage imageNamed:tmp.cardName];
//            view.image = img;
//            [self.view addSubview:view];
//            
//            [UIView animateWithDuration:1 animations:^{
//                view.frame = self.centerCard.frame;
//            } completion:^(BOOL finished) {
//                self.centerCard.image = [UIImage imageNamed:tmp.cardName];
//                view.image = nil;
//                [self computerOutCardOf:nowPlayer];
//                return;
//            }];
            break;
            
        }else if(tmp.isEffectCard){
            cardCanOut = YES;
            NSInteger addingValue = 0;
            switch (tmp.value) {
                case 4:
                    isClockwise = !isClockwise;
                    break;
                case 5:
                case 11:
                    break;
                case 10:
                    addingValue = -10;
                    break;
                case 12:
                    addingValue = -20;
                    break;
                case 13:
                    addingValue = 99 - nowValue;
                    break;
                    
                default:
                    break;
            }
            nowValue = nowValue + addingValue;
            nowPlayer = (nowPlayer + ((isClockwise) ? 1 : -1) + playerCount) %playerCount;
            
            // 出卡後將卡片移除，加到原來的牌裡
            [cards removeObject:tmp];
            [allCardsOnTable addObject:tmp];
            int selectCard = arc4random()%allCardsOnTable.count;
            Card *newCard = allCardsOnTable[selectCard];
            [allCardsOnTable removeObject:newCard];
            [cards addObject:newCard];
            [self cardSorting:cards];
//            view.frame = userFrame;
//            UIImage *img = [UIImage imageNamed:tmp.cardName];
//            view.image = img;
//            [self.view addSubview:view];
//            
//            [UIView animateWithDuration:1 animations:^{
//                view.frame = self.centerCard.frame;
//            } completion:^(BOOL finished) {
//                self.centerCard.image = [UIImage imageNamed:tmp.cardName];
//                view.image = nil;
//                [self computerOutCardOf:nowPlayer];
//                return;
//            }];
            
            break;
        }
        
    }
    if (cardCanOut) {
        NSLog(@"user %ld out of card %@",userID,tmp.cardName);
        view.frame = userFrame;
        UIImage *img = [UIImage imageNamed:tmp.cardName];
        view.image = img;
        [self.view addSubview:view];
        
        [UIView animateWithDuration:1 animations:^{
            view.frame = self.centerCard.frame;
        } completion:^(BOOL finished) {
            //self.centerCard.image = [UIImage imageNamed:tmp.cardName];
            NSString *state = isClockwise ? @"順時鐘" : @"逆時鐘";
            self.nowStateLabel.text = [NSString stringWithFormat:@"%@,目前:%ld",state,nowValue];
            self.centerCard.image = view.image;
            view.image = nil;
            [self computerOutCardOf:nowPlayer];
            return;
        }];
        
        
    }else{
        UIImageView * iconView = self.userIcons[userID];
        iconView.image = [UIImage imageNamed:@"xxxx.jpg"];
        isComputerLose[userID] = [NSNumber numberWithBool:YES];
        NSLog(@"computer of %ld is LOSE",userID);
    
        nowPlayer = (nowPlayer + ((isClockwise) ? 1 : -1) + playerCount) %playerCount;
        [self computerOutCardOf:nowPlayer];
    }
    
    
    
    
}

-(void)cardSorting:(NSMutableArray<Card*>*)cards{
    
    // 數字先從小到大
    Card *temp;
    for (int i =1; i<=(cards.count-1); i++) {
        for (int j = i - 1 ; j >= 0 ; j-- ) {
            if (cards[j].value > cards[j+1].value) {
                // 比數字大小
                temp = cards[j+1];
                cards[j+1] = cards[j];
                cards[j] = temp;
            }else if((cards[j].value == cards[j+1].value) && (cards[j].typeValue > cards[j+1].typeValue)){
                // 若數字一樣，比花色
                temp = cards[j+1];
                cards[j+1] = cards[j];
                cards[j] = temp;
            }
        }
    }
    
    NSInteger cardsCount = cards.count;
    NSInteger index = 0;
    for (int i =0; i<cardsCount; i++) {
        
        if (!cards[i].isEffectCard) {
            Card *tmp = cards[i];
            [cards removeObjectAtIndex:i];
            [cards insertObject:tmp atIndex:index];
            index++;
        }
    }
    
//    for (Card *haha in cards) {
//        NSLog(@"card type is %@ and value is %ld",haha.type,haha.value);
//    }
//    NSLog(@"################################");
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
