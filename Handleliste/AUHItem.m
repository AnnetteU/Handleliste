//
//  AUHItem.m
//  Handleliste
//
//  Created by Annette Undheim on 10/01/14.
//  Copyright (c) 2014 Annette Undheim. All rights reserved.
//

#import "AUHItem.h"

@implementation AUHItem

#pragma mark -
#pragma mark NSCoding Protocol Methods
/**
 encodeWithCoder
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.uuid forKey:@"uuid"];
    [aCoder encodeObject:self.Name forKey:@"name"];
    [aCoder encodeBool:self.isChecked forKey:@"isChecked"];
    [aCoder encodeBool:self.inShoppingList forKey:@"inShoppingList"];
}

/**
 initWithCoder
 */
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self){
        [self setUuid:[aDecoder decodeObjectForKey:@"uuid"]];
        [self setName:[aDecoder decodeObjectForKey:@"name"]];
        [self setIsChecked:[aDecoder decodeBoolForKey:@"isCheched"]];
        [self setInShoppingList:[aDecoder decodeBoolForKey:@"inShoppingList"]];
    }
    return self;
}

#pragma mark -
#pragma mark Class Methods
/**
 *createItemWithName
 *@param name Name of shopping item
 */
+ (AUHItem *)createItemWithName:(NSString *)name{
    
    // initialize item
    AUHItem *item = [[AUHItem alloc] init];
    
    // configure item
    [item setName:name];
    [item setIsChecked:NO];
    [item setInShoppingList:NO];
    [item setUuid:[[NSUUID UUID] UUIDString]];
    return item;
}

@end
