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
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController//Abstract class

///Holds the object that runs the game.
@property (strong , nonatomic) CardMatchingGame * game;

///The cards buttons array.
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

///The result label.
@property (weak, nonatomic) IBOutlet UILabel *reultsLabel;

///Holds the attributed string that represents the game history.
@property (strong , nonatomic) NSMutableAttributedString * gameHistoryAttributedString;

///Updates the UI after each round.
-(void) updateUI; //implemented

///Creates the deck for the game (with random drawings).
- (Deck *) createDeck; //Abstract method

///Updates the card game UI
- (void)updateCardButton:(UIButton *)cardButton;//Abstract method



@end

