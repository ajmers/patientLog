//
//  ConfirmationViewController.m
//  patientLog
//
//  Created by Anne Maiale on 9/19/15.
//  Copyright (c) 2015 Anne Maiale. All rights reserved.
//

#import "ConfirmationViewController.h"
#import "PLpatient.h"
#import "CoreDataStack.h"

@interface ConfirmationViewController ()


@end

@implementation ConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setContentInset:UIEdgeInsetsMake(50,0,0,0)];
    
    [self createButtonWithText:@"Submit"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    UILabel *keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 22, 140, 20)];
    UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 22, 140, 20)];
    // Configure the cell...
    NSString *key = [_questions objectAtIndex:indexPath.row];
    NSString *value = [_patient valueForKey:key];

    keyLabel.text = key;
    valueLabel.textAlignment = UITextAlignmentRight;
    if (![key isEqualToString:@"date"]) {
        valueLabel.text = value;
    } else {
        NSString *formattedDate = [self currentDateStringFromDate:value withFormat:@"M-dd-yyyy"];
        valueLabel.text = formattedDate;
    }
    
    [cell.contentView addSubview:keyLabel];
    [cell.contentView addSubview:valueLabel];
    
    return cell;
}

- (NSString *)currentDateStringFromDate:(NSDate *)dateTimeInLine withFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:dateFormat];
    
    NSString *convertedString = [formatter stringFromDate:dateTimeInLine];
    
    return convertedString;
}

- (void) createButtonWithText:(NSString*)text {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
    
    CGFloat top = 10;
        
    UIButton *button = [[UIButton alloc] init];
    CGSize stringsize = [text sizeWithFont:[UIFont systemFontOfSize:30]];
    [button setFrame:CGRectMake(40,top,stringsize.width,stringsize.height)];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 15.0;
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:self
                   action:@selector(submitWasPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    
    [headerView addSubview:button];
    
    [self.tableView setTableHeaderView:headerView];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)submitWasPressed:(id)sender {
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [coreDataStack saveContext];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
