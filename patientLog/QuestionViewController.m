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

@property (nonatomic) CGFloat top;
@property (weak, nonatomic) IBOutlet UILabel *lastPatientViewLabel;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *questionsDictionary = [UIAppDelegate questions];
    NSArray *values = [questionsDictionary valueForKey:super.question];
    [self createButtonsForValues:values];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self createLastSavedLabel];
}

- (void) createButtonsForValues:(NSArray*)values {
    _top = 200;
    for (NSString *answer in values) {
        [super createButtonWithText:answer:_top:YES];
        _top += 65;
    }
}

- (void)createLastSavedLabel {
    if (super.lastPatientTime != nil) {
        super.lastPatientViewLabel.hidden = NO;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]]];
        NSString *stringPrefix = @"Last entry saved at: ";
        NSString *formattedDate = [dateFormatter stringFromDate:super.lastPatientTime];
        NSString *lastDateString = [stringPrefix stringByAppendingString:formattedDate];
        super.lastPatientViewLabel.text = lastDateString;
    } else {
        super.lastPatientViewLabel.hidden = YES;
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

@end
