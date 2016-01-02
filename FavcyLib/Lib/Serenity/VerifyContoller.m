//
//  VerifyContoller.m
//  SteerSafe
//
//  Created by IIFM on 07/10/15.
//  Copyright (c) 2015 in.firefish. All rights reserved.
//

#import "VerifyContoller.h"

@implementation VerifyContoller
@synthesize favcyverifydelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    NSLog(@"verify View Did Load%@", self.navigationController);
    
    

    
    self.favcyemail.delegate = self;
    self.favcymobile.delegate = self;
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    
    
}
-(void)sendDataToA:(NSDictionary *) favcyresponse
{
    // data will come here inside of ViewControllerA
    
    
    

    [self dismissViewControllerAnimated:NO completion:^{
        
        [favcyverifydelegate sendDataToB:favcyresponse];

        // here you can create a code for presetn C viewcontroller
        
    }];


    NSLog(@"return from framwork Login did load %@", favcyresponse);
    
}


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


-(BOOL) NSStringIsValidMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"[235689][0-9]{6}([0-9]{3})?";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL matches = [test evaluateWithObject:mobile];
    return matches;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.favcyemail  || theTextField == self.favcymobile) {
        [theTextField resignFirstResponder];
    }
    return YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Verify View Will Appear");
    
    [super viewWillAppear:animated];
    
    

    
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_uid"];
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_fullname"];
    NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_email"];
    NSString *fname = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_fname"];
    NSString *lname = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_lname"];
    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggedIn"];
    
    self.favcyuid = uid;
    self.favcy_email = email;
    _favcyfirstname = fname;
    _favcylastname= lname;
    self.favcyfullname = name;
    self.favcyloginStatus = loginStatus;


    NSLog(@"Verify View Will Appear%@",  email);
    
    
   self.favcyemail.text =email;
   //self.favcymobile.text =mobile;
    
    NSString *scaledValue = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=%i&height=%i", uid,80,80];
    NSString *imageUrl = scaledValue;
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        self.favcyprofileimage.image = [UIImage imageWithData:data];
        self.favcyprofileimage.layer.borderWidth = 3.0f;
        self.favcyprofileimage.layer.borderColor = [UIColor whiteColor].CGColor;
        self.favcyprofileimage.layer.cornerRadius = 5.0;
        [self.favcyprofileimage setClipsToBounds:YES];
    }];
    
    
    
}









- (IBAction)getVerification:(id)sender {
    
    NSLog(@"Response code: %@", self.favcymobile.text);
    
    if(self.favcymobile.text.length<= 0)
    {
    
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Please enter mobile number"
                                  message:@""
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
       
        
    }else if(self.favcyemail.text.length<= 0) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Please enter valid Email Id"
                                  message:@""
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
        
    }else {
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        indicator.center = self.view.center;
        [self.view addSubview:indicator];
        [indicator bringSubviewToFront:self.view];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
        
        [indicator startAnimating];

        
        if ([self  NSStringIsValidEmail: _favcy_email]  && [self NSStringIsValidMobile:self.favcymobile.text]) {
            
        
        
        
        ///NSString *fb_firstname = _favcyfirstname;
        //NSString *fb_lastname = _favcylastname;
        //NSString *fb_ID = _favcyuid;
        //NSString *fb_Email = _favcy_email;
        //NSString *fb_name = _favcyfullname;
       // NSString *app_id = self.favcyapp_id;
        NSString *mobile = self.favcymobile.text;
        
        
        NSString *post =[[NSString alloc] initWithFormat:@"mobile_number=%@",mobile];
        NSURL *url=[NSURL URLWithString:@"http://www.favcy.com/favcy-rest/v1/verifymobile"];
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
        
        NSError *errorcode = nil;
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&errorcode];
        
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSDictionary *jsonData = [NSJSONSerialization
                                      JSONObjectWithData:urlData
                                      options:NSJSONReadingMutableContainers
                                      error:&errorcode];

        NSLog(@"Response code: %@%@", responseData, _favcyapp_id);
        
        NSLog(@"Verify button click");
        
        //[[NSUserDefaults standardUserDefaults] setObject:fb_firstname forKey:@"session_fname"];
        //[[NSUserDefaults standardUserDefaults] setObject:fb_lastname forKey:@"session_lname"];
        //[[NSUserDefaults standardUserDefaults] setObject:fb_name forKey:@"session_fullname"];
        ////[[NSUserDefaults standardUserDefaults] setObject:fb_Email forKey:@"session_email"];
        //[[NSUserDefaults standardUserDefaults] setObject:fb_ID forKey:@"session_uid"];
        [[NSUserDefaults standardUserDefaults] setObject:mobile forKey:@"session_mobile"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.callverify =true;
        if([jsonData[@"error"]integerValue] == 0)
        {
        
            
            [self callSignup];
            [indicator stopAnimating];

        }else {
            
            NSString *fmsg=jsonData[@"message"];

            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Invalid Email Id or Mobile No"
                                      message:fmsg
                                      delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
            [alertView show];
            [indicator stopAnimating];
            
        }
            
        }else {
            
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Invalid Email Id or Mobile No"
                                      message:@""
                                      delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
            [alertView show];
            [indicator stopAnimating];
        }
  
    }
    
}

-(void)e {
    
    
    
}

-(void)callSignup{
  //  [self.navigationController popViewControllerAnimated:YES];

    
    
      //   [self performSegueWithIdentifier:@"favcysignup" sender:self];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Serenity" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    
    FavcySignup *wc = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:bundle]instantiateViewControllerWithIdentifier:@"favcysignup"];
    wc.favcyapp_id=_favcyapp_id;
    wc.favcyapp_secret=_favcyapp_secret;
    wc.favcydelegate=self;
    [self  presentViewController:wc animated:YES completion:^{
        

        // here you can create a code for presetn C viewcontroller
        
    }];
    
    
    
      //[self dismissViewControllerAnimated:NO completion:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"Verify view dissapear");
}

- (void)dealloc {
    [_favcyprofileimage release];
    [super dealloc];
}
@end
