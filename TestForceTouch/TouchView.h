//
//  TouchView.h
//  TestForceTouch
//
//  Created by tomfriwel on 30/12/2016.
//  Copyright © 2016 tomfriwel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ForceTouchDelegate <NSObject>

-(void)forceDidChanged:(CGFloat)force;

-(void)forceTouchBecomeMaximum;

-(void)forceTouchDidCanceled;

@end

@interface TouchView : UIView

@property (weak)id <ForceTouchDelegate> forceTouchDelegate;

@end
