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

typedef UIView<CardViewProtocol> CardView;
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

-(Card *)getCardAssosiatedToCardView:(UIView *)cardView{
  for(PlayingCard * playCard in self.game.cards){
    PlayingCardView * playCardView = (PlayingCardView * )cardView;
    if(playCard.rank == playCardView.rank && [playCard.suit isEqualToString:playCardView.suit]){
      return playCard;
    }
  }
  return nil;
}

-(CardView *)createCardViewFromCard :(Card *)card{
   CardView * playingCardView = [self createCardView];
  [self setCardView:playingCardView WithCard:card];
  return playingCardView;;
}

#pragma mark Helper methods

-(UIView<CardViewProtocol> *)createCardView{
  PlayingCardView * playingCardView = [[PlayingCardView alloc] initWithFrame: CGRectMake(0, 0, self.grid.cellSize.width, self.grid.cellSize.height)];
  return playingCardView;
}

- (void)setCardView:(CardView *) cardView WithCard :(Card *)card {
  PlayingCard * playCard = (PlayingCard *)card;
  PlayingCardView * playCardView = (PlayingCardView *) cardView;
  playCardView.rank = playCard.rank;
  playCardView.suit = playCard.suit;
  if(card.chosen){
    cardView.chosen = YES;
  }
  if(card.matched){
    cardView.matched = YES;
  }
}


@end
