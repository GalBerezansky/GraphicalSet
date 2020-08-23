//
//  SetGameViewController.m
//  Set
//
//  Created by Gal Berezansky on 12/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardView.h"
#import "SetCardDeck.h"
#import "SetCard.h"

#define SetMatchMode 3

typedef UIView<CardViewProtocol> CardView;
@implementation SetGameViewController

#pragma mark Instance methods

- (void)viewDidLoad {
  [super viewDidLoad];
  self.game.matchMode = SetMatchMode;
}


#pragma mark Abstract methods implementation

-(Deck *) createDeck{
  return [[SetCardDeck alloc] init];
  
}

-(CardView *)createCardViewFromCard :(Card *)card{
   CardView *setCardView = [self createCardView];
  [self setCardView:setCardView WithCard:card];
  return setCardView;;
}

-(Card *)getCardAssosiatedToCardView:(UIView *)cardView{
  for(SetCard * setCard in self.game.cards){
    SetCardView * setCardView = (SetCardView *) cardView;
    if(setCardView.shape == setCard.shape &&
       setCardView.numberOfShapes == setCard.numberOfShapes &&
       setCardView.shading == setCard.shading &&
       setCardView.color == setCard.color){
          return setCard;
    }
  }
  return nil;
}

#pragma mark Helper methods

- (void)setCardView:(UIView <CardViewProtocol>*) cardView WithCard :(Card *)card {
  SetCard * setCard = (SetCard *)card;
  SetCardView * setCardView = (SetCardView *) cardView;
  setCardView.shape = setCard.shape;
  setCardView.numberOfShapes = setCard.numberOfShapes;
  setCardView.shading = setCard.shading;
  setCardView.color = setCard.color;
  if(card.chosen){
    cardView.chosen = YES;
  }
  if(card.matched){
    cardView.matched = YES;
  }
}

-(UIView<CardViewProtocol> *)createCardView{
  SetCardView * setCardView = [[SetCardView alloc] initWithFrame: CGRectMake(0, 0, self.grid.cellSize.width, self.grid.cellSize.height)];
  return setCardView;
}


@end
