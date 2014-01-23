//
//  AUHShoppingListViewController.m
//  Handleliste
//
//  Created by Annette Undheim on 19/01/14.
//  Copyright (c) 2014 Annette Undheim. All rights reserved.
//

#import "AUHShoppingListViewController.h"
#import "AUHItem.h"

@interface AUHShoppingListViewController ()

@property (nonatomic) NSArray *items;
@property (nonatomic) NSArray *shoppingList;

@end

@implementation AUHShoppingListViewController

#pragma mark -
#pragma mark Initialization
/**
 initWithStyle
 */
- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        
        // set title
        [self setTitle:@"Handleliste handlet"];
        
        // load items
        [self loadItems];
        
        // add observer
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateShoppingList:)
                                                     name:@"AUHShoppingListDidChangeNotification" object:nil];
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
}

/**
 didReceiveMemoryWarning
 */
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Setters and Getters
/**
 setItems
 */
- (void)setItems:(NSArray *)items{
    if (_items != items){
        _items = items;
        
        // build shopping list
        [self buildShoppingList];
    }
}

/**
 setShoppingList
 */
- (void)setShoppingList:(NSArray *)shoppingList{
    if (_shoppingList != shoppingList){
        _shoppingList = shoppingList;
        
        // reload the table view
        [[self tableView] reloadData];
    }
}

#pragma mark -
#pragma mark - Table view data source
/**
 numberOfSectionsInTableView
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

/**
 tableView numberOfRowsInSection
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return [[self shoppingList] count];
}

/**
 tableView cellForRowAtIndex
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // fetch item
    AUHItem *item = [[self shoppingList] objectAtIndex:[indexPath row]];
    
    // configure cell
    [[cell textLabel] setText:[item Name]];
    
    return cell;
}

/**
 tableView didSelectRowAtIndexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{}

#pragma mark -
#pragma mark Notification Handling
- (void)updateShoppingList:(NSNotification *)notification{
    [self loadItems];
}


#pragma mark -
#pragma mark Helper methods
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
 buildShoppingList
 */
- (void)buildShoppingList{
    NSMutableArray *buffer = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [[self items] count]; i++){
        AUHItem *item = [[self items] objectAtIndex:i];
        if ([item inShoppingList]){
            
            // add item to buffer
            [buffer addObject:item];
        }
    }
    
    // set shopping list
    self.shoppingList = [NSArray arrayWithArray:buffer];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[self items] count] - [[self shoppingList] count]];
}

/**
 pathForItems
 */
- (NSString *)pathForItems{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths lastObject];
    return [documents stringByAppendingPathComponent:@"items.plist"];
}



@end
