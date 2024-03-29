//
//  AUHItem.h
//  Handleliste
//
//  Created by Annette Undheim on 10/01/14.
//  Copyright (c) 2014 Annette Undheim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AUHItem : NSObject<NSCoding>

+ (AUHItem *)createItemWithName:(NSString *)name andShop:(NSString *)shop;

@property NSString *uuid;
@property NSString *Name;
@property NSString *Shop;
@property BOOL isChecked;

@end
