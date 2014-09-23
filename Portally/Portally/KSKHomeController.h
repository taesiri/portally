//
//  KSKHomeController.h
//  Portally
//
//  Created by Mohmmad Reza Taesiri on 9/22/14.
//  Copyright (c) 2014 taesiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSKHomeController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong,nonatomic) NSMutableArray *filteredStudentArray;
@property IBOutlet UISearchBar *stSearchBar;
@end
