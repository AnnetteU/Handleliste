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
    
    [self.tableView registerNib:[UINib nibWithNibName:AUHItemCellConstant
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:UITableViewCellIdentifierConstant];

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
    [[cell detailTextLabel] setText:[item Shop]];
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
    [[AUHItemStore sharedStore] saveChanges];
}

/**
 tableView accessoryButtonTappedForRowWithIndexPath
 */
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    // fetch item
    AUHItem *item = [[[AUHItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];
    
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
    
    AUHItem *newItem = [[AUHItemStore sharedStore] createItem:name andShop:shop];
    
    // get last row in table
    int lastRow = [[[AUHItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    // insert new row
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationTop];
    
    // save items
    [[AUHItemStore sharedStore] saveChanges];
    
}

#pragma mark -
#pragma mark Edit Item View Controller Delegate methods
/**
 controller didUpdateItem
 */
- (void)controller:(AUHEditItemViewController *)controller didUpdateItem:(AUHItem *)item{
    
    // fetch item
    for (int i = 0; i < [[[AUHItemStore sharedStore] allItems] count]; i++){
        AUHItem *updateItem = [[[AUHItemStore sharedStore] allItems] objectAtIndex:i];
        if ([[updateItem uuid] isEqualToString:[item uuid]]){
            
            // update table view row
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [[self tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    
    // save items
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

















@end
