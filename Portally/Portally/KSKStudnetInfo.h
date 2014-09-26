//
//  KSKStudnetInfo.h
//  Portally
//
//  Created by Mohmmad Reza Taesiri on 9/22/14.
//  Copyright (c) 2014 taesiri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSKStudent.h"

@interface KSKStudnetInfo : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *ulName;
@property (strong, nonatomic) IBOutlet UILabel *ulId;
@property (strong, nonatomic) IBOutlet UILabel *ulDegree;
@property (strong, nonatomic) IBOutlet UILabel *ulStatus;
@property (strong, nonatomic) IBOutlet UILabel *ulKRank;
@property (strong, nonatomic) IBOutlet UILabel *ulDepartment;
@property (strong, nonatomic) IBOutlet UILabel *ulGPE;
@property (strong, nonatomic) IBOutlet UILabel *ulCCP;
@property (strong, nonatomic) IBOutlet UILabel *ulCCT;
@property (strong, nonatomic) IBOutlet UIImageView *ivStudentImage;

@property KSKStudent* currentStudent;

@end
