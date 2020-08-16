//
//  PlayingCardGameViewController.m
//  Set
//
//  Created by Gal Berezansky on 12/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#define PlayCardMatchMode 2

static NSString * MATCHED_FORMAT = @"Matched %@ for %d points.";
static NSString * NOT_MATCHED_FORMAT = @"%@ Don't match! %d penalty points.";

//@interface PlayingCardGameViewController ()
//
//@end

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

-(void) updateCardButton: (UIButton * ) cardButton{
  NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
  Card * card = [self.game cardAtIndex:cardButtonIndex];
  [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
  [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
  cardButton.enabled = !card.isMatched;
}

#pragma mark Helper private methods
-(NSString *)titleForCard:(Card *) card{
  return card.isChosen ? card.description : @"";
}

-(UIImage *)backgroundImageForCard:(Card *) card
{
  return [UIImage imageNamed:card.isChosen ? @"playcardfront" : @"playcardback"];
}



@end
