//
//  AppDelegate.m
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/1/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#import <iostream>
#import "AppDelegate.h"
#import "DBManager.h"
#import <curl/curl.h>
#import "CurlTest.h"
#import "W2ViewController1.h"
#import "W2ViewController2.h"
#import "W2ViewController3.h"
#import "W2TableViewController.h"

@interface AppDelegate()

@property (nonatomic, strong)   DBManager   *dbManager;
@property (nonatomic, strong)   NSArray*    arrPeopleInfo;
@property (nonatomic)           int         peopleInfoID;
@property (nonatomic, strong) NSViewController *currentController;
@property (nonatomic)           int         viewIndex;

- (void) loadData;
- (void) loadInfoToEdit;
- (void) updateDetailFields;
- (void) clearDetailFields;
- (void) doCurlTest;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Initialize the dbManager object.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"sampledb.sql"];
//    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ddte-client.sqlite3"];
    // Insert code here to initialize your application
    if (self.tableView) {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self loadData];
        
        // Testing curl methods.
        [self doCurlTest];
    }
    self.recordIDToEdit = -1;
    [self updateDetailFields];
    
    
    self.viewIndex = 0;
    self.currentController = nil;

    // Set to the first view.
    [self goToNextView:nil];
}

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView {
    return self.arrPeopleInfo.count;
}

- (CGFloat) tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 30.0;
    
}

- (void) doCurlTest
{
    CurlTest curl;
    NSLog(@"======= Testing Curl =========");
    
    std::string url = "http://jsonplaceholder.typicode.com/posts";
    std::string data = "\"data\": {\"title\": \"foo2\", \"body\": \"bar\", \"userId\": 1}";
    data = "{ \"suspects\": [ { \"/Return/ReturnData/IRSW2[@uuid='aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee']/EmployersUseGrp[EmployersUseCd='B']/EmployersUseAmt\":\"100\" }], \"requiredInputs\": [{ \"/Return/ReturnData/IRSW2[@uuid='aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee']/EmployersUseGrp[EmployersUseCd='A']/EmployersUseAmt\": \"500\", \"/Return/ReturnData/IRSW2[@uuid='aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee']/WagesAmt\": \"45000\" }]}";
    
//    url = "http://cnn.com";
//    url = "http://api.ddte.corp.intuit.net/v1/listtestfields";
    url = "http://api.ddte.corp.intuit.net/v1/errorcheck";

    //    if (curly.Fetch("http://www.dahu.co.uk") == CURLE_OK){
//    if (curl.Fetch("http://www.cnn.com") == CURLE_OK){
    if (curl.Post(url, &data) == CURLE_OK){
        
        std::cout << "status: " << curl.HttpStatus() << std::endl;
        std::cout << "type: " << curl.Type() << std::endl;
        std::vector<std::string> headers = curl.Headers();
        
        for(std::vector<std::string>::iterator it = headers.begin();
            it != headers.end(); it++)
            std::cout << "Header: " << (*it) << std::endl;
        
        std::cout << "Content:\n" << curl.Content() << std::endl;
    }
    
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row NS_AVAILABLE_MAC(10_7);
{
    // NSTableCellView is added to the tableView in Interface Builder.
    NSTableCellView *result = [tableView makeViewWithIdentifier:@"kTableCellID" owner:self];
    
    NSInteger indexOfFirstname =  [self.dbManager.arrColumnNames indexOfObject:@"firstname"];
    NSInteger indexOfLastname = [self.dbManager.arrColumnNames indexOfObject:@"lastname"];
    NSInteger indexOfAge= [self.dbManager.arrColumnNames indexOfObject:@"age"];
    NSInteger indexOfPeopleInfoID = [self.dbManager.arrColumnNames indexOfObject:@"peopleInfoID"];
    
    NSString *firstname = [[self.arrPeopleInfo objectAtIndex:row] objectAtIndex:indexOfFirstname];
    NSString *lastname = [[self.arrPeopleInfo objectAtIndex:row] objectAtIndex:indexOfLastname];
    NSString *age = [[self.arrPeopleInfo objectAtIndex:row] objectAtIndex:indexOfAge];
    NSString *infoID = [[self.arrPeopleInfo objectAtIndex:row] objectAtIndex:indexOfPeopleInfoID];
    
    result.textField.stringValue = [NSString stringWithFormat:@"%@ %@ %@ %@", firstname, lastname, age, infoID];

    return result;
}

// Insert or update the record.
- (IBAction) saveRecord:(id)sender {
    NSLog(@"Firstname = %@", self.firstName.stringValue);
    NSLog(@"lastName = %@", self.lastName.stringValue);
    NSLog(@"age = %@", self.age.stringValue);
    
    [self loadData];
    
    NSString *query;

    // Prepare the query string.
    if (self.recordIDToEdit == -1) {
        query = [NSString stringWithFormat:@"insert into peopleInfo values(null, '%@', '%@', %d)",
                 self.firstName.stringValue,
                 self.lastName.stringValue,
                 [self.age.stringValue intValue]];
    }
    else {
        query = [NSString stringWithFormat:@"update peopleInfo set firstname='%@', lastname='%@', age=%d where peopleInfoID=%d",
                 self.firstName.stringValue,
                 self.lastName.stringValue,
                 self.age.intValue,
                 self.recordIDToEdit];
    }

    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        [self loadData];
    }
    else{
        NSLog(@"Could not execute the query.");
    }
}

// Set the detailed fieds to empty strings.
- (void) clearDetailFields {
    self.recordIDToEdit = -1;
    self.firstName.stringValue = @"";
    self.lastName.stringValue = @"";
    self.age.stringValue = @"";
}

// Prepare detailed fields for new record.
- (IBAction) prepareNewRecord:(id)sender {
    [self clearDetailFields];
    [self updateDetailFields];
    
    // Reload the table to unselect the selection.
    [self loadData];
}

// Delete the selected record.
- (IBAction) deleteRecord:(id)sender {
    // Prepare the query.
    NSString *query = [NSString stringWithFormat:@"delete from peopleInfo where peopleInfoID=%d", self.recordIDToEdit];
    
    // Execute query.
    [self.dbManager executeQuery:query];
    
    // Clear the detailed fields.
    [self clearDetailFields];
    
    // Reload the table view.
    [self loadData];
    [self updateDetailFields];
}

- (void) setNextViewController:(BOOL) goToNext
{
    // Remvoe the existing view controller.
    if ([self.currentController view] != nil)
    {
        [[self.currentController view] removeFromSuperview];	// remove the current view
        self.currentController = nil;   // Release the current view controller.
    }
    
    // Go to the next index.
    if(goToNext) {
        _viewIndex++;
        _viewIndex = _viewIndex % 4;
    }
    
    switch (self.viewIndex) {
        case 0:
            _currentController = [[W2ViewController1 alloc] initWithNibName:@"W2ViewController1" bundle:nil];
            break;
            
        case 1:
            _currentController = [[W2ViewController2 alloc] initWithNibName:@"W2ViewController2" bundle:nil];
            break;
            
        case 2:
            _currentController = [[W2ViewController3 alloc] initWithNibName:@"W2ViewController3" bundle:nil];
            break;
            
        case 3:
            _currentController = [[W2TableViewController alloc] initWithNibName:@"W2TableViewController" bundle:nil];
            break;

        default:
            _currentController = nil;
            NSLog(@"Ivalid view controller is called");
            break;
    }
}

- (IBAction) goToNextView:(id)sender {
    BOOL goToNext = YES;
    if (sender == nil) {
        goToNext = NO;
    }
    [self setNextViewController:goToNext];
    NSRect rect = CGRectMake(600, 50, 400, 300);
    [self.currentController.view setFrame:rect];
    [self.window.contentView addSubview:self.currentController.view];
}

// Load the table data.
- (void) loadData {
    // Form the query.
    NSString *query = @"select * from peopleInfo";
//    NSString *query = @"select * from age_stats";
    
    // Get the results.
    if (self.arrPeopleInfo != nil) {
        self.arrPeopleInfo = nil;
    }
    self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the tale view.
    [self.tableView reloadData];
}

// Load the selected data to the detailed fields.
- (void) loadInfoToEdit {
    // Create a query.
    NSString *query = [NSString stringWithFormat:@"select * from poepeleInfo where peopleInfoID=%d", self.recordIDToEdit];
    
    // Load the relevant data.
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Set the loaded data to the text fields.
    self.firstName.stringValue = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"firstname"]];
    self.lastName.stringValue = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"lastname"]];
    self.age.stringValue = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"age"]];
}

// Update the buttons and texts in detailed fields.
- (void) updateDetailFields
{
    [self.firstName needsDisplay];
    [self.lastName needsDisplay];
    [self.age needsDisplay];
    
    if (self.recordIDToEdit == -1) {
        self.saveButton.title = @"Add";
    }
    else {
        self.saveButton.title = @"Update";
    }
    [self.saveButton needsDisplay];
}

- (void) tableViewSelectionDidChange:(NSNotification *)notification {
    NSTableView *aTableView = notification.object;
    NSInteger selectedRow = aTableView.selectedRow;
    
    NSInteger indexOfFirstname =  [self.dbManager.arrColumnNames indexOfObject:@"firstname"];
    NSInteger indexOfLastname = [self.dbManager.arrColumnNames indexOfObject:@"lastname"];
    NSInteger indexOfAge= [self.dbManager.arrColumnNames indexOfObject:@"age"];
    NSInteger indexOfPeopleInfoID = [self.dbManager.arrColumnNames indexOfObject:@"peopleInfoID"];

    self.firstName.stringValue = [[self.arrPeopleInfo objectAtIndex:selectedRow] objectAtIndex:indexOfFirstname];
    self.lastName.stringValue = [[self.arrPeopleInfo objectAtIndex:selectedRow] objectAtIndex:indexOfLastname];
    self.age.stringValue = [[self.arrPeopleInfo objectAtIndex:selectedRow] objectAtIndex:indexOfAge];
    self.peopleInfoID = [[[self.arrPeopleInfo objectAtIndex:selectedRow] objectAtIndex:indexOfPeopleInfoID] intValue];
    
    self.recordIDToEdit = self.peopleInfoID;
   
    [self updateDetailFields];
    
    NSLog(@"Selected row = %ld", (long) selectedRow);
}

@end
