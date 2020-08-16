//
//  ViewController.m
//  Matchismo
//
//  Created by Gal Berezansky on 05/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (weak, nonatomic) IBOutlet UIButton *redealButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation ViewController//Abstract class

- (IBAction)tap:(UITapGestureRecognizer *)sender {
  self.playingCardView.faceUp = !self.playingCardView.faceUp;
}


#pragma mark Instance Methods
- (void)viewDidLoad {
  [super viewDidLoad];
  self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                usingDeck:[self createDeck]];
  self.playingCardView.suit = @"♥️";
  self.playingCardView.rank = 13;
  [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
  NSUInteger chooseButtonIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:chooseButtonIndex];
  [self updateUI];
  
}

- (IBAction)touchRedealButton:(UIButton * )sender{
  [self viewDidLoad];
}

-(void) updateUI
{
  for(UIButton * cardButton in self.cardButtons){
    [self updateCardButton:cardButton];
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld" , self.game.score];
}


#pragma mark Abstract methods
-(Deck *) createDeck //Abstract Method
{
  return nil;
}

- (void)updateCardButton:(UIButton *)cardButton {//Abstract Method
  
}

-(NSAttributedString *)currentGameStateToAttributedString{//Abstract Method
  return nil;
}







@end
