//
//  AUHListViewController.m
//  Handleliste
//
//  Created by Annette Undheim on 10/01/14.
//  Copyright (c) 2014 Annette Undheim. All rights reserved.
//

#import "AUHListViewController.h"
#import "AUHItem.h"

@interface AUHListViewController ()

@property NSMutableArray *items;

@end

@implementation AUHListViewController

#pragma mark -
#pragma mark Initialization
/**
 initWithStyle
 */
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        // set title
        self.title = @"Handleliste";
        
        // load items
        [self loadItems];
    }
    return self;
}

#pragma mark -
#pragma mark View Life Cycle
/**
 viewDidLoad
 */
- (void)viewDidLoad{
    [super viewDidLoad];
    
    // create add button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                             target:self action:@selector(addItem:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                              target:self action:@selector(editItems:)];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Table View Data Source Methods

/**
 numberOfSectionsInTableView
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

/**
 numberOfRowsInSection
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    // Return the number of rows in the section.
    return [self.items count];
}

/**
 cellForRowAtIndexPath
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // fetch item
    AUHItem *item = [self.items objectAtIndex:[indexPath row]];
    
    // configure cell
    [cell.textLabel setText:[item Name]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


#pragma mark -
#pragma mark Add Item View Controller Delegate Methods
/**
 controller didSaveItemWithName
 */
- (void)controller:(AUHAddItemViewController *)controller didSaveItemWithName:(NSString *)name{
    
    // create item
    AUHItem *item = [AUHItem createItemWithName:name];
    
    // add item to data source
    [self.items addObject:item];
    
    // add row to the table view
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:([self.items count] - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    // save items
    [self saveItems];
    
}

#pragma mark -
#pragma mark Actions
/**
 addItem
 */
- (void)addItem:(id)sender{
    
    // initialize add item view controller
    AUHAddItemViewController *addItemViewController = [[AUHAddItemViewController alloc] initWithNibName:@"AUHAddItemViewController" bundle:nil];
    
    // set delegate
    [addItemViewController setDelegate:self];
    
    // present view controller
    [self presentViewController:addItemViewController animated:YES completion:nil];
}

/**
 editItem
 */
- (void)editItem:(id)sender{
    [self.tableView setEditing:![self.tableView isEditing] animated:YES];
}


#pragma mark -
#pragma mark Helper Methods
/**
 loadItems
 */
- (void)loadItems{
    NSString *filePath = [self pathForItems];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        self.items = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    else{
        self.items = [NSMutableArray array];
    }
    
}

/**
 pathForItems
 */
- (NSString *)pathForItems{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths lastObject];
    return [documents stringByAppendingPathComponent:@"items.plist"];
}

/**
 saveItems
 */
- (void)saveItems{
    NSString *filePath = [self pathForItems];
    [NSKeyedArchiver archiveRootObject:self.items toFile:filePath];
}















@end
