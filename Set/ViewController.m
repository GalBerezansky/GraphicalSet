//
//  ViewController.m
//  Matchismo
//
//  Created by Gal Berezansky on 05/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"
#import "Grid.h"

#define K_INITIAL_NUMBER_OF_CARDS 12

@interface ViewController ()

@property (strong , nonatomic) Grid * grid;
@property (weak, nonatomic) IBOutlet UIButton *redealButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *mainCardsView;
@end

@implementation ViewController//Abstract class




#pragma mark Initalizers
- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  self.game = [[CardMatchingGame alloc] initWithCardCount:K_INITIAL_NUMBER_OF_CARDS
                                                usingDeck:[self createDeck]];
  self.cardViews = [[NSMutableArray alloc] init];
  [self initGrid];
  
  for(int r = 0 ; r < self.grid.rowCount ; r++){
    for(int c = 0 ; c < self.grid.columnCount ; c++){
      [self initCardViewInGridAtRow:r atCol:c];
    }
  }
  [self updateUI];
}

- (void)initGrid {
  self.grid = [[Grid alloc] init];
  self.grid.size = CGSizeMake(300, 500);
  self.grid.cellAspectRatio = 1;
  self.grid.minimumNumberOfCells = K_INITIAL_NUMBER_OF_CARDS;
}

-(void)initCardViewInGridAtRow:(int) r atCol:(int)c{
  if([self.cardViews count] == K_INITIAL_NUMBER_OF_CARDS){
    return;
  }
  UIView<CardViewProtocol> *  cardView = [[PlayingCardView alloc] init];
  [self.cardViews addObject:cardView];
  [self.mainCardsView addSubview:cardView];
  UIGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
  [cardView addGestureRecognizer:recognizer];
  cardView.frame = [self.grid frameOfCellAtRow:r inColumn:c];
  NSUInteger cardIndex = [self.cardViews indexOfObject:cardView];
  Card * card = [self.game.cards objectAtIndex:cardIndex];
  [self setCardView:cardView WithCard:card];
}


#pragma mark Actions

- (IBAction)touchRedealButton:(UIButton * )sender{
  [self viewDidLoad];
}

-(void)tap:(UITapGestureRecognizer *)sender {
  UIView <CardViewProtocol>*  cardView = (UIView <CardViewProtocol> *)sender.view;
  Card * card = [self getCardAssosiatedToCardView:cardView];
  NSUInteger chooseViewIndex = [self.cardViews indexOfObject:cardView];
  if(card.matched){
    NSLog(@"%@ is already matched" , card.description);
    return;
  }
  cardView.faceUp = !cardView.faceUp;
  [self.game chooseCardAtIndex:chooseViewIndex];
  [self updateUI];
}

#pragma mark UI_Update

-(void) updateUI{
  for(UIView<CardViewProtocol> * cardView in self.cardViews){
    [self updateCardView:cardView];
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld" , self.game.score];
}

- (void)updateCardView:(UIView <CardViewProtocol>*)cardView {
  Card * card = [self getCardAssosiatedToCardView:cardView];
  if(card.matched){
    return;
  }
  if(!card.chosen){
    cardView.faceUp = NO;
  }
  
}

#pragma mark Abstract methods
-(Deck *) createDeck //Abstract Method
{
  return nil;
}

- (void)setCardView:(UIView <CardViewProtocol>*) cardView WithCard :(Card *)card{}
  
-(Card *)getCardAssosiatedToCardView:(UIView <CardViewProtocol>*)cardView{ //Abstract method
  return nil;
}

@end
