//
//  ViewController.m
//  Matchismo
//
//  Created by Gal Berezansky on 05/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "ViewController.h"
#import "Grid.h"
#import "CardBehavior.h"

#define kINITIAL_NUMBER_OF_CARDS 9
#define kNUMBER_OF_CARDS_TO_ADD 3
#define kEMPTY_DECK 0
#define kMAX_AMOUNT_OF_CARDS 21

typedef UIView<CardViewProtocol> CardView;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIButton *redealButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *addCardButton;
@property (strong , nonatomic) UIDynamicAnimator *animator;
@property (strong , nonatomic) CardBehavior *cardBehavior;
@property (strong , nonatomic) UIAttachmentBehavior* attachment;
@end

@implementation ViewController//Abstract class




#pragma mark Initalizers


- (void)viewDidLoad {
  [super viewDidLoad];
  self.game = [[CardMatchingGame alloc] initWithCardCount:kEMPTY_DECK
                                                usingDeck:[self createDeck]];
  self.cardViews = [NSMutableArray array];
  [self initGrid];
  [self initAnimation];
  
  
  for(int i = 0 ; i < kINITIAL_NUMBER_OF_CARDS/kNUMBER_OF_CARDS_TO_ADD ; i++){
    [self addThreeCards];
  }
}

- (void)initGrid {
  self.grid = [[Grid alloc] init];
  self.grid.size = CGSizeMake(300, 500);
  self.grid.cellAspectRatio = 1;
  self.grid.minimumNumberOfCells = kINITIAL_NUMBER_OF_CARDS;
}

- (void)initAnimation {
  self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
  self.cardBehavior = [[CardBehavior alloc] init];
  [self.animator addBehavior: self.cardBehavior];
}

-(void)resetGame{
  [self animatedRemovingCards:self.cardViews];
  [self enableAddCardButton];
  [self viewDidLoad];
}


-(void)viewDidLayoutSubviews{

  //[self rotateGame];
}


-(void)rotateGame{
//  if(self.grid.minimumNumberOfCells == 9)
//    self.grid.minimumNumberOfCells = 21;
//  [self updateUI];
  
}

#pragma mark Button actions

- (IBAction)touchRedealButton:(UIButton * )sender{
  [self resetGame];
}


- (IBAction)touchAddCard:(id)sender {
  [self addThreeCards];
}

-(void)tap:(UITapGestureRecognizer *)sender {
  UIView <CardViewProtocol>*  cardView = (UIView <CardViewProtocol> *)sender.view;
  Card * card = [self getCardAssosiatedToCardView:cardView];
  NSUInteger chooseViewIndex = [self.game.cards indexOfObject:card];
  [cardView animateFlip];
  [self.game chooseCardAtIndex:chooseViewIndex];
  [self updateUI];
}

#pragma mark UI_Update

-(void) updateUI{
  for(CardView* cardView in self.cardViews){
    [self updateCardView:cardView];
  }
  [self removeMatchedCardViews];
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld" , self.game.score];
  [self updateCardButton];
  
}

- (void)updateCardView:(UIView <CardViewProtocol>*)cardView {

  Card * card = [self getCardAssosiatedToCardView:cardView];
  cardView.matched = card.matched;
  cardView.chosen = card.chosen;
}


-(void)removeMatchedCardViews{
  NSMutableArray<CardView*> *cardsToRemove = [self findCardViewsToRemove];
  if([cardsToRemove count]){
    for(CardView* cardView in cardsToRemove){
      [self.cardBehavior removeItem:cardView];
    }
    [self animatedRemovingCards:cardsToRemove];
  }
}

-(NSMutableArray<CardView *> *)findCardViewsToRemove{
  NSMutableArray * matchedCardArray = [NSMutableArray array];
  for(CardView *cardView in self.cardViews){
    if(cardView.matched)[matchedCardArray addObject:cardView];
  }
  return matchedCardArray;
}

-(void)updateCardButton{
  if([[self getActiveCardViews] count] == kMAX_AMOUNT_OF_CARDS ||[self.game.deck isEmpty]){
     [self disableAddCardButton];
   }
   else
     [self enableAddCardButton];
}

-(void)enableAddCardButton{
  self.addCardButton.enabled = YES;
  [self.addCardButton setTitle:@"Add 3 cards"forState:UIControlStateNormal];
}

-(void)disableAddCardButton{
  self.addCardButton.enabled = NO;
  if( [[self getActiveCardViews] count] == kMAX_AMOUNT_OF_CARDS)
    [self.addCardButton setTitle:@"Max amount"forState:UIControlStateNormal];
  else
    [self.addCardButton setTitle:@"Deck ended"forState:UIControlStateNormal];
}

#pragma mark Private helper methods

-(void)addThreeCards{
  for(int i = 0 ; i < kNUMBER_OF_CARDS_TO_ADD ; i++){
    [self addNewCardAtShortestColumn];
  }
  [self updateUI];
  
}

- (void)addNewCardAtShortestColumn{
  Card * card = [self.game addCardToGame];
  if(!card || [[self getActiveCardViews] count] == kMAX_AMOUNT_OF_CARDS){
    [self disableAddCardButton];
    return;
  }
  CardView * cardView = [self createCardView];
  [self.cardViews addObject:cardView];
  [self.gameView addSubview:cardView];
  UIGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(tap:)];
  [cardView addGestureRecognizer:recognizer];
  cardView.frame = [self.grid frameOfCellAtRow:9 inColumn:[self findShortestColumn]];
  [self setCardView:cardView WithCard:card];
  [self.cardBehavior addItem:cardView];
}

-(int)findShortestColumn{
  int columnIndexArray[3] = {0,0,0};
  NSDictionary * pointsToColumn = @{  @([self.grid frameOfCellAtRow:0 inColumn:0].origin.x) :@0 ,
                     @([self.grid frameOfCellAtRow:0 inColumn:1].origin.x) :@1 ,
                           @([self.grid frameOfCellAtRow:0 inColumn:2].origin.x) :@2
  };
                
  NSMutableArray<CardView *> *activeCardsArray = [self getActiveCardViews];
  for(CardView * cardView in activeCardsArray){
    NSInteger columnIndex = [pointsToColumn[@(cardView.frame.origin.x)] integerValue];
    columnIndexArray[columnIndex]++;
  }
  int shortestColumn = 0;
  for(int i = 0 ; i < 3 ; i++){
    if(columnIndexArray[i] < columnIndexArray[shortestColumn]){
      shortestColumn = i;
    }
  }
  return shortestColumn;
}

-(NSMutableArray *)getActiveCardViews{
  NSMutableArray<CardView *> *activeCardsArray = [NSMutableArray array];
  for(CardView *cardView in self.cardViews){
    if(!cardView.matched){
      [activeCardsArray addObject:cardView];
    }
  }
  return activeCardsArray;
}

#pragma mark Animation

-(void)animatedRemovingCards:(NSMutableArray *)cardsToRemove{
  [UIView animateWithDuration:1.7 animations:^{
    for(UIView *cardView in cardsToRemove){
      int x = (arc4random()%(int)(self.gameView.bounds.size.width * 5));
      int y = self.gameView.bounds.size.height;
      cardView.center = CGPointMake(x , -y);
    }
  }
                   completion:^(BOOL finished){
    [cardsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
  }];
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

-(CardView *)createCardView{
  return nil;
}

#pragma mark Helper



@end
