//
//  AppDelegate.m
//  patientLog
//
//  Created by Anne Maiale on 9/19/15.
//  Copyright (c) 2015 Anne Maiale. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _questions = self.questions;
    self.window.backgroundColor = [UIColor colorWithRed:0.980f green:0.749f blue:0.478f alpha:1.00f];
    
    NSError *error = nil;
    
    NSDictionary *dict = [AppDelegate dictionaryWithContentsOfJSONString:@"patientLogConfig.json"];
    
    return YES;
}

+(NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileLocation{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileLocation stringByDeletingPathExtension] ofType:@"JSON"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    // Be careful here. You add this as a category to NSDictionary
    // but you get an id back, which means that result
    // might be an NSArray as well!
    if (error != nil) return nil;
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


- (NSDictionary *)questions
{
    if (_questions== nil)
    {
        NSArray *genders = @[@"male", @"female"];
        NSArray *ages = @[@"<10", @">60", @"Other"];
        NSArray *diagnoses = @[@"joint pain", @"ob-gyn", @"gastrointestinal"];
        _questions = [[NSMutableDictionary alloc] init];
        [_questions setValue:genders forKey:@"gender"];
        [_questions setValue:ages forKey:@"age"];
        [_questions setValue:diagnoses forKey:@"diagnosis"];
        [_questions setValue:[NSDate date] forKey:@"date"];
    }
    
    return _questions;
}

@end
