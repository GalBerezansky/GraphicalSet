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
#import "Grid.h"
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController//Abstract class

///Holds the object that runs the game.
@property (strong , nonatomic) CardMatchingGame * game;

@property (strong , nonatomic) Grid * grid;

///Creates the deck for the game (with random drawings).
- (Deck *) createDeck; //Abstract method

///Sets a cardView object with a card object.
-(void)setCardView:(UIView <CardViewProtocol>*) cardView WithCard :(Card *)card;
  
///returns the card objerct assosiated with the CardView object
-(Card *)getCardAssosiatedToCardView:(UIView <CardViewProtocol>*)cardView;

///Creates a new cardView object
-(UIView<CardViewProtocol> *)createCardView;


@end

