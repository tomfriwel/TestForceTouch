//
//  ViewController.m
//  TestForceTouch
//
//  Created by tomfriwel on 30/12/2016.
//  Copyright © 2016 tomfriwel. All rights reserved.
//

#import "ViewController.h"
#import "TouchView.h"

@interface ViewController () <ForceTouchDelegate>

@property (weak, nonatomic) IBOutlet TouchView *touchView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.touchView.forceTouchDelegate = self;
}

-(void)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ForceTouchDelegate

-(void)forceDidChanged:(CGFloat)force {
    
}

-(void)forceTouchBecomeMaximum {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor grayColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    [vc.view addSubview:button];
    
    
    vc.transitioningDelegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)forceTouchDidCanceled {
    
}


@end
