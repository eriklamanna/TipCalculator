//
//  TipCalculatorViewController.m
//  TipCalculator
//
//  Created by Erik LaManna on 10/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TipCalculatorViewController.h"

@implementation TipCalculatorViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame]; 

    UILabel *billAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 100, 21)];
    [billAmountLabel setText:@"Bill Amount"];
    [billAmountLabel setBackgroundColor:[UIColor clearColor]];
    [billAmountLabel setTextColor:[UIColor whiteColor]];
    [mainScrollView addSubview:billAmountLabel];
    [billAmountLabel release];
    
    billAmountTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(billAmountLabel.frame), 0, 100, 24)];
    
    [billAmountTextField setPlaceholder:@"15.00"];
    billAmountTextField.borderStyle = UITextBorderStyleNone;
    [billAmountTextField setKeyboardType:UIKeyboardTypeDecimalPad];
    [billAmountTextField setTextColor:[UIColor lightTextColor]];
    [billAmountTextField setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    [mainScrollView addSubview:billAmountTextField];
    
    UILabel *tipPercentageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(billAmountTextField.frame) + 10, 100, 21)];
    [tipPercentageLabel setText:@"Percentage"];
    [tipPercentageLabel setBackgroundColor:[UIColor clearColor]];
    [tipPercentageLabel setTextColor:[UIColor whiteColor]];
    [mainScrollView addSubview:tipPercentageLabel];
    [tipPercentageLabel release];
    
    tipPercentageTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(tipPercentageLabel.frame), tipPercentageLabel.frame.origin.y, 100, 24)];
    
    [tipPercentageTextField setPlaceholder:@"15%"];
    tipPercentageTextField.borderStyle = UITextBorderStyleNone;
    [tipPercentageTextField setKeyboardType:UIKeyboardTypeDecimalPad];
    [tipPercentageTextField setTextColor:[UIColor lightTextColor]];
    [tipPercentageTextField setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    [mainScrollView addSubview:tipPercentageTextField];

    UILabel *splitLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(tipPercentageLabel.frame) + 10, 100, 21)];
    [splitLabel setText:@"Split"];
    [splitLabel setBackgroundColor:[UIColor clearColor]];
    [splitLabel setTextColor:[UIColor whiteColor]];
    [mainScrollView addSubview:splitLabel];
    [splitLabel release];
    
    splitTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(splitLabel.frame), splitLabel.frame.origin.y, 100, 24)];
    
    [splitTextField setPlaceholder:@"1"];
    splitTextField.borderStyle = UITextBorderStyleNone;
    [splitTextField setKeyboardType:UIKeyboardTypeDecimalPad];
    [splitTextField setTextColor:[UIColor lightTextColor]];
    [splitTextField setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    [mainScrollView addSubview:splitTextField];

    UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(splitLabel.frame) + 20, 100, 21)];
    [totalLabel setText:@"Total"];
    [totalLabel setBackgroundColor:[UIColor clearColor]];
    [totalLabel setTextColor:[UIColor whiteColor]];
    [mainScrollView addSubview:totalLabel];
    [totalLabel release];
    
    totalBillAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(totalLabel.frame), totalLabel.frame.origin.y, 100, 21)];
    [self calculateTip];
    [totalBillAmountLabel setBackgroundColor:[UIColor clearColor]];
    [totalBillAmountLabel setTextColor:[UIColor whiteColor]];
    [mainScrollView addSubview:totalBillAmountLabel];
    

    [self.view addSubview: mainScrollView]; 
    [mainScrollView release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release view resources
    [billAmountTextField release];
    [tipPercentageTextField release];
    [splitTextField release];
    [totalBillAmountLabel release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) calculateTip
{
    float amount = [billAmountTextField.text floatValue];
    float percent = [tipPercentageTextField.text intValue] / 100.0;
    [totalBillAmountLabel setText:[NSString stringWithFormat:@"$%.02f", (amount + (amount*percent))]];
}
@end
