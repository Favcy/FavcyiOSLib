//
//  SampleProtocol.h
//  Serenity
//
//  Created by IIFM on 27/10/15.
//  Copyright (c) 2015 Google. All rights reserved.
//

#import <Foundation/Foundation.h>
// Protocol definition starts here
#import "FavcyViewController.h"

@protocol SampleProtocolDelegate <NSObject>

@required
- (void) processCompleted;
@end
// Protocol Definition ends here
@interface SampleProtocol :  UIViewController

{
    // Delegate to respond back
    id <SampleProtocolDelegate> _delegate;
    
}
@property (nonatomic,strong) id delegate;

- (void)startSampleProcess:(UINavigationController*)navigation  withCurrentViewController:(UIViewController*) controller;

@end