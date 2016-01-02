//
//  SSFacebookSessionDetails.m
//  SteerSafe
//
//  Created by IIFM on 25/03/15.
//  Copyright (c) 2015 in.firefish. All rights reserved.
//

#import "SSFacebookSessionDetails.h"

@implementation SSFacebookSessionDetails

static NSString *gender;

// What does the compiler creates for you?
// A getter that by default has the same name as your variable

// A setter that by default is called "set" + "Var" (your variable name with first letter in uppercase)
-(void)setGenderValue:(NSString *)setGender
{
   
    
    gender = setGender;
}


-(NSString *)getGender{
    
 
    
    return gender;
    
}


@end
