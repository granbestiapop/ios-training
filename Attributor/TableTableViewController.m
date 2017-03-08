//
//  TableTableViewController.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/6/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "TableTableViewController.h"
#import "imaginariumViewController.h"
#import "Recommendation+CoreDataClass.h"
#import "Recommendation+operations.h"
#import "AppDelegate.h"

@interface TableTableViewController ()
@end

@implementation TableTableViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error;
    
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    //[self fetchRecommendations];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.recommendations count];
    id  sectionInfo =
    [[self.fetchedResultsController sections] objectAtIndex:section];
    NSLog(@"rows %lu", [sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendations_table" forIndexPath:indexPath];
    
    Recommendation * rec = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = rec.desc;
    cell.detailTextLabel.text = rec.price;

    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        id rec = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:rec];
        [self.managedObjectContext save:NULL];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // instrospection
    if([sender isKindOfClass: [UITableViewCell class]]){
        NSIndexPath * path = [self.tableView indexPathForCell:sender];
        imaginariumViewController * ivc = (imaginariumViewController *) segue.destinationViewController;
        
        NSDictionary * recommendation = self.recommendations[path.item];
        NSString *imageUrl = [recommendation valueForKey:@"thumbnail"];
        ivc.imageUrl= [NSURL URLWithString:imageUrl];
    }
}


- (IBAction)refresh:(UIRefreshControl *)sender
{
    //[self.refreshControl beginRefreshing];
    [self fetchRecommendations];
    
}

- (void) fetchRecommendations
{
    // animation
    [self.refreshControl beginRefreshing];

    NSURL *url = [NSURL URLWithString: @"https://frontend.mercadolibre.com/recommendations/users/235789175?client=feedback_congrats&site_id=MLA&category_id=MLA1402&limit=10"];

    
    // create queue
    dispatch_queue_t queue = dispatch_queue_create("json_response", NULL);
    dispatch_async(queue, ^{
        NSData *jsonResult = [NSData dataWithContentsOfURL:url];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonResult options:0 error:NULL];
        
        // this dispatch job async
        dispatch_async(dispatch_get_main_queue(), ^{
            // strong
            self.recommendations = [dic valueForKeyPath:@"recommendation_info.recommendations"];
            [self clearRecommendations];
            [self storeOnLocalDatabase: self.recommendations];
            NSLog(@"%@", self.recommendations);
            [self.refreshControl endRefreshing];
        });
    });

}

- (void) storeOnLocalDatabase: (NSArray *) recommendations
{
    for(NSDictionary *r in recommendations){
        [Recommendation store:r:self.managedObjectContext];
    }
}

- (void) clearRecommendations
{
    
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Recommendation" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"desc" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    
    [fetchRequest setFetchBatchSize:20];
    
    _fetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:nil];
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
    
}

- (NSManagedObjectContext*)managedObjectContext
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    _managedObjectContext = [appDelegate managedObjectContext];
    return _managedObjectContext;
}


#pragma mark - Config
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Recommendation *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = info.description;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}


@end
