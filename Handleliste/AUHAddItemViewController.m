//
//  AUHAddItemViewController.m
//  Handleliste
//
//  Created by Annette Undheim on 13/01/14.
//  Copyright (c) 2014 Annette Undheim. All rights reserved.
//

#import "AUHAddItemViewController.h"

@interface AUHAddItemViewController ()

@end

@implementation AUHAddItemViewController

#pragma mark -
#pragma mark Initialization
/**
 initWithNibName
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark View Life Cycle
/**
 viewDidLoad
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/**
 didReceiveMemoryWarning
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Actions

/**
 cancel
 */
- (IBAction)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 save
 */
- (IBAction)save:(id)sender{
    
    // extract user input
    NSString *name = [self.nameTextField text];
    
    // notify delegate
    [self.delegate controller:self didSaveItemWithName:name];
    
    // dismiss the view contoller
    [self dismissViewControllerAnimated:YES completion:nil];
}



















@end
