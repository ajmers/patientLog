//
//  AppDelegate.h
//  patientLog
//
//  Created by Anne Maiale on 9/19/15.
//  Copyright (c) 2015 Anne Maiale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

#define UIAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSDictionary *questions;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

