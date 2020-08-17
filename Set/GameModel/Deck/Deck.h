//
//  Deck.h
//  SetProject 12/08/2020
//
//  Created by Gal Berezansky on 05/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card;

NS_ASSUME_NONNULL_BEGIN

///Abstrach class that represents a deck of cards.
@interface Deck : NSObject

///adds a card to the top of the deck.
-(void) addCard: (Card *) card atTop: (BOOL) atTop;

///adds a card to the bottom of the deck
-(void) addCard: (Card *)card;

///Draws a random card from the deck (without returning it).
-(Card *) drawRandomCard;

@end

NS_ASSUME_NONNULL_END
