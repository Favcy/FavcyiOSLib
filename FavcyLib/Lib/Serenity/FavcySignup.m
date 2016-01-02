//
//  FavcySignup.m
//  SteerSafe
//
//  Created by IIFM on 10/10/15.
//  Copyright (c) 2015 in.firefish. All rights reserved.
//

#import "FavcySignup.h"

@implementation FavcySignup
@synthesize favcydelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
  //  [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    NSLog(@"Signup View Did Load");

    self.favcyVerification.delegate = self;

    
    
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Signup View Will Appear");
    [super viewWillAppear:animated];
    
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_uid"];
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_fullname"];
    NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_email"];
    NSString *fname = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_fname"];
    NSString *lname = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_lname"];
    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggedIn"];
    _favcysignup_mobile=[[NSUserDefaults standardUserDefaults] objectForKey:@"session_mobile"];
    self.favcysignupuid = uid;
    self.favcysignup_email = email;
    _favcysignupfirstname = fname;
    _favcysignuplastname= lname;
    self.favcysignupfullname = name;
    self.favcysignuploginStatus = loginStatus;
    
    NSLog(@"Verify View Will Appear%@",  email);
    NSString *scaledValue = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=%i&height=%i", uid,80,80];
    NSString *imageUrl = scaledValue;
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        self.favcyprofile.image = [UIImage imageWithData:data];
        self.favcyprofile.layer.borderWidth = 3.0f;
        self.favcyprofile.layer.borderColor = [UIColor whiteColor].CGColor;
    }];


}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.favcyVerification) {
        [theTextField resignFirstResponder];
    }
    return YES;
}


-(void)callBackFunction: (NSDictionary *)favcyresponse{
   

    [self dismissViewControllerAnimated:NO completion:^{
        
        
       // NSString *path = [[NSBundle mainBundle] pathForResource:@"Serenity" ofType:@"bundle"];
        //NSBundle *bundle = [NSBundle bundleWithPath:path];
        
       // VerifyContoller *wc = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:bundle]instantiateViewControllerWithIdentifier:@"verifyContoller"];
        //[wc dismissViewControllerAnimated:YES completion:Nil];
        
        
         [favcydelegate sendDataToA:favcyresponse];

    }];

    
    
   
  //  SampleProtocol *sampleProtocol = [[SampleProtocol alloc]init];
  //  sampleProtocol.delegate = self.parentViewController.navigationController;
   // [self.navigationController popViewControllerAnimated:YES];
    
    
    //[self.navigationController popToRootViewControllerAnimated:NO];
    
   //
    //[NSTimer scheduledTimerWithTimeInterval:3.0 target:sampleProtocol.delegate
                                  // selector:@selector(processCompleted) userInfo:nil repeats:NO];
    
}

- (IBAction)favcySignup:(id)sender {
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    [indicator startAnimating];
    
    if(self.favcyVerification.text.length>0) {
    
    NSString *fb_firstname = _favcysignupfirstname;
    NSString *fb_lastname = _favcysignuplastname;
    NSString *fb_ID = _favcysignupuid;
    NSString *fb_Email = _favcysignup_email;
    NSString *fb_name = _favcysignupfullname;
    NSString *verificationcode = self.favcyVerification.text;
    NSString *mobile = _favcysignup_mobile;
    
    NSLog(@"Response code: %@%@", verificationcode, _favcysignup_mobile);
    
        

        
    NSString *post =[[NSString alloc] initWithFormat:@"userid=%@&email=%@&firstname=%@&lastname=%@&name=%@&app_id=%@&mobile=%@&verificationcode=%@",fb_ID,fb_Email,fb_firstname,fb_lastname,fb_name,_favcyapp_id,mobile, verificationcode];
    
    //NSString *post =[[NSString alloc] initWithFormat:@"mobile_number=%@",mobile];
    
    NSURL *url=[NSURL URLWithString:@"http://www.favcy.com/favcy-rest/v1/groupsignup"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request addValue:_favcyapp_id forHTTPHeaderField:@"app_id"];
    [request addValue:_favcyapp_secret forHTTPHeaderField:@"app_secret"];
    [request setHTTPBody:postData];
    
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSError *errorcode = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&errorcode];
    NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSDictionary *jsonData = [NSJSONSerialization
                              JSONObjectWithData:urlData
                              options:NSJSONReadingMutableContainers
                              error:&errorcode];
    
        
        
        
   

    
    if([jsonData[@"error"]integerValue] == 1) {
        
        //NSError *error = nil;
        
        [indicator stopAnimating];

     
        
        NSString *fmsg=jsonData[@"message"];
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Favcy Alert"
                                  message:fmsg
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    else {
        [indicator stopAnimating];
        NSString *fid=jsonData[@"favcy_member"];
        NSString *femail=jsonData[@"email"];
        NSString *fprofilepic=jsonData[@"profile_pic"];
        NSString *fmsg=jsonData[@"message"];
        NSLog(@"Response code: %@%@%@%@",  fid, femail, fprofilepic, fmsg);
        NSLog(@"Signup button click");
        [[NSUserDefaults standardUserDefaults] setObject:jsonData[@"favcy_member"] forKey:@"favcy_member"];
        [[NSUserDefaults standardUserDefaults] setObject:jsonData[@"email"] forKey:@"favcy_email"];
        [[NSUserDefaults standardUserDefaults] setObject:jsonData[@"profile_pic"] forKey:@"profile_pic"];
        [[NSUserDefaults standardUserDefaults] setObject:jsonData[@"name"] forKey:@"name"];
        NSString *valueToSave = @"true";
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"loggedIn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self callBackFunction:jsonData];

    }
    }
    else {
        
        [indicator stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Please Enter Verification Code"
                                  message:@""
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];

        
    }

}
- (void)dealloc {
    [_favcyprofile release];
    [super dealloc];
}
@end
