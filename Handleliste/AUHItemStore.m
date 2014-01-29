//
//  AUHItemStore.m
//  Handleliste
//
//  Store class responsible for handling request logic
//
//  Created by Annette Undheim on 28/01/14.
//  Copyright (c) 2014 Annette Undheim. All rights reserved.
//

#import "AUHItemStore.h"
#import "AUHItem.h"
#import "AUHConstants.h"

@implementation AUHItemStore

#pragma mark - 
#pragma mark Class Methods

/**
 sharedStore
 Create sharedStore singleton
 */
+ (AUHItemStore *)sharedStore{
    static AUHItemStore *sharedStore = nil;
    if (!sharedStore){
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

/**
 allocWithZone
 Added to prevet creation of sharedStore objects
 */
+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedStore];
}

#pragma mark -
#pragma mark Initialization

/**
 init
 Initialise allItems array
 */
- (id)init{
    
    self = [super init];
    if(self) {
        NSString *path = [self itemArchivePath];
        allItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // If the array hadn't been saved previously, create a new empty one
        if(!allItems)
            allItems = [[NSMutableArray alloc] init];
    }
    return self;

}

#pragma mark - 
#pragma mark Actions

/**
 allItems
 */
- (NSArray *)allItems{
    return allItems;
}

/**
 createItem
 */
- (AUHItem *)createItem:(NSString *)name andShop:(NSString *)shop{
    
    AUHItem *item = [AUHItem createItemWithName:name andShop:shop];
    [allItems addObject:item];
    return item;
}

/**
 saveChanges
 */
- (BOOL)saveChanges{
    
    // update badgenumber
    [self setApplicationBadgeNumber];
    
    // returns success or failure
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:allItems toFile:path];
}

/**
 Items
 */
- (void)loadItems{
    
    NSString *path = [self itemArchivePath];
    allItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

/**
 removeItem
 */
- (void)removeItem:(AUHItem *)item{
    [allItems removeObjectIdenticalTo:item];
}

/**
 moveItemAtIndex
 Reorder items
 */
- (void)moveItemAtIndex:(int)from toIndex:(int)to{
    
    if (from == to){
        return;
    }
    
    // get a pointer to object being moved so we can re-insert it
    AUHItem *item = [allItems objectAtIndex:from];
    
    // remove item from array
    [allItems removeObjectAtIndex:from];
    
    // insert item in array at new location
    [allItems insertObject:item atIndex:to];
}

#pragma mark -
#pragma mark Helper Methods

/**
 itemArchivePath
 */
- (NSString *)itemArchivePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths lastObject];
    return [documents stringByAppendingPathComponent:ApplicationItemsArchiveConstant];
}


/**
 numberOfCheckedItems
 */
- (int)numberOfCheckedItems{
    
    int counter = 0;
    for(int i = 0; i < [allItems count]; i++){
        if ([[allItems objectAtIndex:i] isChecked]){
            counter++;
        }
    }
    return counter;
}

/**
 setApplicationBadgeNumber
 */
- (void)setApplicationBadgeNumber{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[allItems count] - [self numberOfCheckedItems]];
}



@end
