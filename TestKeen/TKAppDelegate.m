//
//  TKAppDelegate.m
//  TestKeen
//
//  Created by Kiptoo Magutt on 8/19/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "TKAppDelegate.h"
#import "KeenClient.h"

@implementation TKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSLog(@"app did launch");
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
    
    UIBackgroundTaskIdentifier taskId = [application beginBackgroundTaskWithExpirationHandler:^(void) {
        NSLog(@"Background task is being expired.");
    }];
    
    [[KeenClient sharedClient] uploadWithFinishedBlock:^(void) {
        [application endBackgroundTask:taskId];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"app will enter fgnd");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"app did active");
    [KeenClient sharedClientWithProjectId:@"53f38953e861701ba5000000"
                              andWriteKey:@"fd116dc5fe2f2ed24f37b69a8260bf4653385389a9c9169e889152c44ed1bb9dead9bb06d351260e44c020770559ffabc19df6f39b94321d59e2b7152acb161886b4255d9ae33cead5ecb9e3ccc8d8819f7694b45450170626b6d13083ffe8292de81a9f0df397dab2780f715bc49128"
                               andReadKey:@"8c2693ff603f2df43d7b2386ce799c94ae4a5fe345ba7fc5c9a51730ce236ba02a297d01072847062bc49264c60256e637a1176fb48131046d9fad4d4eb8963e4353b66e18ceb5021718d555289692ed3a649bae02668dc0b1c719e9deca3e9f206829cdde8b9f32c7607415aed6e0b8"];
    [KeenClient enableLogging];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
