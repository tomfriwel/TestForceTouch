//
//  TouchView.m
//  TestForceTouch
//
//  Created by tomfriwel on 30/12/2016.
//  Copyright © 2016 tomfriwel. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

-(void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 8;
}

static float width = 90;

-(void)sizeViewWithForce:(CGFloat)scale {
    CGRect frame = self.frame;
    
    if (scale<1.0) {
        CGFloat w = width * (scale/2.0+1);
        
        CGPoint center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds)-w/2, CGRectGetMidY([UIScreen mainScreen].bounds)-w/2);
        
        frame.size = CGSizeMake(w, w);
        frame.origin = center;
        self.frame = frame;
        NSLog(@"%@", NSStringFromCGPoint(center));
        [self.forceTouchDelegate forceDidChanged:scale];
    }else{
        [self.forceTouchDelegate forceTouchBecomeMaximum];
    }
}


#pragma mark - touch event
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        NSLog(@"touchesBegan:%f", touch.force/touch.maximumPossibleForce);
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    for (UITouch *touch in touches) {
        if (touch.force > 0) {
            float alpha = (touch.maximumPossibleForce-touch.force)/touch.maximumPossibleForce;
            [self sizeViewWithForce:touch.force/touch.maximumPossibleForce];
            NSLog(@"%f", touch.force);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"JSButtonForceTouch" object:[NSNumber numberWithFloat:alpha]];
        }
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self sizeViewWithForce:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"JSButtonForceTouchEnd" object:[NSNumber numberWithFloat:1.0]];
}

@end
