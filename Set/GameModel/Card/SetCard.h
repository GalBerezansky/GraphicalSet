//
//  SetCard.h
//  SetProject 12/08/2020
//
//  Created by Gal Berezansky on 11/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//
//
#import "Card.h"
#import "SetCardEnums.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card
///A enum representation of the shape .
@property (nonatomic , assign) Shape shape;

///An int representation of the number of shapes.
@property (nonatomic) NSUInteger numberOfShapes;

///A enum representation of the shading.
@property (nonatomic , assign) Shading shading;

///A enum representation of the color .
@property (nonatomic , assign) Color color;

@end

NS_ASSUME_NONNULL_END
