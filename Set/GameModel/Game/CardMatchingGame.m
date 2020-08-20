//
//  CardMatchingGame.m
//  SetProject 12/08/2020
//
//  Created by Gal Berezansky on 06/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "CardMatchingGame.h"

#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4
#define COST_TO_CHOOSE 1
#define MATCH_MODE2P 2
#define MATCH_MODE3P 3
static NSString * MATCHED_FORMAT = @"Matched %@ for %d points."; //CONST OR NOT?
static NSString * NOT_MATCHED_FORMAT = @"%@ Don't match! %d penalty points."; //CONST OR NOT?

@interface CardMatchingGame()

@property (nonatomic , readwrite) NSInteger score;

@end


@implementation CardMatchingGame

#pragma mark Initalizers methods
-(instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
  if(self = [super init]){
    self.deck = deck;
    self.cards = [[NSMutableArray alloc] init];
    for(NSUInteger i = 0 ; i < count ; i++){
      Card * card = [self addCardToGame];
      if(!card) return nil; //if draw failed we would return nil
    }
    self.matchMode = MATCH_MODE2P;//by default it is 2-card-match mode , can be changed.
  }
  return self;
}

#pragma mark Public API methods

-(Card *)addCardToGame{
  Card * card = [self.deck drawRandomCard];
  if(card)[self.cards addObject:card];
  return card;
}


-(Card *)cardAtIndex:(NSUInteger)index
{
  return (index < [self.cards count]) ? self.cards[index]: nil;
}

- (void) chooseCardAtIndex:(NSUInteger)index
{
  Card *card = [self cardAtIndex:index];
  if(card.chosen){
    card.chosen = NO;
    return;
  }
  NSMutableArray * otherCards = [NSMutableArray array];
  for(Card * otherCard in self.cards){//create the Array for the match method of Card
    if(otherCard.isChosen && !otherCard.isMatched){
      [otherCards addObject:otherCard];
    }
  }
  self.score-=COST_TO_CHOOSE;
  card.chosen = YES;
  if([otherCards count] == self.matchMode - 1){//if enough cards where choosen
    [self updateGameByScore:card otherCards:otherCards];
  }
}

#pragma mark Private helper methods

- (void)updateGameByScore:(Card *)card  otherCards:(NSMutableArray *)otherCards {
  int matchScore = [card match:otherCards];
  if(matchScore){
    self.score += matchScore * MATCH_BONUS;
    card.matched = YES;
    for(Card * otherCard in otherCards){
      otherCard.matched = YES;
    }
  }
  else{
    self.score -= MISMATCH_PENALTY;
    for(Card * otherCard in otherCards){
      otherCard.chosen = NO;
    }
  }
}


@end
