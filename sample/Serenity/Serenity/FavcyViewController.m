//
//  FavcyViewController.m
//  Serenity
//
//  Created by IIFM on 26/10/15.
//  Copyright (c) 2015 Google. All rights reserved.
//

#import "FavcyViewController.h"
#import "SSFacebookSessionDetails.h"
#import "Reachability.h"

@interface FavcyViewController () 

@end

@implementation FavcyViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject *favcy_id = [prefs objectForKey:@"favcy_member"];
    
    if(favcy_id != nil){
        //object is there
        
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
        NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:@"favcy_email"];
        NSString *pic = [[NSUserDefaults standardUserDefaults] objectForKey:@"profile_pic"];
        NSDictionary *favcyres = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"name",  email, @"email",   pic, @"profile_pic",  favcy_id , @"favcy_member", nil];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [delegate sendDataToA:favcyres];
        
        
    }else {
        
    
    [FBSettings setDefaultAppID:@"625178694184501"];
    NSDictionary *infoList = [[NSBundle mainBundle]infoDictionary];
    NSDictionary *urlScheme=[[infoList valueForKey:@"CFBundleURLTypes"] objectAtIndex:0];
    NSLog(@"url scheme before:%@",urlScheme);
    
    [urlScheme setValue:[NSArray arrayWithObject:@"fb625178694184501"] forKey:@"CFBundleURLSchemes"];
    
    NSLog(@"url scheme after:%@",urlScheme);
    
    
    NSLog(@"LOAD%@", self.navigationController);
    
    //UIColor* mainColor = [UIColor colorWithRed:249.0/255 green:223.0/255 blue:244.0/255 alpha:1.0f];
    
    //UIColor* mainColor = [UIColor colorWithRed:84.0/255 green:110.0/255 blue:122.0/255 alpha:1.0f];
   
    
    // [self.navigationController presentModalViewController:passcodeNavigationController animated:YES];
    
    
    //[[self navigationController] setNavigationBarHidden:YES animated:YES];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-no-blur.png"]];
    //UIColor* darkColor = [UIColor colorWithRed:62.0/255 green:28.0/255 blue:55.0/255 alpha:1.0f];
    
    //UIColor* darkColor = [UIColor colorWithRed:129.0/255 green:212.0/255 blue:250.0/255 alpha:1.0f];
    
   
    
/*
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"ThirdParty-Info.plist"]; //3
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSLog(@"url scheme after:%@",path);

    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"ThirdParty-Info" ofType:@"plist"]; //5

        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
        NSLog(@"url scheme after:%@",path);


    }else {
        
        NSLog(@"url scheme after:%@",path);

    }
    
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    //here add elements to data file and write data to file
    
    [data setObject:[NSArray arrayWithObject:@"fb625178694184501"] forKey:@"CFBundleURLSchemes"];
    
    [data writeToFile: path atomically:YES];
    [data release];
    
    
    */
    
    
    
   

    
    
    FBLoginView *fblogin = [[FBLoginView alloc] init];
    fblogin.readPermissions = @[@"public_profile",@"email"];
      //fblogin.
    //FBLoginView *fblogin = [[FBLoginView alloc] init];

    fblogin.delegate = self;
        [self  getGroupInfo];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
     NSLog(@"LOAD");
    
}




-(void)loginViewFetchedUserInfo:(FBLoginView *)fblogin user:(id<FBGraphUser>)user{
    
    
    NSLog(@"user id %@",user);
    NSLog(@"user id %@",user.name);
     NSLog(@"Email %@",[user objectForKey:@"email"]);
     NSLog(@"User Name %@",user.username);
    
    //EXIT_SUCCESS;
    
    NSLog(@"Email %@",[[NSUserDefaults standardUserDefaults] stringForKey:@"session_email"]);
    
    if (user.objectID) {
        
        NSInteger data_saved = 0;
        
        
        
        NSLog(@"User Name %@",user.name);
        
        
        
        NSString *fb_firstname = [user objectForKey:@"first_name"];
        NSString *fb_lastname = [user objectForKey:@"last_name"];
        NSString *fb_ID = user.objectID;
        NSString *fb_Email = [user objectForKey:@"email"];
        NSString *fb_name = user.name;
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSString *ud_FirstName = fb_firstname;
        NSString *ud_LastName = fb_lastname;
        NSString *ud_FullName = fb_name;
        NSString *ud_ImagePath = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture", fb_ID];
        NSString *ud_Email = fb_Email;
        NSString *ud_UID = fb_ID;
        
        
        [[NSUserDefaults standardUserDefaults] setObject:ud_FirstName forKey:@"session_fname"];
        [[NSUserDefaults standardUserDefaults] setObject:ud_LastName forKey:@"session_lname"];
        [[NSUserDefaults standardUserDefaults] setObject:ud_FullName forKey:@"session_fullname"];
        [[NSUserDefaults standardUserDefaults] setObject:ud_ImagePath forKey:@"session_img"];
        [[NSUserDefaults standardUserDefaults] setObject:ud_Email forKey:@"session_email"];
        [[NSUserDefaults standardUserDefaults] setObject:ud_UID forKey:@"session_uid"];
         NSString *valueToSave = @"true";
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"loggedIn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self makeTransition];
        
        
        
        
        
        
    }else {
        
        
        
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sign in Failed!"
                                  message:@"Login Cancelled"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}


-(void)makeTransition{
    
    
   
    NSLog(@"User Name segue");
  //  [self.navigationController popViewControllerAnimated:YES];

    
    
   
 //  [self performSegueWithIdentifier:@"verifyfavcy" sender:self];
    
    
    
   // VerifyContoller *viewController = [[VerifyContoller alloc] init];
    
    
    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Storyboard" bundle:bundle];
  //  VerifyContoller *vc = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:bundle] instantiateViewControllerWithIdentifier:@"fviewcontroller"];
    //[self presentViewController:viewController animated:YES completion:nil];
    
    
    
    //[self performSegueWithIdentifier:@"home" sender:Nil];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Serenity" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];

    
   VerifyContoller *wc = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:bundle]instantiateViewControllerWithIdentifier:@"verifyContoller"];
  //  NSLog(@"LOAD %@%@", wc, self.navigationController);
    wc.favcyverifydelegate=self;
    wc.favcyapp_id=_favcyapp_id;
    wc.favcyapp_secret=_favcyapp_secret;
    [self presentViewController:wc animated:YES completion:nil];
    //[self dismissViewControllerAnimated:NO completion:nil];

  //  [self.parentViewController.navigationController  pushViewController:wc animated:YES];

    
}


-(void)loginViewShowingLoggedInUser:(FBLoginView *)fblogin{
    
    
    
    NSLog(@"Loggd In %@",fblogin);
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)fblogin{
    
    NSLog(@"Loggd Out");
    
    
}



-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"Login DisAppear ");
    
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"Login WillAppear ");
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSObject *favcy_id = [prefs objectForKey:@"favcy_member"];
    
    NSLog(@"url scheme after:%@",favcy_id);
    
    if(favcy_id != nil){
        //object is there
        
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
        NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:@"favcy_email"];
        NSString *pic = [[NSUserDefaults standardUserDefaults] objectForKey:@"profile_pic"];
        NSDictionary *favcyres = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"name",  email, @"email",   pic, @"profile_pic",  favcy_id , @"favcy_member", nil];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [delegate sendDataToA:favcyres];
        
        
    }

}


-(void)sendDataToB:(NSDictionary *) favcyresponse
{
    // data will come here inside of ViewControllerA
    
    
    
    NSLog(@"return from framwork1 Login did load %@", favcyresponse);
    
    [delegate sendDataToA:favcyresponse];

    [self dismissViewControllerAnimated:NO completion:nil];
    
    
}


- (void)loginView:(FBLoginView *)fblogin handleError:(NSError *)error
{
    NSString *alertMessage, *alertTitle;
    
    if ([FBErrorUtility shouldNotifyUserForError:error])
    {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
    }
    else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession)
    {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
    }
    else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled)
    {
        NSLog(@"user cancelled login");
        
    }
    else
    {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage)
    {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}


-(void)getGroupInfo{
    
    
     NSLog(@"getgroupinfo");
    NSString *post =[[NSString alloc] initWithFormat:@"app_id=%@",self.favcyapp_id];
    NSURL *url=[NSURL URLWithString:@"http://www.favcy.com/favcy-rest/v1/groupdata"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSLog(@"getgroupinfo1");
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSLog(@"getgroupinfo2");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSLog(@"getgroupinfo3");
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request addValue:_favcyapp_id forHTTPHeaderField:@"app_id"];
    [request addValue:_favcyapp_secret forHTTPHeaderField:@"app_secret"];
    [request setHTTPBody:postData];
    NSLog(@"getgroupinfo4");
    NSError *errorcode = nil;
    NSLog(@"getgroupinfo5");
    NSHTTPURLResponse *response = nil;
    NSLog(@"getgroupinfo56");
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&errorcode];
    
    if(!urlData){
    NSLog(@"Error: %@", [errorcode localizedDescription]);
        
        
    }
    
    NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"getgroupinfo%@", responseData);
    NSDictionary *jsonData = [NSJSONSerialization
                              JSONObjectWithData:urlData
                              options:NSJSONReadingMutableContainers
                              error:&errorcode];
    NSLog(@"Loggd In %@",jsonData);

    if([jsonData[@"error"]integerValue] == 0)
    {
        
        NSString *gplogo_url = jsonData[@"brand_img"];
        NSString *scaledValue = [NSString stringWithFormat:gplogo_url,80,80];
        NSString *imageUrl = scaledValue;
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            self.grouplogo.image = [UIImage imageWithData:data];
            self.grouplogo.layer.borderWidth = 3.0f;
            self.grouplogo.layer.borderColor = [UIColor whiteColor].CGColor;
            self.grouplogo.layer.cornerRadius = 5.0;
            [self.grouplogo setClipsToBounds:YES];
        }];

        
    }else {
        
        NSString *fmsg=jsonData[@"message"];
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:fmsg
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
        
    }


    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_fblogin release];
    [_grouplogo release];
    [super dealloc];
}
@end
