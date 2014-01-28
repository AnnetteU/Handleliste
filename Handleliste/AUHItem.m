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
    [aCoder encodeObject:self.Shop forKey:@"shop"];
    [aCoder encodeBool:self.isChecked forKey:@"isChecked"];
}

/**
 initWithCoder
 */
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self){
        [self setUuid:[aDecoder decodeObjectForKey:@"uuid"]];
        [self setName:[aDecoder decodeObjectForKey:@"name"]];
        [self setShop:[aDecoder decodeObjectForKey:@"shop"]];
        [self setIsChecked:[aDecoder decodeBoolForKey:@"isCheched"]];
    }
    return self;
}

#pragma mark -
#pragma mark Class Methods
/**
 *createItemWithName
 *@param name Name of shopping item
 */
+ (AUHItem *)createItemWithName:(NSString *)name andShop:(NSString *)shop{
    
    // initialize item
    AUHItem *item = [[AUHItem alloc] init];
    
    // configure item
    [item setName:name];
    [item setShop:shop];
    [item setIsChecked:NO];
    [item setUuid:[[NSUUID UUID] UUIDString]];
    return item;
}

@end
