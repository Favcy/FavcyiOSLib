//
// Copyright 2012 Jeff Verkoeyen
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "AppDelegate.h"
//#import <FacebookSDK/FacebookSDK.h>
@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc {
  [_window release];

  [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

  // Just to prove that we can use code from the Serenity framework.
 // Widget* widget = [[[Widget alloc] init] autorelease];
 // UIImage* image = widget.image;
 // UIImageView* imageView = [[[UIImageView alloc] initWithImage:image] autorelease];
 // [self.window addSubview:imageView];
//
 // self.window.backgroundColor = [UIColor whiteColor];
 // [self.window makeKeyAndVisible];
   //[FBLoginView class];

  /* NSString *path = [[NSBundle mainBundle] pathForResource:@"Serenity" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    [FavcyViewController class];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Storyboard" bundle:bundle];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"fviewcontroller"];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
NSLog(@"Login WillAppear ");*/

    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Serenity" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    [FavcyViewController class];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SampleStoryboard" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"sampleboard"];
    
     UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:vc];
       self.window.rootViewController=navController;

    
    NSLog(@"Login did load %@%@", self, vc);

    [self.window makeKeyAndVisible];

    
  return YES;}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation

{
    
    NSLog ( @"application openURL");
    NSLog ( @"URL = %@", url);
    NSLog ( @"Application = %@", sourceApplication);
    
    
    
    // Call FBAppCall's ha
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    NSLog(@"Login WillAppear ");
    
    return wasHandled;
}




@end
