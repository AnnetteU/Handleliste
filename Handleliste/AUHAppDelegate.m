//
//  AUHAppDelegate.m
//  Handleliste
//
//  Created by Annette Undheim on 10/01/14.
//  Copyright (c) 2014 Annette Undheim. All rights reserved.
//

#import "AUHAppDelegate.h"

#import "AUHShoppingListViewController.h"
#import "AUHListViewController.h"
#import "AUHItem.h"

@implementation AUHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // seed items
    //[self seedItems];
    
    // Initialize List View Controller
    AUHListViewController *listViewController = [[AUHListViewController alloc] init];
    
    // Initialize Navigation Controller
    UINavigationController *listNavigationController = [[UINavigationController alloc] initWithRootViewController:listViewController];
    
    // Initiliaze Shopping List View Controller
    //AUHShoppingListViewController *shoppingListViewController = [[AUHShoppingListViewController alloc] init];
    
    // Initialize Navigation Controller
    //UINavigationController *shoppingListNavigationController = [[UINavigationController alloc] initWithRootViewController:shoppingListViewController];
    
    // Initialize Tab Bar Controller
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    // Configure Tab Bar Controller
    //[tabBarController setViewControllers:@[listNavigationController, shoppingListNavigationController]];
    [tabBarController setViewControllers:@[listNavigationController]];
    
    // initialize window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // configre window
    [self.window setRootViewController:tabBarController];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//#pragma mark -
//#pragma mark Helper Methods
///**
// seedItems
// */
//- (void)seedItems{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    if (![userDefaults boolForKey:@"AUHUserDefaultsSeedItems"]){
//        
//        // load seed items
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"seed" ofType:@"plist"];
//        NSArray *seedItems = [NSArray arrayWithContentsOfFile:filePath];
//        
//        // items
//        NSMutableArray *items = [NSMutableArray array];
//        
//        // create list of items
//        for (int i = 0; i < [seedItems count]; i++){
//            NSDictionary *seedItem = [seedItems objectAtIndex:i];
//            
//            // create item
//            AUHItem *item = [AUHItem createItemWithName:[seedItem objectForKey:@"name"]];
//            
//            // add item to items
//            [items addObject:item];
//        }
//        
//        // items path
//        NSString *itemsPath = [[self documentsDirectory] stringByAppendingPathComponent:@"items.plist"];
//        
//        // write to file
//        if ([NSKeyedArchiver archiveRootObject:items toFile:itemsPath]){
//            [userDefaults setBool:YES forKey:@"AUHUserDefaultsSeedItems"];
//        }
//    }
//}
//
///**
// documentsDirectory
// */
//- (NSString *)documentsDirectory{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    return [paths lastObject];
//}
//
















@end
