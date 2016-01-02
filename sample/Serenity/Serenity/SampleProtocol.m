//
//  SampleProtocol.m
//  Serenity
//
//  Created by IIFM on 27/10/15.
//  Copyright (c) 2015 Google. All rights reserved.
//

#import "SampleProtocol.h"


@implementation SampleProtocol
-(void)startSampleProcess : (UINavigationController*)navigation  withCurrentViewController:(UIViewController*) controller

{
    
    //[NSTimer scheduledTimerWithTimeInterval:3.0 target:self.delegate
                                 //  selector:@selector(processCompleted) userInfo:nil repeats:NO];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Serenity" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    
    
    
    

    FavcyViewController *wc = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:bundle]instantiateViewControllerWithIdentifier:@"fviewcontroller"];
    
    
    
    
    
    NSLog(@"LOAD %@%@", controller, navigation);
    
    
    //[navigation dismissViewControllerAnimated:NO completion:nil];
  //[navigation presentViewController:wc animated:YES];
    [navigation pushViewController:wc animated:YES];
  //  MyAppDelegate *appDelegate = (MyAppDelegate *)[[UIApplication sharedApplication] delegate];
    //[appDelegate.navigationController pushViewController:regViewController animated:YES];
    
    //[UIApplication sharedApplication] delegate]

    
  //  [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController //presentViewController:wc animated:YES];
    
  
    //[[UIApplication sharedApplication].keyWindow.rootViewController.navigationController presentViewController:wc animated:YES completion:NULL];
    
   

    
    NSLog(@"LOAD");
}
@end