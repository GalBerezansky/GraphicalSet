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

-(void)tap:(UITapGestureRecognizer *)sender {
  PlayingCardView * card = (PlayingCardView *)sender.view;
  card.faceUp = !card.faceUp;
}


#pragma mark Instance Methods
- (void)viewDidLoad {
  [super viewDidLoad];
  self.game = [[CardMatchingGame alloc] initWithCardCount:12
                                                usingDeck:[self createDeck]];
  self.cardViews = [[NSMutableArray alloc] init];
  self.grid = [[Grid alloc] init];
  self.grid.size = CGSizeMake(300, 500);
  self.grid.cellAspectRatio = 1;
  self.grid.minimumNumberOfCells = K_INITIAL_NUMBER_OF_CARDS;
  
  for(int r = 0 ; r < self.grid.rowCount ; r++){
    for(int c = 0 ; c < self.grid.columnCount ; c++){
      [self initCardViewInGridAtRow:r atCol:c];
      
    }
  }
  //[self updateUI];
}

-(void)initCardViewInGridAtRow:(int) r atCol:(int)c{
  if([self.cardViews count] == K_INITIAL_NUMBER_OF_CARDS){
    return;
  }
  PlayingCardView * cardView = [[PlayingCardView alloc] init];
  [self.cardViews addObject:cardView];
  [self.mainCardsView addSubview:cardView];
  UIGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
  cardView.frame = [self.grid frameOfCellAtRow:r inColumn:c];
  [cardView addGestureRecognizer:recognizer];
  NSUInteger cardIndex = [self.cardViews indexOfObject:cardView];
  PlayingCard * card = [self.game.cards objectAtIndex:cardIndex];
  cardView.rank = card.rank;
  cardView.suit = card.suit;
}

- (IBAction)touchRedealButton:(UIButton * )sender{
  [self viewDidLoad];
}

-(void) updateUI{
  for(UIView * cardView in self.cardViews){
    [self updateCardView:cardView];
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld" , self.game.score];
}


#pragma mark Abstract methods
-(Deck *) createDeck //Abstract Method
{
  return nil;
}

- (void)updateCardView:(UIView *)cardView {}//Abstract Method
  



@end
