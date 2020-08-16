//
//  PlayingCardView.h
//  Set
//
//  Created by Gal Berezansky on 16/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

@end

NS_ASSUME_NONNULL_END
