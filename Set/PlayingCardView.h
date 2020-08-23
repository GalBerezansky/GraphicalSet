//
//  PlayingCardView.h
//  Set
//
//  Created by Gal Berezansky on 16/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//
#import "CardViewProtocol.h"
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardView : UIView<CardViewProtocol>

///An int representation of the rank.
@property (nonatomic) NSUInteger rank;

///A string representation of the suit (for example ♥️).
@property (strong, nonatomic) NSString *suit;

///Determines if the card is choosen by the user or not.
@property (nonatomic) BOOL chosen;

///Determines if the card was already matched with other cards.
@property (nonatomic) BOOL matched;

@end

NS_ASSUME_NONNULL_END
