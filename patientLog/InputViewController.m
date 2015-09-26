//
//  InputViewController.m
//  patientLog
//
//  Created by Anne Maiale on 9/23/15.
//  Copyright (c) 2015 Anne Maiale. All rights reserved.
//

#import "InputViewController.h"
@class ConfirmationViewController;
@class DateViewController;
@class QuestionViewController;
#import "CoreDataStack.h"
#import "AppDelegate.h"


@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_currentIndex == nil) {
        _currentIndex = 0;
    }

    NSString *question = [self.questions objectAtIndex:_currentIndex];
    _question = question;
   
    [self setTitle:question];
}

- (NSArray *)questions {
    if (_questions == nil) {
        _questions = @[@"age", @"gender", @"diagnosis", @"date"];
        return _questions;
    } else {
        return _questions;
    }
}

- (PLpatient *)patient {
    if (_patient == nil) {
        CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
        PLpatient *patient = [NSEntityDescription insertNewObjectForEntityForName:@"PLpatient"
                                                      inManagedObjectContext:coreDataStack.managedObjectContext];
        return patient;
    } else {
        return _patient;
    }
}

-(UIButton*)createButtonWithText:(NSString*)text:(CGFloat)top:(BOOL)assignButton {
   
    UIView *superview = self.view;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize stringsize = [text sizeWithFont:[UIFont systemFontOfSize:30]];
    [button setFrame:CGRectMake(40,top,300,stringsize.height *1.5)];
    
    [self.view addSubview:button];
    
    UIImage *buttonImg = [UIImage imageNamed:@"iosAssets/bigGreenButton.png"];
    [button setBackgroundImage:buttonImg forState:UIControlStateNormal];
    
    NSLayoutConstraint *myConstraint =[NSLayoutConstraint
                                       constraintWithItem:button
                                       attribute:NSLayoutAttributeCenterY
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:superview
                                       attribute:NSLayoutAttributeCenterY
                                       multiplier:1.0
                                       constant:0];
    [superview addConstraint:myConstraint];
    
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 8.0;
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    if (assignButton) {
        [button addTarget:self
                   action:@selector(valueButtonWasPressed:)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

- (void)createLastSavedLabel {
    if (_lastPatientTime != nil) {
        _lastPatientViewLabel.hidden = NO;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]]];
        NSString *stringPrefix = @"Last entry saved at: ";
        NSString *formattedDate = [dateFormatter stringFromDate:_lastPatientTime];
        NSString *lastDateString = [stringPrefix stringByAppendingString:formattedDate];
        _lastPatientViewLabel.text = lastDateString;
    } else {
        _lastPatientViewLabel.hidden = YES;
    }
}

- (IBAction)valueButtonWasPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSString *value = button.titleLabel.text;
    PLpatient *patient = self.patient;
    [patient setPrimitiveValue:value forKey:_question];
    self.patient = patient;
    [self displayNextView];
}

-(void)displayNextView {

    id nextViewController;
    PLpatient *patient = self.patient;
    
    if (_currentIndex >= [_questions count] - 1) {
        nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Confirmation"];
    } else if ([[_questions objectAtIndex:_currentIndex + 1] isEqualToString:@"date"]) {
        nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Date"];
        [nextViewController setCurrentIndex:_currentIndex + 1];
    } else {
        nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Question"];
        [nextViewController setCurrentIndex:_currentIndex + 1];
    }
    
    [nextViewController setPatient:patient];
    [nextViewController setQuestions: _questions];
    [self.navigationController pushViewController:nextViewController animated:YES];
}

@end
