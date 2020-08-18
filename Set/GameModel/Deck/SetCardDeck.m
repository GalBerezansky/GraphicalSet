//
//  SetCardDeck.m
//  SetProject 12/08/2020
//
//  Created by Gal Berezansky on 11/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"


@implementation SetCardDeck

#pragma mark Instance Methods


- (instancetype) init
{
  self = [super init];
  if (self){
    for(int colorIndex = 0 ; colorIndex < 3 ; colorIndex++){
      for(int shadingIndex = 0 ; shadingIndex < 3 ; shadingIndex++){
        for(int shapeIndex = 0 ; shapeIndex < 3 ; shapeIndex++){
          for(int numberOfShapes = 1; numberOfShapes <= 3;numberOfShapes++)
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
  NSLog(@"deck initalized!");
  return self;
}

@end
