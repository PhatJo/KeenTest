//
//  TKViewController.m
//  TestKeen
//
//  Created by Kiptoo Magutt on 8/19/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "TKViewController.h"
#import "KeenClient.h"

@interface TKViewController ()

@end

@implementation TKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"view did load");
    
    // We want to track page view event only once
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logPageView)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void) logPageView
{
    NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:@"some view", @"view_name", @"going to", @"action", nil];
    [[KeenClient sharedClient] addEvent:event toEventCollection:@"page_views" error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
