//
//  ViewController.h
//  Set
//
//  Created by Gal Berezansky on 12/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//
//Abstract class

#import "Deck.h"
#import "CardMatchingGame.h"
#import "CardViewProtocol.h"
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController//Abstract class

///Holds the object that runs the game.
@property (strong , nonatomic) CardMatchingGame * game;
@property (strong , nonatomic) NSMutableArray<UIView *> * cardViews;

///Creates the deck for the game (with random drawings).
- (Deck *) createDeck; //Abstract method

-(void)setCardView:(UIView <CardViewProtocol>*) cardView WithCard :(Card *)card;
  
-(Card *)getCardAssosiatedToCardView:(UIView <CardViewProtocol>*)cardView;


@end

