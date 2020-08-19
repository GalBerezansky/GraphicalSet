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

#define kINITIAL_NUMBER_OF_CARDS 12
#define kROW_INDEX_TO_ADD_CARD_AT 6
#define kNUMBER_OF_CARDS_TO_ADD 3

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
  self.game = [[CardMatchingGame alloc] initWithCardCount:0
                                                usingDeck:[self createDeck]];
  self.cardViews = [NSMutableArray array];
  [self initGrid];
  [self initAnimation];
  
  
  for(int i = 0 ; i < kINITIAL_NUMBER_OF_CARDS/kNUMBER_OF_CARDS_TO_ADD ; i++){
    [self addKCards:kNUMBER_OF_CARDS_TO_ADD];
  }
  [self updateUI];
}

- (void)initGrid {
  self.grid = [[Grid alloc] init];
  self.grid.size = CGSizeMake(300, 500);
  self.grid.cellAspectRatio = 1;
  self.grid.minimumNumberOfCells = 10;
}

- (void)initAnimation {
  self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
  self.cardBehavior = [[CardBehavior alloc] init];
  [self.animator addBehavior: self.cardBehavior];
}


#pragma mark Actions

- (IBAction)touchRedealButton:(UIButton * )sender{

  [self resetGame];
}


- (IBAction)touchAddCard:(id)sender {
  [self addKCards:kNUMBER_OF_CARDS_TO_ADD];
}

-(void)tap:(UITapGestureRecognizer *)sender {
  UIView <CardViewProtocol>*  cardView = (UIView <CardViewProtocol> *)sender.view;
  Card * card = [self getCardAssosiatedToCardView:cardView];
  NSUInteger chooseViewIndex = [self.game.cards indexOfObject:card];
  cardView.chosen = !cardView.chosen;
  [self.game chooseCardAtIndex:chooseViewIndex];
  [self updateUI];
}

- (IBAction)grabCard:(UIPanGestureRecognizer *)sender {
  CGPoint gesturePoint = [sender locationInView:self.gameView];
  if(sender.state == UIGestureRecognizerStateBegan){
    [self attachDroppingViewToPoint:gesturePoint];
  }
  else if(sender.state == UIGestureRecognizerStateChanged){
    self.attachment.anchorPoint = gesturePoint;
  }
  else if(sender.state == UIGestureRecognizerStateEnded){
    [self.animator removeBehavior:self.attachment];
  }
}

-(void)attachDroppingViewToPoint:(CGPoint)point{
}


#pragma mark UI_Update

-(void) updateUI{
  for(UIView<CardViewProtocol> * cardView in self.cardViews){
    [self updateCardView:cardView];
  }
  [self removeMatchedCardViews];
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld" , self.game.score];
}

- (void)updateCardView:(UIView <CardViewProtocol>*)cardView {
  Card * card = [self getCardAssosiatedToCardView:cardView];
  if(card.matched){
    cardView.matched = YES;
  }
  if(!card.chosen){
    cardView.chosen = NO;
  }
  
}


-(void)removeMatchedCardViews{
  NSMutableArray<UIView<CardViewProtocol> *> *cardsToRemove = [self findCardViewsToRemove];
  if([cardsToRemove count]){
   for(UIView<CardViewProtocol> * cardView in cardsToRemove){
     [self.cardBehavior removeItem:cardView];
   }
    [self animatedRemovingCards:cardsToRemove];
  }
}

-(void)resetGame{
  [self animatedRemovingCards:self.cardViews];
  [self enableAddCardButton];
  [self viewDidLoad];
}

-(void)animatedRemovingCards:(NSMutableArray *)cardsToRemove{
  [UIView animateWithDuration:1.0 animations:^{
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

-(UIView<CardViewProtocol> *)createCardView{
  return nil;
}

#pragma mark Private helper methods

-(void)addKCards:(NSUInteger)numberOfCards{
  for(int i = 0 ; i < numberOfCards ; i++){
    [self addNewCardAtColumn:i];
  }
}

- (void)addNewCardAtColumn:(int)c {
  Card * card = [self.game addCardToGame];
  if(!card){
    [self disableAddCardButton];
    return;
  }
  UIView<CardViewProtocol> * cardView = [self createCardView];
  [self.cardViews addObject:cardView];
  [self.gameView addSubview:cardView];
  UIGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(tap:)];
  [cardView addGestureRecognizer:recognizer];
  //float x = self.gameView.bounds.origin.x + self.gameView.bounds.size.height;
  cardView.frame = [self.grid frameOfCellAtRow:kROW_INDEX_TO_ADD_CARD_AT inColumn:c];
  [self setCardView:cardView WithCard:card];
  [self.cardBehavior addItem:cardView];
}

-(NSMutableArray<UIView<CardViewProtocol> *> *)findCardViewsToRemove{
  NSMutableArray * matchedCardArray = [NSMutableArray array];
  for(UIView<CardViewProtocol> * cardView in self.cardViews){
    if(cardView.matched)[matchedCardArray addObject:cardView];
  }
  return matchedCardArray;
}

-(void)enableAddCardButton{
  self.addCardButton.enabled = YES;
  [self.addCardButton setTitle:@"Add 3 cards"forState:UIControlStateNormal];
}

-(void)disableAddCardButton{
  self.addCardButton.enabled = NO;
  [self.addCardButton setTitle:@"Deck ended"forState:UIControlStateNormal];
}

@end
