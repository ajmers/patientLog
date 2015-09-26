//
//  QuestionViewController.h
//  patientLog
//
//  Created by Anne Maiale on 9/19/15.
//  Copyright (c) 2015 Anne Maiale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLpatient.h"
#import "InputViewController.h"

@interface QuestionViewController : InputViewController

@property (strong, nonatomic) NSDate *lastPatientTime;

@end
