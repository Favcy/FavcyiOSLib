//
//  FavcySignup.h
//  SteerSafe
//
//  Created by IIFM on 10/10/15.
//  Copyright (c) 2015 in.firefish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleProtocol.h"
#import "VerifyContoller.h"


@interface FavcySignup : UIViewController <UITextFieldDelegate>


@property (retain, nonatomic) IBOutlet UIImageView *favcyprofile;
@property (strong, nonatomic) IBOutlet UITextField *favcyVerification;


- (IBAction)favcySignup:(id)sender;
@property (strong,nonatomic) NSString *favcysignupfirstname;
@property (strong,nonatomic) NSString *favcysignuplastname;
@property (strong,nonatomic) NSString *favcysignupfullname;
@property (strong,nonatomic) NSString *favcysignup_email;
@property (strong,nonatomic) NSString *favcysignup;
@property (strong,nonatomic) NSString *favcysignuploginStatus;
@property (strong,nonatomic) NSString *favcysignupuid;
@property (strong,nonatomic) NSString *favcysignupmobileno;
@property (strong,nonatomic) NSString *favcyapp_id;
@property (strong,nonatomic) NSString *favcyapp_secret;
@property (strong,nonatomic) NSString *favcysignup_mobile;
@property(nonatomic,assign)id favcydelegate;

-(void)callBackFunction:(NSDictionary *)favcyresponse;
-(void)sendDataToA:(NSDictionary *)array;

@end
