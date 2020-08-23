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
#define kINITIAL_ROW_TO_ADD_CARDS_AT 9
#define kNUMBER_OF_CARDS_TO_ADD 3
#define kEMPTY_DECK 0
#define kMAX_AMOUNT_OF_CARDS 21
#define kGRID_WIDTH 300
#define kGRID_HEIGHT 500

typedef UIView<CardViewProtocol> CardView;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (strong , nonatomic) NSMutableArray<UIView *> * cardViews;
@property (weak, nonatomic) IBOutlet UIButton *redealButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *addCardButton;
@property (strong , nonatomic) UIDynamicAnimator *animator;
@property (strong , nonatomic) CardBehavior *cardBehavior;
@property (strong , nonatomic) UIAttachmentBehavior *attachment;
@property (strong , nonatomic) CardView *attachingCard;
@property  (strong , nonatomic) NSMutableArray<NSValue *> * originalPositions;
@end

@implementation ViewController//Abstract class




#pragma mark Initalizers


- (void)viewDidLoad {
  [super viewDidLoad];
  self.game = [[CardMatchingGame alloc] initWithCardCount:kEMPTY_DECK
                                                usingDeck:[self createDeck]];
//  self.isStacked = NO;
  self.cardViews = [NSMutableArray array];
  [self initGrid];
  [self initAnimation];
  
  
  for(int i = 0 ; i < kINITIAL_NUMBER_OF_CARDS/kNUMBER_OF_CARDS_TO_ADD ; i++){
    [self addThreeCards];
  }
}

- (void)initGrid {
  self.grid = [[Grid alloc] init];
  self.grid.size = CGSizeMake(kGRID_WIDTH, kGRID_HEIGHT);
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

  [self viewDidLoad];
}

#pragma mark Buttons

- (IBAction)touchRedealButton:(UIButton * )sender{
  [self resetGame];
}

- (IBAction)touchAddCard:(id)sender {
  [self addThreeCards];
}

#pragma mark Actions




-(void)tap:(UITapGestureRecognizer *)sender {
  CardView*  cardView = (CardView *)sender.view;
  if([self isCardsStacked]){
    [self tapWhenStacked : cardView];
  }
  else{
    [self tapCard: cardView];
  }
}

- (void)tapWhenStacked:(CardView *)cardView {
  [self animateCardsReturnToPlace:cardView.center];
  [self.animator addBehavior:self.cardBehavior];
  [self updateUI];
}

- (void)tapCard:(CardView *)cardView {
  Card * card = [self getCardAssosiatedToCardView:cardView];
  NSUInteger chooseViewIndex = [self.game.cards indexOfObject:card];
  [cardView animateFlip];
  [self.game chooseCardAtIndex:chooseViewIndex];
  [self updateUI];
}


-(void)pinch:(UIPinchGestureRecognizer *)sender {
  if([self isCardsStacked]){ //if already stacked no need for pinch gesture
    return;
  }
  CGPoint gestutePoint = [sender locationInView:self.gameView];
  if(sender.state == UIGestureRecognizerStateBegan){
    //self.isStacked = YES;
    [self.animator removeBehavior:self.cardBehavior];
    [self animatePinchGroupCards:gestutePoint];
  }
  [self updateUI];
}

-(void)pan:(UIPanGestureRecognizer *)sender{
  if(![self isCardsStacked]){
    return;
  }
  CGPoint gesturePoint = [sender locationInView:self.view];
  if (sender.state == UIGestureRecognizerStateBegan) {
    [self animateMovingStackToPoint:gesturePoint];
  } else if (sender.state == UIGestureRecognizerStateChanged) {
    [self animateMovingStackToPoint:gesturePoint];
  }
  [self updateUI];
}

#pragma mark Animation

- (void)animatePinchGroupCards:(CGPoint)point {
  self.originalPositions = [NSMutableArray array];
  [UIView animateWithDuration:1 animations:^{
    for(CardView * cardView in [self getActiveCardViews]){
      [self.originalPositions addObject:[NSValue valueWithCGPoint:cardView.center]];
      cardView.center = point;
    }
  }
  ];
}

- (void)animateCardsReturnToPlace:(CGPoint)point {
  [UIView animateWithDuration:1 animations:^{
    for(CardView * cardView in [self getActiveCardViews]){
      NSUInteger index = [[self getActiveCardViews] indexOfObject:cardView];
      cardView.center = [[self.originalPositions objectAtIndex:index] CGPointValue];
    }
  }
  ];
}

-(void)animateMovingStackToPoint:(CGPoint)point{
  [UIView animateWithDuration:1 animations:^{
    for(CardView * cardView in [self getActiveCardViews]){
      [self.originalPositions addObject:[NSValue valueWithCGPoint:cardView.center]];
      cardView.center = point;
    }
  }
  ];
}

-(void)animatedRemovingCards:(NSMutableArray *)cardsToRemove{
  [UIView animateWithDuration:1.7 animations:^{
    for(CardView *cardView in cardsToRemove){
      int x = (arc4random()%(int)(self.gameView.bounds.size.width * 10));
      int y = self.gameView.bounds.size.height;
      cardView.center = CGPointMake(x , -y);
    }
  }
                   completion:^(BOOL finished){
    [cardsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
  }];
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

-(void)updateCardButton{
  if([[self getActiveCardViews] count] == kMAX_AMOUNT_OF_CARDS ||[self.game.deck isEmpty] || [self isCardsStacked]){
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
  else if([self isCardsStacked]){
     [self.addCardButton setTitle:@"Anchored cards"forState:UIControlStateNormal];
  }
  else
    [self.addCardButton setTitle:@"Deck ended"forState:UIControlStateNormal];
}

#pragma mark Helper methods

-(void)addThreeCards{
  for(int i = 0 ; i < kNUMBER_OF_CARDS_TO_ADD ; i++){
    [self addNewCardAtShortestColumn];
  }
  [self updateUI];
  
}

- (void)addNewCardAtShortestColumn{
  Card * card = [self.game addCardToGame];
  if(!card || [[self getActiveCardViews] count] == kMAX_AMOUNT_OF_CARDS){
    return;
  }
  CardView * cardView = [self createCardViewFromCard:card];
  [self initCardView:cardView];
  cardView.frame = [self.grid frameOfCellAtRow:kINITIAL_ROW_TO_ADD_CARDS_AT inColumn:[self findShortestColumn]];
  //[self setCardView:cardView WithCard:card];
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

-(void)initCardView:(CardView *)cardView{
  [self.cardViews addObject:cardView];
  [self.gameView addSubview:cardView];
  [self initGesturesForCardView:cardView];
}

- (void)initGesturesForCardView:(CardView *)cardView {
  UIGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(tap:)];
  [cardView addGestureRecognizer:tapRecognizer];
  UIGestureRecognizer * pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(pinch:)];
  [cardView addGestureRecognizer:pinchRecognizer];
  UIGestureRecognizer * panRecognizer =  [[UIPanGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(pan:)];
  [cardView addGestureRecognizer:panRecognizer];
}

-(NSMutableArray<CardView *> *)getActiveCardViews{
  NSMutableArray<CardView *> *activeCardsArray = [NSMutableArray array];
  for(CardView *cardView in self.cardViews){
    if(!cardView.matched){
      [activeCardsArray addObject:cardView];
    }
  }
  return activeCardsArray;
}

-(NSMutableArray<CardView *> *)findCardViewsToRemove{
  NSMutableArray * matchedCardArray = [NSMutableArray array];
  for(CardView *cardView in self.cardViews){
    if(cardView.matched)[matchedCardArray addObject:cardView];
  }
  return matchedCardArray;
}

-(BOOL)isCardsStacked{
  CardView * cardView = [[self getActiveCardViews] firstObject];
  if(!cardView){
    return NO;
  }
  CGPoint point = cardView.center;
  for(CardView * otherCardView in [self getActiveCardViews]){
    if(otherCardView.center.x != point.x || otherCardView.center.y != point.y){
      return NO;
    }
  }
  return YES;
}


#pragma mark Abstract methods
-(Deck *) createDeck //Abstract Method
{
  return nil;
}

-(CardView*)createCardViewFromCard :(Card *)card{
  return nil;
}

-(Card *)getCardAssosiatedToCardView:(UIView <CardViewProtocol>*)cardView{ //Abstract method
  return nil;
}

@end
