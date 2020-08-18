//
//  SetCard.m
//  SetProject 12/08/2020
//
//  Created by Gal Berezansky on 11/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

#pragma mark Instance Methods

-(int) match:(NSArray *) otherCards{
  int score = 0;
  SetCard * otherCard1 = [otherCards objectAtIndex:0];
  SetCard * otherCard2 = [otherCards objectAtIndex:1];
  NSArray * shapeArray = @[@(self.shape) , @(otherCard1.shape) , @(otherCard2.shape)];
  NSArray * numberOfShapesArray = @[@(self.numberOfShapes) , @(otherCard1.numberOfShapes) ,
                                    @(otherCard2.numberOfShapes)];
  NSArray * shadingArray = @[@(self.shading) , @(otherCard1.shading) , @(otherCard2.shading)];
  NSArray * colorArray = @[@(self.color) , @(otherCard1.color) , @(otherCard2.color)];
  
  if([SetCard isFeatureValid:shapeArray] && [SetCard isFeatureValid:numberOfShapesArray]&&
     [SetCard isFeatureValid:shadingArray] && [SetCard isFeatureValid:colorArray]){
    score = 8;
  }
  
  return score;
}


-(NSString *) description{
  return nil;
}

#pragma mark Class methods

+(NSUInteger) maxAmountOfShapes{
  return 3;
}


#pragma mark Helper private methods
+(BOOL) allSpecificFeaturesMatch : (NSArray *) featuresArray{
  id feature1 = [featuresArray objectAtIndex:0];
  id feature2 = [featuresArray objectAtIndex:1];
  id feature3 = [featuresArray objectAtIndex:2];
  return ([feature1 isEqual:feature2] && [feature2 isEqual: feature3]);
}

+(BOOL) allSpecificFeaturesDontMatch : (NSArray *) featuresArray{
  id feature1 = [featuresArray objectAtIndex:0];
  id feature2 = [featuresArray objectAtIndex:1];
  id feature3 = [featuresArray objectAtIndex:2];
  return (![feature1 isEqual:feature2] && ![feature2 isEqual:feature3]
          && ![feature1 isEqual: feature3]) ;
}

+(BOOL)isFeatureValid: (NSArray *) featuresArray{
  return [SetCard allSpecificFeaturesMatch:featuresArray] ||
  [SetCard allSpecificFeaturesDontMatch:featuresArray];
}



@end
