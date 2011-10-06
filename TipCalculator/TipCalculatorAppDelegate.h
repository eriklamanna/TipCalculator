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

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TipCalculatorViewController *viewController;

@end
