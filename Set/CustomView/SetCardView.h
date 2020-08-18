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

@property (nonatomic) BOOL chosen;

@end

NS_ASSUME_NONNULL_END
