//
//  QuestionViewController.h
//  patientLog
//
//  Created by Anne Maiale on 9/19/15.
//  Copyright (c) 2015 Anne Maiale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLpatient.h"

@interface QuestionViewController : UIViewController

@property (nonatomic, strong) NSArray *questions;
@property (nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) PLpatient *patient;
@property (strong, nonatomic) NSDate *lastPatientTime;

@end
