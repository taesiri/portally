//
//  KSKStudnetInfo.m
//  Portally
//
//  Created by Mohmmad Reza Taesiri on 9/22/14.
//  Copyright (c) 2014 taesiri. All rights reserved.
//

#import "KSKStudnetInfo.h"

@implementation KSKStudnetInfo


-(void) viewDidLoad {
    [super viewDidLoad];
    
    if(_currentStudent!=nil) {
        _ulName.text = _currentStudent.name;
        _ulDegree.text = _currentStudent.degree;
        _ulKRank.text = _currentStudent.konkurRank;
        _ulDepartment .text = _currentStudent.department;
        _ulStatus.text = _currentStudent.status;
        _ulId.text = _currentStudent.studentId;
        _ulGPE.text = [NSString stringWithFormat:@"%@: %@" , @"GPE ",_currentStudent.gpe];
        _ulCCP.text = [NSString stringWithFormat:@"%@: %@" , @"CCP ",_currentStudent.ccp];
        _ulCCT.text = [NSString stringWithFormat:@"%@: %@" , @"CCT ",_currentStudent.cct];
    }
}

@end
