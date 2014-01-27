//
//  AUHEditItemViewController.h
//  Handleliste
//
//  Created by Annette Undheim on 16/01/14.
//  Copyright (c) 2014 Annette Undheim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AUHItem;
@protocol AUHEditItemViewControllerDelegate;

@interface AUHEditItemViewController : UIViewController

@property IBOutlet UITextField *nameTextField;
@property IBOutlet UITextField *shopTextField;

#pragma mark -
#pragma mark Initialization
- (id)initWithItem:(AUHItem *)item andDelegate:(id<AUHEditItemViewControllerDelegate>)delegate;

@end

@protocol AUHEditItemViewControllerDelegate <NSObject>
- (void)controller:(AUHEditItemViewController *)controller didUpdateItem:(AUHItem *)item;
@end
