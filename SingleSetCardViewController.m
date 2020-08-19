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
@property (strong, nonatomic) SetCardDeck * deck;
@property (weak, nonatomic) IBOutlet SetCardView *setView;

@end

@implementation SingleSetCardViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.deck = [[SetCardDeck alloc] init];
  SetCard * card = (SetCard *)[self.deck drawRandomCard];
  self.setView.color = card.color;
  self.setView.shape = card.shape;
  self.setView.shading = card.shading;
  self.setView.numberOfShapes = card.numberOfShapes;
  self.setView.chosen = NO;
}
@end
