//
//  KSKHomeController.m
//  Portally
//
//  Created by Mohmmad Reza Taesiri on 9/22/14.
//  Copyright (c) 2014 taesiri. All rights reserved.
//

#import "KSKHomeController.h"
#import "KSKStudent.h"
#import "KSKStudentCell.h"
#import "KSKStudnetInfo.h"


@implementation KSKHomeController

@synthesize filteredStudentArray;

NSString* DocumentDirectory;

NSMutableArray* allStudents;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    allStudents = [NSMutableArray new];
    [self readData];
    
    self.filteredStudentArray = [NSMutableArray new];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



-(void) readData {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    DocumentDirectory = [paths objectAtIndex:0];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *parsedData = [NSJSONSerialization  JSONObjectWithData:data options:kNilOptions  error:nil];
    
    for (NSDictionary* studentItem in parsedData) {
        
        KSKStudent* newSt = [KSKStudent new];
        newSt.name = studentItem[@"name"];
        newSt.ccp = studentItem[@"ccp"];
        newSt.cct = studentItem[@"cct"];
        newSt.degree = studentItem[@"degree"];
        newSt.department = studentItem[@"department"];
        newSt.gpe = studentItem[@"gpe"];
        newSt.studentId = studentItem[@"id"];
        newSt.konkurRank = studentItem[@"konkurRank"];
        newSt.picUrl = studentItem[@"picUrl"];
        newSt.status = studentItem[@"status"];
        
        [allStudents addObject:newSt];
    }
    
    
    filteredStudentArray = allStudents;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredStudentArray  count];
    }
    return [allStudents  count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CatCellTableIdentifier = @"StudentCellIdentifier";
    
    KSKStudentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CatCellTableIdentifier];
    
    if (cell == nil) {
        cell = [[KSKStudentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CatCellTableIdentifier];
        cell.backgroundColor = [UIColor grayColor];
    }
    
    KSKStudent* student;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if([filteredStudentArray  count] <= indexPath.row) {
            student = [allStudents objectAtIndex:indexPath.row];
        } else {
            
            student = [filteredStudentArray objectAtIndex:indexPath.row];
            [cell textLabel].text = student.studentId;
            
        }
    } else {
        student = [allStudents objectAtIndex:indexPath.row];
    }
    
    [cell stId].text = student.studentId;
    [cell stName].text = student.name;
    
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender   {
    
    if([segue.identifier isEqualToString:@"viewStudentInfoSegue"]) {
        KSKStudnetInfo *controller = (KSKStudnetInfo *) segue.destinationViewController;
        
        KSKStudent* selectedStudent ;
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
       
        if ( index == nil ) {
            index = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            int selectedRow = (int)index.row;
            selectedStudent = [filteredStudentArray objectAtIndex:selectedRow];
        } else {
             int selectedRow = (int)index.row;
             selectedStudent = [allStudents objectAtIndex:selectedRow];
        }
        
        controller.navigationItem.title = selectedStudent.name;
        controller.currentStudent = selectedStudent;
    }
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [filteredStudentArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.studentId contains[c] %@", searchText];
    filteredStudentArray = [NSMutableArray arrayWithArray:[allStudents filteredArrayUsingPredicate:predicate]];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
