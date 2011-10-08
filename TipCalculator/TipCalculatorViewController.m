//
//  TipCalculatorViewController.m
//  TipCalculator
//
//  Created by Erik LaManna on 10/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TipCalculatorViewController.h"

@implementation TipCalculatorViewController

- (void) dealloc
{
    [billAmountTextField release];
    [tipPercentageTextField release];
    [tipSegmentedControl release];
    [splitTextField release];
    [totalBillAmountLabel release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] 
                                    initWithFrame:[UIScreen mainScreen].applicationFrame];
    CGFloat width = [UIScreen mainScreen].applicationFrame.size.width;
    mainScrollView.contentSize = CGSizeMake(width, 500);

    // Bill amount text field setup
    UILabel *billAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 100, 21)];
    [billAmountLabel setText:@"Bill Amount"];
    [billAmountLabel setBackgroundColor:[UIColor clearColor]];
    [billAmountLabel setTextColor:[UIColor whiteColor]];
    [mainScrollView addSubview:billAmountLabel];
    [billAmountLabel release];
    
    billAmountTextField = [[UITextField alloc] 
                           initWithFrame:CGRectMake(CGRectGetMaxX(billAmountLabel.frame), 0, 100, 24)];
    
    [billAmountTextField setPlaceholder:@"$0.00"];
    billAmountTextField.text = @"$15.00";
    billAmountTextField.borderStyle = UITextBorderStyleNone;
    [billAmountTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [billAmountTextField setTextColor:[UIColor lightTextColor]];
    [billAmountTextField setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    [billAmountTextField setDelegate:self];   
    [mainScrollView addSubview:billAmountTextField];
    
    // Tip Percent text field setup
    UILabel *tipPercentageLabel = [[UILabel alloc] 
                                   initWithFrame:CGRectMake(10, CGRectGetMaxY(billAmountTextField.frame) + 10, 100, 21)];
    [tipPercentageLabel setText:@"Percentage"];
    [tipPercentageLabel setBackgroundColor:[UIColor clearColor]];
    [tipPercentageLabel setTextColor:[UIColor whiteColor]];
    [mainScrollView addSubview:tipPercentageLabel];
    [tipPercentageLabel release];
    
    tipPercentageTextField = [[UITextField alloc] 
                              initWithFrame:CGRectMake(CGRectGetMaxX(tipPercentageLabel.frame), 
                                                       tipPercentageLabel.frame.origin.y, 100, 24)];
    
    [tipPercentageTextField setPlaceholder:@"15%"];
    [tipPercentageTextField setText:@"15%"];
    tipPercentageTextField.borderStyle = UITextBorderStyleNone;
    [tipPercentageTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [tipPercentageTextField setTextColor:[UIColor lightTextColor]];
    [tipPercentageTextField setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    [tipPercentageTextField setDelegate:self];
    [mainScrollView addSubview:tipPercentageTextField];
    
    // Tip selection segment control setup
    NSArray *tipItems = [NSArray arrayWithObjects:@"10%", @"15%", @"20%", @"Custom", nil];
    tipSegmentedControl = [[UISegmentedControl alloc] initWithItems:tipItems];
    tipSegmentedControl.frame = 
        CGRectMake(10, CGRectGetMaxY(tipPercentageLabel.frame) + 10, 
                   CGRectGetMaxX(self.view.frame) - 20, 31);
    tipSegmentedControl.backgroundColor = [UIColor clearColor];
    tipSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    tipSegmentedControl.tintColor = [UIColor darkGrayColor];
    tipSegmentedControl.selectedSegmentIndex = 1;
    tipPercentageTextField.text = @"15%";
    tipPercentageTextField.enabled = NO;
    [tipSegmentedControl addTarget:self action:@selector(changeTipPercentage:)
                         forControlEvents:UIControlEventValueChanged];
    
    [mainScrollView addSubview:tipSegmentedControl];

    UILabel *splitLabel = [[UILabel alloc] 
                           initWithFrame:CGRectMake(10, 
                                                    CGRectGetMaxY(tipSegmentedControl.frame) + 10, 
                                                    100, 21)];
    [splitLabel setText:@"Split"];
    [splitLabel setBackgroundColor:[UIColor clearColor]];
    [splitLabel setTextColor:[UIColor whiteColor]];
    [mainScrollView addSubview:splitLabel];
    [splitLabel release];
    
    // Split text field for applying the split.
    splitTextField = [[UITextField alloc] 
                      initWithFrame:CGRectMake(CGRectGetMaxX(splitLabel.frame), 
                                               splitLabel.frame.origin.y, 100, 24)];
    
    [splitTextField setPlaceholder:@"1"];
    splitTextField.borderStyle = UITextBorderStyleNone;
    [splitTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [splitTextField setTextColor:[UIColor lightTextColor]];
    [splitTextField setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    [splitTextField setDelegate:self];
    [mainScrollView addSubview:splitTextField];

    UILabel *totalLabel = [[UILabel alloc] 
                           initWithFrame:CGRectMake(10, CGRectGetMaxY(splitLabel.frame) + 20, 100, 21)];
    [totalLabel setText:@"Total"];
    [totalLabel setBackgroundColor:[UIColor clearColor]];
    [totalLabel setTextColor:[UIColor whiteColor]];
    [mainScrollView addSubview:totalLabel];
    [totalLabel release];
    
    totalBillAmountLabel = [[UILabel alloc] 
                            initWithFrame:CGRectMake(CGRectGetMaxX(totalLabel.frame), 
                                                     totalLabel.frame.origin.y, 200, 21)];
    [self calculateTip];
    [totalBillAmountLabel setBackgroundColor:[UIColor clearColor]];
    [totalBillAmountLabel setTextColor:[UIColor whiteColor]];
    [mainScrollView addSubview:totalBillAmountLabel];

    [self.view addSubview: mainScrollView]; 
    [mainScrollView release];
}


- (void)viewDidUnload
{
    // Release view resources
    [billAmountTextField release];
    [tipPercentageTextField release];
    [tipSegmentedControl release];
    [splitTextField release];
    [totalBillAmountLabel release];
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Validate text field input
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL allowReplace = YES;
    
    // Keep $ symbol and only allow digits and . chars.
    if (textField == billAmountTextField)
    {
        if (range.location == 0)
        {
            allowReplace = NO;
        }
        else if (string.length != 0)
        {
            if (range.location > 2 && ([billAmountTextField.text characterAtIndex:(range.location - 3)] == '.') && (string.length != 0))
            {
                allowReplace = NO;
            }
            else
            {
                NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
            
                allowReplace = ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0);
            }
            
        }
    }
    // Only allow numerals in percentage and split fields.
    else if ((textField == tipPercentageTextField) || (textField == splitTextField))
    {
        if (string.length != 0)
        {
            NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
                
            allowReplace = ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0);
        }
    }
    
    return allowReplace;
}

// Format the fields for editing
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == billAmountTextField)
    {
        billAmountTextField.text = [NSString stringWithFormat:@"$%.02f", [[billAmountTextField.text substringFromIndex:1] floatValue]];
    }
    else if (textField == tipPercentageTextField)
    {
        // Trim percentage or set to empty string
        NSString *tipString = [tipPercentageTextField.text stringByReplacingOccurrencesOfString:@"%" withString:@""];
        if (tipString.length > 0)
        {
            tipPercentageTextField.text = [NSString stringWithFormat:@"%d", [tipString intValue]];
        }
        else
        {
            tipPercentageTextField.text = @"";
        }
    }
    
    return YES;
}

// Format text after editing
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField == billAmountTextField)
    {
        billAmountTextField.text = [NSString stringWithFormat:@"$%.02f", [[billAmountTextField.text substringFromIndex:1] floatValue]];
    }
    else if (textField == tipPercentageTextField)
    {
        tipPercentageTextField.text = [NSString stringWithFormat:@"%d%%", 
                                       [tipPercentageTextField.text intValue]];    
    }
    else if (textField == splitTextField)
    {
        // Default split to 1.
        if ((splitTextField.text.length == 0) || ([splitTextField.text intValue] <= 0))
        {
            splitTextField.text = @"1";
        }
    }
    [self calculateTip];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self calculateTip];
    return YES;
}

- (void) calculateTip
{
    float amount = 0.00;
    float percent = 0.00;
    int split = 1;
    
    NSString *billAmountString = [billAmountTextField.text substringFromIndex:1];
    if (billAmountString.length > 0)
    {
        amount = [[billAmountTextField.text substringFromIndex:1] floatValue];
    }
    
    if (tipPercentageTextField.text.length > 0)
    {
        NSString *tipPercentString = [tipPercentageTextField.text 
                                      substringToIndex:(tipPercentageTextField.text.length - 1)];
        if (tipPercentString.length > 0)
        {
            percent = [tipPercentString intValue] / 100.0;
        }
    }
    
    if (splitTextField.text.length > 0)
    {
        split = [splitTextField.text intValue];
        
        // sanity check 
        if (split <= 0)
        {
            split = 1;
        }
    }
  
    float totalWithTip = amount + (amount * percent);
    if (split > 1)
    {
        totalBillAmountLabel.text = [NSString stringWithFormat:@"$%.02f ($%.02f each)", totalWithTip, (totalWithTip / split)];
    }
    else
    {
        totalBillAmountLabel.text = [NSString stringWithFormat:@"$%.02f", totalWithTip];
    }
}

- (void) changeTipPercentage:(id)sender
{
    switch(tipSegmentedControl.selectedSegmentIndex)
    {
        case 0:
            tipPercentageTextField.text = @"10%";
            [tipPercentageTextField setEnabled:NO];
            break;
            
        case 1:
            tipPercentageTextField.text = @"15%";
            [tipPercentageTextField setEnabled:NO];
            break;
            
        case 2:
            tipPercentageTextField.text = @"20%";
            [tipPercentageTextField setEnabled:NO];
            break;
            
        case 3:
            tipPercentageTextField.text = @"";
            [tipPercentageTextField setEnabled:YES];
            [tipPercentageTextField becomeFirstResponder];
            break;
            
        default:
            break;
    }
    
    [self calculateTip];
}

@end
