//
//  PlayingCardGameViewController.m
//  Set
//
//  Created by Gal Berezansky on 12/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#define PlayCardMatchMode 2

@implementation PlayingCardGameViewController

#pragma mark Instance methods
- (void)viewDidLoad {
  [super viewDidLoad];
  self.game.matchMode = PlayCardMatchMode;
}



#pragma mark Abstract methods implementation
-(Deck *) createDeck{
  return [[PlayingCardDeck alloc] init];
}

- (void)setCardView:(UIView <CardViewProtocol>*) cardView WithCard :(Card *)card {
  PlayingCard * playCard = (PlayingCard *)card;
  PlayingCardView * playCardView = (PlayingCardView *) cardView;
  playCardView.rank = playCard.rank;
  playCardView.suit = playCard.suit;
  if(card.chosen){
    cardView.faceUp = YES;
  }
}


-(Card *)getCardAssosiatedToCardView:(UIView *)cardView{
  for(PlayingCard * playCard in self.game.cards){
    PlayingCardView * playCardView = (PlayingCardView * )cardView;
    if(playCard.rank == playCardView.rank && [playCard.suit isEqualToString:playCardView.suit]){
      return playCard;
    }
  }
  return nil;
}

#pragma mark Private Helper Methods

  


@end
