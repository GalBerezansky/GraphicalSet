//
//  SetCardDeck.m
//  SetProject 12/08/2020
//
//  Created by Gal Berezansky on 11/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

#define kNUMBER_OF_ATTRIBUTES 3

@implementation SetCardDeck

#pragma mark Instance Methods


- (instancetype) init
{
  self = [super init];
  if (self){
    for(int colorIndex = 0 ; colorIndex < kNUMBER_OF_ATTRIBUTES ; colorIndex++){
      for(int shadingIndex = 0 ; shadingIndex < kNUMBER_OF_ATTRIBUTES ; shadingIndex++){
        for(int shapeIndex = 0 ; shapeIndex < kNUMBER_OF_ATTRIBUTES ; shapeIndex++){
          for(int numberOfShapes = 1; numberOfShapes <= kNUMBER_OF_ATTRIBUTES;numberOfShapes++)
            {
            SetCard * card = [[SetCard alloc] init];
            card.shape = ((Shape)shapeIndex);
            card.shading = ((Shading)shadingIndex);
            card.color = ((Color)colorIndex);
            card.numberOfShapes = numberOfShapes;
            [self addCard:card];
          }
        }
      }
    }
  }
  return self;
}

@end
