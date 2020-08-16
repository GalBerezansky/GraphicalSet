//
//  CardMatchingGame.h
//  SetProject 12/08/2020
//
//  Created by Gal Berezansky on 06/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"
#import "CurrentGameState.h"


NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount: (NSUInteger)count
                         usingDeck: (Deck *)deck; // NS_DESIGNATED_INITIALIZER

///Chooses a card at an index and updates the game state accordingly.
- (void)chooseCardAtIndex:(NSUInteger)index;

///Returns a card at a given index.
-(Card *) cardAtIndex:(NSUInteger)index;

///The score of the game.
@property (nonatomic , readonly) NSInteger score;

///The mode of the game (2- cars match or 3-cards match)
@property (nonatomic) NSInteger matchMode;

///holds information of the current game state fro the results feature.
@property (nonatomic,strong) CurrentGameState * currentGameState;

@end

NS_ASSUME_NONNULL_END
