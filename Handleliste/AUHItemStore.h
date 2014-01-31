//
//  AUHItemStore.h
//  Handleliste
//
//  Created by Annette Undheim on 28/01/14.
//  Copyright (c) 2014 Annette Undheim. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AUHItem;

@interface AUHItemStore : NSObject{
    NSMutableArray *allItems;
}

+ (AUHItemStore *)sharedStore;

- (NSArray *)allItems;
- (AUHItem *)createItem:(NSString *)name andShop:(NSString *)shop;
- (void)removeItem:(AUHItem *)item;
- (void)moveItemAtIndex:(int)from toIndex:(int)to;
- (BOOL)saveChanges;
- (void)loadItems;
- (int)numberOfCheckedItems;
- (void)setApplicationBadgeNumber;
- (NSString *)itemArchivePath;

@end
