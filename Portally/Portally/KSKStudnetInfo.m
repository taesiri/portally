//
//  KSKStudnetInfo.m
//  Portally
//
//  Created by Mohmmad Reza Taesiri on 9/22/14.
//  Copyright (c) 2014 taesiri. All rights reserved.
//

#import "KSKStudnetInfo.h"

@interface NSURLRequest (DummyInterface)
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

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
        _ulGPE.text = [NSString stringWithFormat:@"%@: %@" , @"معدل کل ",_currentStudent.gpe];
        _ulCCP.text = [NSString stringWithFormat:@"%@: %@" ,@"واحدهای پاس شده ",_currentStudent.ccp];
        _ulCCT.text = [NSString stringWithFormat:@"%@: %@" , @"واحدهای اخذ شده ",_currentStudent.cct];
        
        
        
        NSString* temp = [_currentStudent.picUrl stringByReplacingOccurrencesOfString:@"../../" withString:@""];
        NSString* IMAGE_URL = [NSString stringWithFormat:@"%@%@", @"https://portal2.aut.ac.ir/aportal/", temp];
        
        
        [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[[NSURL URLWithString:IMAGE_URL] host]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:IMAGE_URL]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if(data != nil){
                _ivStudentImage.image= [UIImage imageWithData:data];
            }}];
        
        
    }
}

@end
