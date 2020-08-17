//
//  SetGameViewController.m
//  Set
//
//  Created by Gal Berezansky on 12/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "SetGameViewController.h"
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

-(void) updateCardButton:(UIButton *)cardButton{
//  NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
//  SetCard * card = (SetCard *)[self.game cardAtIndex:cardButtonIndex];
//  [cardButton setAttributedTitle:[SetGameViewController cardToAttributedStringRep:card]
//                        forState:UIControlStateNormal];
//  [cardButton setBackgroundImage:[self backgroundImageForCard:card]
//                        forState:UIControlStateNormal];
//  cardButton.enabled = !card.isMatched;
}


 #pragma mark Helper private methods


+(NSAttributedString *)cardToAttributedStringRep : (SetCard *) card{
  float shadingFloatRep  =[[SetGameViewController stringToShadingFloat][card.shading] floatValue];
  UIColor * cardColor = [SetGameViewController stringToColors][card.color];
  UIColor * cardColorShaded = [cardColor colorWithAlphaComponent:shadingFloatRep];
  NSDictionary * attDic = @{NSForegroundColorAttributeName : cardColorShaded ,
                            NSStrokeColorAttributeName : cardColor,
                            NSStrokeWidthAttributeName : @-5} ;
  NSAttributedString * cardAttributedString = [[NSAttributedString alloc]
                                               initWithString:card.description attributes:attDic];
  return cardAttributedString;
}

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
