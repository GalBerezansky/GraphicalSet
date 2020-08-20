//
//  SetCardView.m
//  Set
//
//  Created by Gal Berezansky on 17/08/2020.
//  Copyright © 2020 Gal Bereznaksy. All rights reserved.
//

#import "SetCardView.h"

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90



@interface SetCardView()

@property (nonatomic,strong) NSArray * pointsArray;

@end

@implementation SetCardView

#pragma mark - Properties

-(void)setShape:(Shape)shape{
  _shape = shape;
  [self setNeedsDisplay];
}

-(void)setColor:(Color)color{
  _color = color;
  [self setNeedsDisplay];
}

-(void)setShading:(Shading)shading{
  _shading = shading;
  [self setNeedsDisplay];
}

-(void)setNumberOfShapes:(NSUInteger)numberOfShapes{
  _numberOfShapes = numberOfShapes;
  [self setNeedsDisplay];
}

-(void)setChosen:(BOOL)chosen{
  _chosen = chosen;
  [self setNeedsDisplay];
}

-(void)setMatched:(BOOL)matched{
  _matched = matched;
  [self setNeedsDisplay];
}

#pragma mark - Drawing


#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

- (void)drawRect:(CGRect)rect
{
  [self setRoundedRect];
  for(NSUInteger i = 0 ; i<self.numberOfShapes ; i++){
      CGPoint point = [[self.pointsArray objectAtIndex:i] CGPointValue];
      [self drawShapeAtPoint:point];
  }
}

-(void)setRoundedRect{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:
                               self.bounds cornerRadius:[self cornerRadius]];
  
  [roundedRect addClip];
  [self.chosen ? [UIColor lightGrayColor] : [UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
}

-(void)drawShapeAtPoint:(CGPoint)point{
  switch (self.shape) {
    case SHAPE1:
      [self drawDiamondAtPoint : point];
      break;
    case SHAPE2:
      [self drawOvalAtPoint:point];
      break;
    case SHAPE3:
      [self drawSquiggleAtPoint:point];
      break;
    default:
      break;
  }
}


#define DIAMOND_WIDTH 0.24
#define DIAMOND_HEIGHT 0.8
#define DIAMOND_STROKE_WIDTH 0.01

-(void)drawDiamondAtPoint:(CGPoint)point{
  CGFloat dx = self.bounds.size.width * DIAMOND_WIDTH / 2.0;
  CGFloat dy = self.bounds.size.height * DIAMOND_HEIGHT/ 2.0;
  UIBezierPath *path = [[UIBezierPath alloc] init];
  float x = point.x;
  float y = point.y;
  [path moveToPoint:CGPointMake(x ,y - dy)];
  [path addLineToPoint:CGPointMake(x +dx ,y)];
  [path addLineToPoint:CGPointMake(x ,y + dy)];
  [path addLineToPoint:CGPointMake(x - dx,y)];
  [path addLineToPoint:CGPointMake(x ,y - dy)];
  path.lineWidth = self.bounds.size.width * DIAMOND_STROKE_WIDTH;
  [path closePath];
  [self setShadingToPath:path];
}


- (void)drawOvalAtPoint:(CGPoint)point{
  CGRect rect= CGRectMake(point.x - self.bounds.size.width/8, point.y - self.bounds.size.height/3,
                          self.bounds.size.width/4, self.bounds.size.height/1.5);
  UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
  path.lineWidth = self.bounds.size.width * DIAMOND_STROKE_WIDTH;
  [self setShadingToPath:path];
}


#define SQUIGGLE_WIDTH 0.12
#define SQUIGGLE_HEIGHT 0.5
#define SQUIGGLE_FACTOR 0.8
#define SQUIGLE_STROKE_WIDTH 0.01
 
- (void)drawSquiggleAtPoint:(CGPoint)point {
  CGFloat dx = self.bounds.size.width * SQUIGGLE_WIDTH / 2.0;
  CGFloat dy = self.bounds.size.height * SQUIGGLE_HEIGHT / 2.0;
  CGFloat dsqx = dx * SQUIGGLE_FACTOR;
  CGFloat dsqy = dy * SQUIGGLE_FACTOR;
  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:CGPointMake(point.x - dx, point.y - dy)];
  [path addQuadCurveToPoint:CGPointMake(point.x + dx, point.y - dy)
               controlPoint:CGPointMake(point.x - dsqx, point.y - dy - dsqy)];
  [path addCurveToPoint:CGPointMake(point.x + dx, point.y + dy)
          controlPoint1:CGPointMake(point.x + dx + dsqx, point.y - dy + dsqy)
          controlPoint2:CGPointMake(point.x + dx - dsqx, point.y + dy - dsqy)];
  [path addQuadCurveToPoint:CGPointMake(point.x - dx, point.y + dy)
               controlPoint:CGPointMake(point.x + dsqx, point.y + dy + dsqy)];
  [path addCurveToPoint:CGPointMake(point.x - dx, point.y - dy)
          controlPoint1:CGPointMake(point.x - dx - dsqx, point.y + dy - dsqy)
          controlPoint2:CGPointMake(point.x - dx + dsqx, point.y - dy + dsqy)];
  path.lineWidth = self.bounds.size.width * SQUIGLE_STROKE_WIDTH;
  [path closePath];
  [self setShadingToPath:path];
}


-(void)setShadingToPath:(UIBezierPath *)path{
  switch(self.shading){
    case SHADING1:
      [[self getMatchingColorForColorEnum] setFill];
      [path fill];
      break;
    case SHADING2:
      [[UIColor clearColor] setFill];
      [[self getMatchingColorForColorEnum] setStroke];
      [path fill];
      [path stroke];
      break;
    case SHADING3:
      [self fillPathWithStripes:path];
      break;
      
  }
}

#define STRIPE_WIDTH 0.005

-(void)fillPathWithStripes:(UIBezierPath *)path{
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  [path addClip];

  UIBezierPath *stripes = [[UIBezierPath alloc] init];
  int numberOfStripes = 40;
  for (int i = 0; i < numberOfStripes ;i++) {
    float currentX = path.bounds.origin.x;
    float currentY = path.bounds.origin.y + path.bounds.size.height*i/numberOfStripes;
    float dx = path.bounds.size.width;
    [stripes moveToPoint:CGPointMake(currentX , currentY)];
    [stripes addLineToPoint:CGPointMake(currentX + dx , currentY)];
  }
  stripes.lineWidth = self.bounds.size.width * STRIPE_WIDTH;
  [[self getMatchingColorForColorEnum] setStroke];
  [stripes stroke];
  [path stroke];
  CGContextRestoreGState(context);
  
}

#pragma mark - Initialization

- (void)setup
{
  [self initPointsArray];
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
  [super awakeFromNib];
  [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

-(void)initPointsArray{
  float middleOfHeight = self.bounds.origin.y + self.bounds.size.height/2;
  self.pointsArray =  @[@(CGPointMake(self.bounds.origin.x +
                                      (self.bounds.size.width/3)*1.5 ,middleOfHeight)),
                        @(CGPointMake(self.bounds.origin.x +
                                      (self.bounds.size.width/3)*0.6 ,middleOfHeight)),
                        @(CGPointMake(self.bounds.origin.x +
                                      (self.bounds.size.width/3)*2.4 ,middleOfHeight))];
}

#pragma mark Helper Functions
-(UIColor *)getMatchingColorForColorEnum{
  return [@[[UIColor greenColor] , [UIColor redColor] , [UIColor purpleColor]]
          objectAtIndex:self.color];
}


#pragma mark - Animation

-(void)animateFlip{
    [UIView transitionWithView:self duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{self.chosen = !self.chosen;} completion:nil];
}

@end
