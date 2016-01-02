//
//  VerifyContoller.h
//  SteerSafe
//
//  Created by IIFM on 07/10/15.
//  Copyright (c) 2015 in.firefish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "FavcySignup.h"

@interface VerifyContoller : UIViewController <UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITextField *favcyemail;
@property (strong, nonatomic) IBOutlet UITextField *favcymobile;

- (IBAction)getVerification:(id)sender;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@property (strong,nonatomic) NSString *favcyfirstname;
@property (strong,nonatomic) NSString *favcylastname;
@property (strong,nonatomic) NSString *favcyfullname;
@property (strong,nonatomic) NSString *favcy_email;
@property (strong,nonatomic) NSString *favcyapp_id;
@property (strong,nonatomic) NSString *favcyapp_secret;
@property (strong,nonatomic) NSString *favcyloginStatus;
@property (strong,nonatomic) NSString *favcyuid;
@property (strong,nonatomic) NSString *favcymobileno;

@property (assign) BOOL callverify;
@property (retain, nonatomic) IBOutlet UIImageView *favcyprofileimage;

@property(nonatomic,assign)id favcyverifydelegate;

-(void)callSignup;
-(void)e;
-(void)sendDataToB:(NSDictionary *)array; 
-(BOOL) NSStringIsValidEmail:(NSString *)checkString;
-(BOOL) NSStringIsValidMobile:(NSString *)mobile;

@end
