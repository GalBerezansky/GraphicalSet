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

static NSString * MATCHED_FORMAT = @"Matched %@ for %d points.";
static NSString * NOT_MATCHED_FORMAT = @"%@ Don't match! %d penalty points.";

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


- (void)setCardView:(UIView <CardViewProtocol>*) cardView WithCard :(Card *)card {
  SetCard * setCard = (SetCard *)card;
  SetCardView * setCardView = (SetCardView *) cardView;
  if(card.chosen){
    cardView.chosen = YES;
  }
}


-(Card *)getCardAssosiatedToCardView:(UIView *)cardView{
  for(SetCard * setCard in self.game.cards){
    SetCardView * setCardView= (SetCardView *)cardView;
  }
  return nil;
}


 #pragma mark Helper private methods


+(NSDictionary *) stringToColors {
  return @{@"red" : [UIColor redColor] ,
           @"green" : [UIColor greenColor] ,
           @"purple" : [UIColor purpleColor]};
}

+(NSDictionary *) stringToShadingFloat{
  return @{@"hollow" : @0 , @"shaded" : @0.3, @"filled" : @1.0};
}

-(UIImage *)backgroundImageForCard:(Card *) card
{
  return [UIImage imageNamed:card.isChosen ? @"setcardchoosen" : @"setcardfront"];
}

@end
