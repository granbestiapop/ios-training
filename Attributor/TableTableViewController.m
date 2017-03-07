//
//  TableTableViewController.m
//  Attributor
//
//  Created by Leonardo Clavijo on 3/6/17.
//  Copyright © 2017 Leonardo Clavijo. All rights reserved.
//

#import "TableTableViewController.h"
#import "imaginariumViewController.h"

@interface TableTableViewController ()

@end

@implementation TableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchRecommendations];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.recommendations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendations_table" forIndexPath:indexPath];
    
    NSDictionary * recommendation = self.recommendations[indexPath.row];
    cell.textLabel.text = [recommendation valueForKey:@"description"];
    cell.detailTextLabel.text = [recommendation valueForKey:@"price"];
    
    return cell;
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
            NSLog(@"%@", self.recommendations);
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        });
    });

}


@end
