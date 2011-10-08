//
//  TipCalculatorViewController.h
//  TipCalculator
//
//  Created by Erik LaManna on 10/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipCalculatorViewController : UIViewController <UITextFieldDelegate>
{
    UITextField *billAmountTextField;
    UISegmentedControl *tipSegmentedControl;
    UITextField *tipPercentageTextField;
    UITextField *splitTextField;
    UILabel *totalBillAmountLabel;
}

- (void) calculateTip;

@end
