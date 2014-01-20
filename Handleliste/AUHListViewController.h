//
//  AUHListViewController.h
//  Handleliste
//
//  Created by Annette Undheim on 10/01/14.
//  Copyright (c) 2014 Annette Undheim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AUHAddItemViewController.h"
#import "AUHEditItemViewController.h"

@interface AUHListViewController : UITableViewController<AUHAddItemViewControllerDelegate, AUHEditItemViewControllerDelegate>

@end
