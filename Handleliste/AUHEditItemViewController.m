//
//  AUHEditItemViewController.m
//  Handleliste
//
//  Created by Annette Undheim on 16/01/14.
//  Copyright (c) 2014 Annette Undheim. All rights reserved.
//

#import "AUHEditItemViewController.h"
#import "AUHItem.h"

@interface AUHEditItemViewController ()

@property AUHItem *item;
@property (weak) id<AUHEditItemViewControllerDelegate> delegate;

@end

@implementation AUHEditItemViewController

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

/**
 initWithItem
 */
- (id)initWithItem:(AUHItem *)item andDelegate:(id<AUHEditItemViewControllerDelegate>)delegate{
    self = [super initWithNibName:@"AUHEditItemViewController" bundle:nil];
    if (self){
        
        // set item
        self.item = item;
        
        // set delegate
        [self setDelegate:delegate];
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
    
    // create the save button
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    [[self navigationItem] setRightBarButtonItem:saveButtonItem];
    
    // set text field
    if ([self item]){
        [[self nameTextField] setText:[[self item] Name]];
    }
}

/**
 viewDidAppear
 */
- (void)viewDidAppear:(BOOL)animated{
    
    // set cursor focus in textfield
    [[self nameTextField] becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Actions
/**
 save
 */
- (IBAction)save:(id)sender{
    
    NSString *name = [[self nameTextField] text];
    
    // update item
    [[self item] setName:name];
    
    // notify delegate
    [[self delegate] controller:self didUpdateItem:[self item]];
    
    // pop view controller
    [[self navigationController] popViewControllerAnimated:YES];
    
}

















@end
