//
//  SingleSetCardViewController.m
//  Set
//
//  Created by Gal Berezansky on 18/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "SingleSetCardViewController.h"
#import "SetCardView.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SingleSetCardViewController ()
@property (weak, nonatomic) IBOutlet SetCardView *setCardView;
@property (strong, nonatomic) SetCardDeck * deck;

@end

@implementation SingleSetCardViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.deck = [[SetCardDeck alloc] init];
  SetCard * card = (SetCard *)[self.deck drawRandomCard];
  self.setCardView.color = card.color;
  self.setCardView.shape = card.shape;
  self.setCardView.shading = card.shading;
  self.setCardView.numberOfShapes = card.numberOfShapes;
  self.setCardView.chosen = NO;
}
@end
