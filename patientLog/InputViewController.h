//
//  InputViewController.h
//  patientLog
//
//  Created by Anne Maiale on 9/23/15.
//  Copyright (c) 2015 Anne Maiale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLpatient.h"

@interface InputViewController : UIViewController

@property (nonatomic, strong) NSArray *questions;
@property (nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) PLpatient *patient;
@property (weak, nonatomic) NSString *question;
@property (weak, nonatomic) IBOutlet UILabel *lastPatientViewLabel;
@property (strong, nonatomic) NSDate *lastPatientTime;

-(UIButton*)createButtonWithText:(NSString*)text:(CGFloat)top:(BOOL)assignButton;
-(void)displayNextView;

@end
