//
//  DateViewController.m
//  patientLog
//
//  Created by Anne Maiale on 9/19/15.
//  Copyright (c) 2015 Anne Maiale. All rights reserved.
//

#import "DateViewController.h"
#import "ConfirmationViewCOntroller.h"
#import "QuestionViewController.h"

@interface DateViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *date;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *superview = self.view;

    [self setTitle:@"date"];
    
    UIButton *button = [super createButtonWithText:@"Continue" :(CGFloat)200:NO];
    [button addTarget:self
            action:@selector(continueWasPressed:)
            forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)continueWasPressed:(id)sender {
   
    NSDate *date = _date.date;
    [super.patient setDate:date];

    [super displayNextView];
}
@end
