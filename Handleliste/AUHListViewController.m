//
//  AUHListViewController.m
//  Handleliste
//
//  Created by Annette Undheim on 10/01/14.
//  Copyright (c) 2014 Annette Undheim. All rights reserved.
//

#import "AUHListViewController.h"
#import "AUHItem.h"
#import "AUHConstants.h"
#import "AUHItemStore.h"

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
        self.title = ApplicationTitleConstant;
        
        // load items
        //[self loadItems];
        [[AUHItemStore sharedStore] loadItems];
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
    
    // edit button
    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    
    // create add button
    UIBarButtonItem *rightbarButtonItem = [[UIBarButtonItem alloc]
                                         initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                         target:self action:@selector(addItem:)];
    [[self navigationItem] setRightBarButtonItem:rightbarButtonItem];
    
    // register reusable cell identifer for the table view
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewCellIdentifierConstant];

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
    return [[[AUHItemStore sharedStore] allItems] count];
}

/**
 cellForRowAtIndexPath
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    // get reusable cell identifier
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellIdentifierConstant forIndexPath:indexPath];
    
    // fetch item
    AUHItem *item = [[[AUHItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];
    
    // configure cell
    [[cell textLabel] setText:[item Name]];
    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    
    // show/hide checkmark
    if ([item isChecked]){
        [[cell imageView] setImage:[UIImage imageNamed:CheckMarkImageConstant]];
    }
    else{
        [[cell imageView] setImage:nil];
    }
    
    return cell;
}


// Override to support conditional editing of the table view.
/**
 tableView canEditRowAtIndexPath
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

/**
 moveRowsAtIndexPath
 Reorder rows
 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [[AUHItemStore sharedStore] moveItemAtIndex:[sourceIndexPath row] toIndex:[destinationIndexPath row]];
}

// Override to support editing the table view.
/**
 tableView commitEditingStyle forRowAtIndexPath
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // delete item from items
        AUHItem *item = [[[AUHItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];
        [[AUHItemStore sharedStore] removeItem:item];
        
        // update the table view
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        // save changes to disk
        //[self saveItems];
        [[AUHItemStore sharedStore] saveChanges];
    }
}

#pragma mark -
#pragma mark Table View Delegate Methods
/**
 tableView didSelectRowAtIndexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Fetch Item
    AUHItem *item = [[self items] objectAtIndex:[indexPath row]];
    
    // Update Item checked status
    [item setIsChecked:![item isChecked]];
    
    // Update Cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([item isChecked]) {
        [[cell imageView] setImage:[UIImage imageNamed:CheckMarkImageConstant]];
    } else {
        [[cell imageView] setImage:nil];
    }
    
    // Save Items
    //[self saveItems];
    [[AUHItemStore sharedStore] saveChanges];
}

/**
 tableView accessoryButtonTappedForRowWithIndexPath
 */
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    // fetch item
    AUHItem *item = [[self items] objectAtIndex:[indexPath row]];
    
    // initialize Edit Item View Controller
    AUHEditItemViewController *editItemViewController = [[AUHEditItemViewController alloc] initWithItem:item andDelegate:self];
    
    // push View Controller onto navigation stack
    [[self navigationController] pushViewController:editItemViewController animated:YES];
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark -
#pragma mark Add Item View Controller Delegate Methods
/**
 controller didSaveItemWithName
 */
- (void)controller:(AUHAddItemViewController *)controller didSaveItemWithName:(NSString *)name andShop:(NSString *)shop{
    
    // create item
    AUHItem *item = [AUHItem createItemWithName:name andShop:shop];
    
    // add item to data source
    [[self items] addObject:item];
    
    // add row to the table view
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:([self.items count] - 1) inSection:0];
    [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    // save items
    //[self saveItems];
    [[AUHItemStore sharedStore] saveChanges];
    
}

#pragma mark -
#pragma mark Edit Item View Controller Delegate methods
/**
 controller didUpdateItem
 */
- (void)controller:(AUHEditItemViewController *)controller didUpdateItem:(AUHItem *)item{
    
    // fetch item
    for (int i = 0; i < [[self items] count]; i++){
        AUHItem *updateItem = [[self items] objectAtIndex:i];
        if ([[updateItem uuid] isEqualToString:[item uuid]]){
            
            // update table view row
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [[self tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    
    // save items
    //[self saveItems];
    [[AUHItemStore sharedStore] saveChanges];
}


#pragma mark -
#pragma mark Actions
/**
 addItem
 */
- (void)addItem:(id)sender{
    
    // initialize add item view controller
    AUHAddItemViewController *addItemViewController = [[AUHAddItemViewController alloc] initWithNibName:AUHAddItemViewControllerConstant bundle:nil];
    
    // set delegate
    [addItemViewController setDelegate:self];
    
    // present view controller
    [self presentViewController:addItemViewController animated:YES completion:nil];
}

/**
 editItem
 */
- (void)editItems:(id)sender{
    [[self tableView] setEditing:![[self tableView] isEditing] animated:YES];
}

///**
// saveItems
// */
//- (void)saveItems{
//    
//    NSString *filePath = [self pathForItems];
//    [NSKeyedArchiver archiveRootObject:[self items] toFile:filePath];
//}


#pragma mark -
#pragma mark Helper Methods
///**
// loadItems
// */
//- (void)loadItems{
//    NSString *filePath = [self pathForItems];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
//        self.items = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//    }
//    else{
//        self.items = [NSMutableArray array];
//    }
//    
//}

///**
// pathForItems
// */
//- (NSString *)pathForItems{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documents = [paths lastObject];
//    return [documents stringByAppendingPathComponent:ApplicationItemsArchiveConstant];
//}
















@end
