//
//  AUHAddItemViewController.h
//  Handleliste
//
//  Created by Annette Undheim on 13/01/14.
//  Copyright (c) 2014 Annette Undheim. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AUHAddItemViewControllerDelegate;
@interface AUHAddItemViewController : UIViewController

@property (weak) id<AUHAddItemViewControllerDelegate> delegate;
@property IBOutlet UITextField *nameTextField;

@end

@protocol AUHAddItemViewControllerDelegate <NSObject>
- (void)controller:(AUHAddItemViewController *)controller didSaveItemWithName:(NSString *)name;
@end


