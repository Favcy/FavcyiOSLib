//
//  FavcyViewController.h
//  Serenity
//
//  Created by IIFM on 26/10/15.
//  Copyright (c) 2015 Google. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "VerifyContoller.h"

@protocol senddataProtocol <NSObject>

-(void)sendDataToA:(NSDictionary *) favcyresponse;

@end

@interface FavcyViewController : UIViewController  <FBLoginViewDelegate>
@property (retain, nonatomic) IBOutlet FBLoginView *fblogin;
@property(nonatomic,assign)id delegate;
@property (retain,nonatomic) NSString *favcyapp_id;
@property (retain,nonatomic) NSString *favcyapp_secret;

@property (retain, nonatomic) IBOutlet UIImageView *grouplogo;

-(void)makeTransition;
-(void)getGroupInfo;
@end
