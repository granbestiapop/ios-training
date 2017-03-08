//
//  TableTableViewController.h
//  Attributor
//
//  Created by Leonardo Clavijo on 3/6/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TableTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>
@property(strong, nonatomic) NSArray * recommendations;

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@end
