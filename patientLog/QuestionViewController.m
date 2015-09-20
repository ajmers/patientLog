//
//  QuestionViewController.m
//  patientLog
//
//  Created by Anne Maiale on 9/19/15.
//  Copyright (c) 2015 Anne Maiale. All rights reserved.
//

#import "QuestionViewController.h"
#import "ConfirmationViewController.h"
#import "AppDelegate.h"
#import "DateViewController.h"
#import "CoreDataStack.h"
#import "PLpatient.h"

@interface QuestionViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic) CGFloat top;
@property (weak, nonatomic) NSString *question;
@property (weak, nonatomic) IBOutlet UILabel *lastPatientTimeLabel;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_currentIndex == nil) {
        _currentIndex = 0;
    }
    
    NSString *question = [self.questions objectAtIndex:_currentIndex];
    _question = question;
    [_label setText:question];
    
    
    NSDictionary *questionsDictionary = [UIAppDelegate questions];
    NSArray *values = [questionsDictionary valueForKey:question];
    
    [self createButtonsForValues:values];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self setLastSavedLabel];
}

- (void) createButtonsForValues:(NSArray*)values {
    _top = 200;
    for (NSString *answer in values) {
        UIButton *button = [[UIButton alloc] init];
        CGSize stringsize = [answer sizeWithFont:[UIFont systemFontOfSize:30]];
        [button setFrame:CGRectMake(40,_top,300,stringsize.height *1.5)];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 15.0;
        [button setBackgroundColor:[UIColor colorWithRed:0.80 green:1.00 blue:0.80 alpha:1.0]];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitle:answer forState:UIControlStateNormal];
        [button addTarget:self
                     action:@selector(buttonWasPressed:)
           forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        _top += 70;
    }
}

- (void)setLastSavedLabel {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]]];
    NSString *formattedDate = [dateFormatter stringFromDate:_lastPatientTime];
    
    _lastPatientTimeLabel.text = formattedDate;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
- (IBAction)buttonWasPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSString *value = button.titleLabel.text;
    PLpatient *patient = self.patient;
    [patient setPrimitiveValue:value forKey:_question];
    
    if (_currentIndex >= [_questions count] - 1) {
        [patient setDate:[NSDate date]];
        ConfirmationViewController *confirmation = [self.storyboard instantiateViewControllerWithIdentifier:@"Confirmation"];
        [confirmation setPatient:patient];
        [confirmation setQuestions: _questions];
        [self.navigationController pushViewController:confirmation animated:YES];
    } else if ([[_questions objectAtIndex:_currentIndex + 1] isEqualToString:@"date"]) {
        DateViewController *dateView = [self.storyboard instantiateViewControllerWithIdentifier:@"Date"];
        [dateView setPatient:patient];
        [dateView setQuestions:_questions];
        [dateView setCurrentIndex:_currentIndex + 1];
        [self.navigationController pushViewController:dateView animated:YES];
    } else {
        QuestionViewController *nextQuestion = [self.storyboard instantiateViewControllerWithIdentifier:@"Question"];
        [nextQuestion setCurrentIndex:_currentIndex + 1];
        [nextQuestion setPatient:patient];
        [self.navigationController pushViewController:nextQuestion animated:YES];
    }
}

@end
