//
//  ViewController.m
//  runningLed
//
//  Created by Hoàng Thái on 12/15/15.
//  Copyright © 2015 HOANGTHAI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat _margin;
    CGFloat _ballDiameter;
    int _numberOfBall;
    NSTimer* _timer;
    int lastOnLed;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _margin = 40.0;
    _ballDiameter = 24.0;
    _numberOfBall = 8;
    lastOnLed = -1;
    
    [self drawRowBalls:_numberOfBall];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(runningLed) userInfo:nil repeats:true];
}

- (void) runningLed {
    if (lastOnLed != -1) {
        [self turnOFFLed:lastOnLed];
    }
    if (lastOnLed != _numberOfBall - 1) {
        lastOnLed++;
    }
    else {
        lastOnLed = 0;
    }
    [self turnONLed:lastOnLed];
}

- (void) turnONLed: (int) index {
    UIView* view = [self.view viewWithTag:index +100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"green"];
    }
}

- (void) turnOFFLed: (int) index {
    UIView* view = [self.view viewWithTag:index +100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"blue"];
    }
}

- (void) placeGrayBallAtX: (CGFloat) x 
                     andY: (CGFloat) y 
                  withTag: (CGFloat) tag
{
    UIImageView* ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview:ball];
}

- (CGFloat) spaceBetweenBallCenterWhenNumberOfBallIsKnown: (int) n {
    return (self.view.bounds.size.width - 2 * _margin) / (n - 1);
}


- (void) numberOfBallsVSSpace {
    bool stop = false;
    int n = 3;
    while (!stop) {
        CGFloat space = [self spaceBetweenBallCenterWhenNumberOfBallIsKnown: n];
        if (space < _ballDiameter) {
            stop = true;
        }
        else {
            NSLog(@"Number of balls: %d and space between balls: %3.0f", n, space);
        }
        n++;
    }
}

- (void) drawRowBalls: (int) numberBalls {
    CGFloat space = [self spaceBetweenBallCenterWhenNumberOfBallIsKnown:numberBalls];
    for(int i = 0; i < numberBalls; i++) {
        [self placeGrayBallAtX:_margin + i * space
                          andY:140
                       withTag:i + 100];
    }
}

@end
