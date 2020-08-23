//
//  SetCardView.h
//  Set
//
//  Created by Gal Berezansky on 17/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//
#import "CardViewProtocol.h"
#import "SetCardEnums.h"
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface SetCardView : UIView<CardViewProtocol>

///A enum representation of the shape .
@property (nonatomic , assign) Shape shape;

///An int representation of the number of shapes.
@property (nonatomic) NSUInteger numberOfShapes;

///A enum representation of the shading.
@property (nonatomic , assign) Shading shading;

///A enum representation of the color .
@property (nonatomic , assign) Color color;

///Determines if the card is choosen by the user or not.
@property (nonatomic) BOOL chosen;

///Determines if the card was already matched with other cards.
@property (nonatomic) BOOL matched;

@end

NS_ASSUME_NONNULL_END
