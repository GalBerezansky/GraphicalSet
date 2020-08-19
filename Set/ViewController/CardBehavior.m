//
//  CardBehavior.m
//  Set
//
//  Created by Gal Berezansky on 19/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "CardBehavior.h"

@interface CardBehavior()

@property (strong , nonatomic) UIGravityBehavior *gravity;
@property (strong , nonatomic) UICollisionBehavior *collider;


@end

@implementation CardBehavior

-(instancetype)init{
  self = [super init];
  self.gravity = [[UIGravityBehavior alloc] init];
  self.gravity.magnitude = 0.9;
  self.gravity.gravityDirection = CGVectorMake(0, -1);
  self.collider = [[UICollisionBehavior alloc] init];
  self.collider.translatesReferenceBoundsIntoBoundary = YES;
  [self addChildBehavior:self.gravity];
  [self addChildBehavior:self.collider];
  
  return self;
}

-(void)addItem:(id<UIDynamicItem>) item{
  [self.gravity addItem:item];
  [self.collider addItem:item];
}
-(void)removeItem:(id<UIDynamicItem>) item{
  [self.gravity removeItem:item];
  [self.collider removeItem:item];
}

-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
  
}

@end
