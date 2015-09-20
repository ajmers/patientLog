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

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
- (IBAction)buttonWasPressed:(id)sender {
   
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
        [nextQuestion setPatient:_patient];
        [self.navigationController pushViewController:nextQuestion animated:YES];
    }
}

@end
