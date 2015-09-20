//
//  PLpatient.h
//  patientLog
//
//  Created by Anne Maiale on 9/19/15.
//  Copyright (c) 2015 Anne Maiale. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface PLpatient : NSManagedObject

@property (nonatomic, retain) NSString *age;
@property (nonatomic, retain) NSString *ailment;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSDate *date;

@end
