//
//  CardBehavior.h
//  Set
//
//  Created by Gal Berezansky on 19/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardBehavior : UIDynamicBehavior

-(void)addItem:(id<UIDynamicItem>) item;

-(void)removeItem:(id<UIDynamicItem>) item;

@end

NS_ASSUME_NONNULL_END
