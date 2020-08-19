//
//  CardViewProtocol.h
//  Set
//
//  Created by Gal Berezansky on 17/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CardViewProtocol <NSObject>

@required

@property (nonatomic)BOOL chosen;

@property (nonatomic)BOOL matched;

@end

NS_ASSUME_NONNULL_END
