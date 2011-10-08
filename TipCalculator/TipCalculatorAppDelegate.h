//
//  TipCalculatorAppDelegate.h
//  TipCalculator
//
//  Created by Erik LaManna on 10/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TipCalculatorViewController;

@interface TipCalculatorAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *_window;
    TipCalculatorViewController *_viewController;
}

@property (nonatomic, retain) UIWindow *window;

@property (nonatomic, retain) TipCalculatorViewController *viewController;

@end
