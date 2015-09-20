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
    [self createButtonsForValue:@"Continue"];
    
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

- (void) createButtonsForValue:(NSString*)value {
    CGFloat top = 200;
    
    UIButton *button = [[UIButton alloc] init];
    CGSize stringsize = [value sizeWithFont:[UIFont systemFontOfSize:30]];
    [button setFrame:CGRectMake(40,top,stringsize.width,stringsize.height)];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 15.0;
    [button setBackgroundColor:[UIColor colorWithRed:0.80 green:1.00 blue:0.80 alpha:1.0]];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitle:value forState:UIControlStateNormal];
    [button addTarget:self
                 action:@selector(continueWasPressed:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (IBAction)continueWasPressed:(id)sender {
   
    NSDate *date = _date.date;
    [_patient setDate:date];
    
    if (_currentIndex >= [_questions count] - 1) {
        ConfirmationViewController *confirmation = [self.storyboard instantiateViewControllerWithIdentifier:@"Confirmation"];
        [confirmation setPatient:_patient];
        [confirmation setQuestions: _questions];
        [self.navigationController pushViewController:confirmation animated:YES];
    } else {
        QuestionViewController *nextQuestion = [self.storyboard instantiateViewControllerWithIdentifier:@"Question"];
        [nextQuestion setCurrentIndex:_currentIndex + 1];
        [nextQuestion setQuestions: _questions];
        [nextQuestion setPatient:_patient];
        [self.navigationController pushViewController:nextQuestion animated:YES];
    }
}

@end
