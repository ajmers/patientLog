//
//  DateViewController.h
//  patientLog
//
//  Created by Anne Maiale on 9/19/15.
//  Copyright (c) 2015 Anne Maiale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLpatient.h"

@interface DateViewController : UIViewController

@property (strong, nonatomic) PLpatient *patient;
@property (strong, nonatomic) NSArray *questions;
@property (nonatomic) NSInteger currentIndex;

@end
