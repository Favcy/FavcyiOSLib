//
//  SampleViewController.m
//  ThirdParty
//
//  Created by IIFM on 27/10/15.
//  Copyright (c) 2015 Google. All rights reserved.
//

#import "SampleViewController.h"

@interface SampleViewController ()

@end

@implementation SampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  /* NSString *path = [[NSBundle mainBundle] pathForResource:@"Serenity" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    [FavcyViewController class];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Storyboard" bundle:bundle];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"fviewcontroller"];
    
    
    */
    //  vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
  // self.rootViewController = vc;
    //[self.window makeKeyAndVisible];*/
    NSLog(@"Login did load %@%@", self, self.navigationController);
    
  // SampleProtocol *sampleProtocol = [[SampleProtocol alloc]init];
  //  sampleProtocol.delegate = self;
 //  [self.flabel setText:@"Processing..."];
//[sampleProtocol startSampleProcess];
    
  // [self dismissViewControllerAnimated:NO completion:nil];
    // HomeViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"]; //or the homeController
   
  //  [sampleProtocol startSampleProcess:self.navigationController withCurrentViewController:self];
    
    
   // [self dismissViewControllerAnimated:NO completion:nil];310231
    
    
//[self.navigationController pushViewController:vc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)processCompleted{
   // [self.flabel setText:@"Process Completed"];
    
    NSLog(@"Login did load completed %@%@", self, self.navigationController);

}

- (void)dealloc {
    [_flabel release];
    [super dealloc];
}
- (IBAction)callfavcy:(id)sender {
    
    NSLog(@"Login did load %@%@", self, self.navigationController);
    
    //SampleProtocol *sampleProtocol = [[SampleProtocol alloc]init];
   // sampleProtocol.delegate = self;
   // [self.flabel setText:@"Processing..."];
    //[sampleProtocol startSampleProcess];
    
    //[self dismissViewControllerAnimated:NO completion:nil];
    // HomeViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"]; //or the homeController
    
   // [sampleProtocol startSampleProcess:self.navigationController withCurrentViewController:self];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Serenity" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    [FavcyViewController class];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Storyboard" bundle:bundle];
    FavcyViewController *vc = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:bundle] instantiateViewControllerWithIdentifier:@"fviewcontroller"];
    vc.favcyapp_id = @"438GVZ2C993SFAF";
    vc.favcyapp_secret = @"74S68ET6NKD77UR";

    vc.delegate=self; // protocol listener
   // [self.navigationController pushViewController:vc animated:YES];
  //  NSString *path = [[NSBundle mainBundle] pathForResource:@"Serenity" ofType:@"bundle"];
    
    
    
    
    

    [self presentViewController:vc animated:YES completion:nil];
    

}

-(void)sendDataToA:(NSDictionary *) favcyresponse
{
    // data will come here inside of ViewControllerA
    
    NSLog(@"return from framwork Login did load %@", favcyresponse);

}



@end
