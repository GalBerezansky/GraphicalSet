//
//  PlayingCardView.m
//  Set
//
//  Created by Gal Berezansky on 16/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView

- (void)setSuit:(NSString *)suit
{
  _suit = suit;
  [self setNeedsDisplay];
}

-(void)setRank:(NSUInteger)rank
{
  _rank = rank;
  [self setNeedsDisplay];
}

-(void)setFaceUp:(BOOL)faceUp{
  _faceUp = faceUp;
  [self setNeedsDisplay];
}

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

-(CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
-(CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
-(CGFloat)cornerOffset {return [self cornerRadius] / 3.0; }



- (void)drawRect:(CGRect)rect {
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
  [roundedRect addClip];
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
    
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  
  [self drawCorners];
}

-(NSString *)rankAsString{
  if(self.rank < 0 || self.rank > 13){
    return @"?";
  }
  return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

-(void) drawCorners{
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.alignment = NSTextAlignmentCenter;
  
  UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
  
//  NSDictionary * _attributes = @{NSFontAttributeName : cornerFont ,
//                                 NSParagraphStyleAttributeName: paragraphStyle};
////
//  NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:
//                                   [NSString stringWithFormat:@"%@\m%@" , [self rankAsString] ,
//                                   self.suit attributes: _attributes];
}

#pragma mark Initialization
-(void)setup{
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

-(void)awakeFromNib{
  [super awakeFromNib];
  [self setup];
}

@end
