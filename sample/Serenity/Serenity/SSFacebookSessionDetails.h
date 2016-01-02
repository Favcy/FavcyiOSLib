//
//  SSFacebookSessionDetails.h
//  SteerSafe
//
//  Created by IIFM on 25/03/15.
//  Copyright (c) 2015 in.firefish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSFacebookSessionDetails : NSObject

@property (strong,nonatomic) NSString *firstname;
@property (strong,nonatomic) NSString *lastname;
@property (strong,nonatomic) NSString *fullname;
@property (strong,nonatomic) NSString *gender;


-(NSString *)getGender;
- (void)setGenderValue:(NSString *)setGender;


@end
