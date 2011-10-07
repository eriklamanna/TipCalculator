//
//  TipCalculatorViewController.h
//  TipCalculator
//
//  Created by Erik LaManna on 10/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipCalculatorViewController : UIViewController
{
    UITextField *billAmountTextField;
    UITextField *tipPercentageTextField;
    UITextField *splitTextField;
    UILabel *totalBillAmountLabel;
}

- (NSString*) calculateTip;
@end
