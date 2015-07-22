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
#import "ResourceUtil.h"
#import "W2ViewController1.h"
#import "W2ViewController2.h"
#import "W2ViewController3.h"
#import "W2TableViewController.h"
#import "DdteWindowController.h"
#import "SqlWindowController.h"
#import "W2FormData.h"

std::string getDMACode(std::string& zipCode);

@interface AppDelegate()

@property (nonatomic, strong)   DBManager   *dbManager;
@property (nonatomic, strong)   NSArray*    arrPeopleInfo;
@property (nonatomic)           int         peopleInfoID;
@property (nonatomic, strong)   NSViewController *currentController;
@property (nonatomic, strong)   DdteWindowController *ddteWindowController;
@property (nonatomic, strong)   SqlWindowController *sqlWindowController;
@property (nonatomic)           int         viewIndex;
@property (nonatomic)           CGPoint     sheetOrigin;
@property (nonatomic)           CGPoint     sheetOriginOffset;  // Offset from the sheetOrigin.

- (void) loadData;
- (void) loadInfoToEdit;
- (void) updateDetailFields;
- (void) clearDetailFields;
- (void) doCurlTest;
- (void) doSqLiteTest;

@end

std::string kDdtePostTestURL = "http://api.ddte.corp.intuit.net/v1/errorcheck";
std::string kDdtePostTestData = "{ \"suspects\": [ { \"/Return/ReturnData/IRSW2[@uuid='aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee']/EmployersUseGrp[EmployersUseCd='B']/EmployersUseAmt\":\"100\" }], \"requiredInputs\": [{ \"/Return/ReturnData/IRSW2[@uuid='aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee']/EmployersUseGrp[EmployersUseCd='A']/EmployersUseAmt\": \"500\", \"/Return/ReturnData/IRSW2[@uuid='aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee']/WagesAmt\": \"45000\" }]}";

std::string kDdtePostTestData1 = "{\"suspects\": [{\"/Return/ReturnData/IRSW2[uuid_1]/WagesAmt\": \" 30000\"}] \"requiredInputs\": [{\"/Return/ReturnData/IRSW2[uuid_1]/WithholdingAmt\": \" 6000\"}, {\"/Return/ReturnData/IRSW2[uuid_1]/SocialSecurityWagesAmt\": \" 200000\"}, {\"/Return/ReturnData/IRSW2[uuid_1]/MedicareWagesAndTipsAmt\": \" 50000:\"}]}";

std::string kDdtePostTestData2 = "{ \"suspects\": [{\"/Return/ReturnData/IRSW2[uuid_1]/WagesAmt\": \"3000\"}. {\"/Return/ReturnData/IRSW2[uuid_1]/SocialSecurityWagesAmt\": \"30000\"}] \"requiredInputs\":[ {\"/Return/ReturnData/IRSW2[uuid_1]/SocialSecurityTaxAmt\": \"15000\"}] }";

std::string kDdtePostTestData3 = "{\"suspects\": [{\"/Return/ReturnData/IRSW2[uuid_1]/WagesAmt\": \" 30000\"}, {\"/Return/ReturnData/IRSW2[uuid_1]/SocialSecurityWagesAmt\": \" 30000\"}] \"requiredInputs\": [{\"/Return/ReturnData/IRSW2[uuid_1]/MedicareTaxWithheldAmt\": \" 600\"}]}";

std::string kDdteGetTestURL = "http://api.ddte.corp.intuit.net/v1/listtestfields";

#define INTEL_NETWORK

@implementation AppDelegate

- (void) setPopupMenu
{
    NSArray *itemTitles = [[NSArray alloc] initWithObjects:@"DDTE Case 1", @"DDTE Case 2", @"DDTE Case 3", @"SQL Case", nil];
    [self.ddtePopup removeAllItems];
    [self.ddtePopup addItemsWithTitles:itemTitles];
}

- (NSScrollView *) createScrollView
{
    // create the scroll view so that it fills the entire window
    // to do that we'll grab the frame of the window's contentView
    // theWindow is an outlet connected to a window instance in Interface Builder
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:[[self.window contentView] frame]];
    
    // the scroll view should have both horizontal
    // and vertical scrollers
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:YES];
    
    // configure the scroller to have no visible border
    [scrollView setBorderType:NSNoBorder];
    
    // set the autoresizing mask so that the scroll view will
    // resize with the window
    [scrollView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    
    return scrollView;
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSImage *headerImage = [ResourceUtil getImage:@"TurboTax W-2 Header" withType:@"png"];
    NSImage *w2LogoImage = [ResourceUtil getImage:@"TurboTax W-2 Logo" withType:@"png"];
    
    [self.headerImageView setImage:headerImage];
    [self.w2LogoImageView setImage:w2LogoImage];
    
    [self setPopupMenu];
    
#if 0
    // Initialize the dbManager object.
//    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"sampledb.sql"];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ddte-client.sqlite3"];
//    NSString *query = [NSString stringWithFormat:@"select * from poepeleInfo where peopleInfoID=%d", self.recordIDToEdit];
    NSString *query = [NSString stringWithFormat:@"select * from zip_dma where zip=94087"];
    
    // Load the relevant data.
//    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];

    // Insert code here to initialize your application
    if (self.tableView) {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self loadData];
        
        self.recordIDToEdit = -1;
        [self updateDetailFields];
    }
#endif

    [self.window setDelegate:self];
    
    
    // Testing curl methods.
#ifdef INTEL_NETWORK
    [self doCurlTest];
#else
    NSLog(@"We are not in Intel Network.  Skipping Curl Test.");
#endif

    self.viewIndex = 0;
    self.currentController = nil;

    // Set to the first view.
    [self goToNextView:nil];
    
    [self.headerImageView setNeedsDisplay:YES];
    
    [self doSqLiteTest];
}

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView {
    return self.arrPeopleInfo.count;
}

- (CGFloat) tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 30.0;
    
}

enum {
    kJasonPlaceHolder = 1,
    kDdteGetTest = 2,
    kDdtePostTest = 3,
    kApple = 4,
    kGoogle = 5,
};

bool configureHTTPRequestURLAndData(int caseIndex, std::string& url, std::string *data)
{
    bool isGet = true;
    switch (caseIndex) {
        case kDdteGetTest:
            url = kDdteGetTestURL;
            break;
        
        case kDdtePostTest:
            url = kDdtePostTestURL;
            if (data) {
                *data = kDdtePostTestData1;
            }
            isGet = false;
            break;
        
        case kApple:
            url = "http:://www.apple.com";
            break;
            
        case kGoogle:
            url = "http://www.google.com";
            break;
        
        case kJasonPlaceHolder:
        default:
            std::string url = "http://jsonplaceholder.typicode.com/posts";
            if (data) {
                *data = "\"data\": {\"title\": \"foo\", \"body\": \"bar\", \"userId\": 1}";

            }
            isGet = false;
            break;
    }
    
    return isGet;

}

- (void) doCurlTest
{
    CurlTest curl;
    NSLog(@"======= Testing Curl =========");
    
    std::string url;
    std::string data;
    CURLcode curlResult;

    bool isGet = configureHTTPRequestURLAndData(kDdtePostTest, url, &data);
    
    if (isGet) {
        curlResult = curl.Get(url);
    }
    else {
        curlResult = curl.Post(url, &data);
    }

    if (curlResult == CURLE_OK) {
        
        std::cout << "status: " << curl.HttpStatus() << std::endl;
        std::cout << "type: " << curl.Type() << std::endl;
        std::vector<std::string> headers = curl.Headers();
        
        for(std::vector<std::string>::iterator it = headers.begin();
            it != headers.end(); it++)
            std::cout << "Header: " << (*it) << std::endl;
        
        std::cout << "Content:\n" << curl.Content() << std::endl;
    }
    
}

- (void) doSqLiteTest
{
    // Initialize the dbManager object.
    //    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"sampledb.sql"];
    //    NSString *query = [NSString stringWithFormat:@"select * from poepeleInfo where peopleInfoID=%d", self.recordIDToEdit];
    std::string zipCode = "94087";
    std::string dmaCode = getDMACode(zipCode);
    std::cout << "dmaCode = " << dmaCode << std::endl;
    
    NSString* query;
    std::vector<std::string> rowList;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ddte-client.sqlite3"];
    query = [NSString stringWithFormat:@"select dma_id from zip_dma where zip = '94040'"];
    [self.dbManager loadDataFromDB:query withList:rowList];
    std::cout << "column count = " << rowList.size() << std::endl;
    for(int i = 0; i < rowList.size(); i++)
    {
        std::cout << rowList[i] << ", ";
    }
    std::cout << std::endl;
    
    std::vector<std::string> rowList2;
    std::string w2Field = "medicare_wages";
    getRangeFromGeo(rowList2, dmaCode, w2Field);
    std::cout << "-------- Geo Result ------------" << std::endl;
    std::cout << "column count = " << rowList2.size() << std::endl;
    for(int i = 0; i < rowList2.size(); i++)
    {
        std::cout << rowList2[i] << ", ";
    }
    std::cout << std::endl;

/*
    // Do other query.
    std::vector<std::string> rowList3;
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ddte-client.sqlite3"];
//    query = [NSString stringWithFormat:@"select * from zip_dma"];
    query = [NSString stringWithFormat:@"select pct2,pct98 from ddte_1d_geo where geo = 807 AND w2_field = 'wages'"];
    //    NSString *query = [NSString stringWithFormat:@"select w2_field, pct2,pct98 from ddte_1d_fs"];
    [self.dbManager loadDataFromDB:query withList:rowList3];
    std::cout << "column count = " << rowList2.size() << std::endl;
    for(int i = 0; i < rowList3.size(); i++)
    {
        std::cout << rowList3[i] << ", ";
    }
 */

    // Do other query.
    std::vector<std::string> rowList4;
    std::string ageBracket = "20-29";
    std::string w2Field2 = "wages";
    getRangeFromAge(rowList4, ageBracket, w2Field2);
/*
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ddte-client.sqlite3"];
    //    query = [NSString stringWithFormat:@"select * from zip_dma"];
    query = [NSString stringWithFormat:@"select pct2,pct98 from ddte_1d_age where age_bracket = '20-29' AND w2_field = 'wages'"];
    //    NSString *query = [NSString stringWithFormat:@"select w2_field, pct2,pct98 from ddte_1d_fs"];
    [self.dbManager loadDataFromDB:query withList:rowList4];
 */
    std::cout << "-------- Geo Result ------------" << std::endl;
    std::cout << "column count = " << rowList4.size() << std::endl;
    for(int i = 0; i < rowList4.size(); i++)
    {
        std::cout << rowList4[i] << ", ";
    }

    // Do other query.
    std::vector<std::string> rowList5;
    std::string occupation = "professor";
    std::string w2Field3 = "wages";

    getRangeFromOccupation(rowList5, occupation, w2Field2);
/*
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ddte-client.sqlite3"];
    //    query = [NSString stringWithFormat:@"select * from zip_dma"];
    query = [NSString stringWithFormat:@"select pct2,pct98 from ddte_1d_occ where occupation = 'professor' AND w2_field = 'wages'"];
    //    NSString *query = [NSString stringWithFormat:@"select w2_field, pct2,pct98 from ddte_1d_fs"];
    [self.dbManager loadDataFromDB:query withList:rowList5];
 */
    std::cout << "-------- Occupation Result ------------" << std::endl;
    std::cout << "column count = " << rowList5.size() << std::endl;
    for(int i = 0; i < rowList5.size(); i++)
    {
        std::cout << rowList5[i] << ", ";
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

- (void) setNextViewController:(int) goToNext
{
    // Remvoe the existing view controller.
    if ([self.currentController view] != nil)
    {
        [[self.currentController view] removeFromSuperview];	// remove the current view
        self.currentController = nil;   // Release the current view controller.
    }
    
    // Go to the next index.
    if(goToNext !=0 ) {
        _viewIndex = goToNext > 0 ? _viewIndex + 1: _viewIndex - 1;
        if (_viewIndex < 0) {
            _viewIndex = 3; // The last index.
        }
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
    BOOL goToNext = 1;
    if (sender == nil) {
        goToNext = 0;
        NSScrollView *scrollView = [self createScrollView];
        [self.window setContentView:scrollView];
    }
    [self setNextViewController:goToNext];

    // Adjust the origin.
    NSRect parentFrame = self.window.frame;
    NSRect currentRect = self.currentController.view.bounds;
    float dy = parentFrame.size.height- currentRect.size.height - 128;
    currentRect.origin.y = dy;
    NSRect rect = currentRect;
//    NSRect rect = CGRectMake(40, -30, 1200, 720);
    [self.currentController.view setFrame:rect];
//    [self.window.contentView addSubview:self.currentController.view];
    [(NSScrollView *)self.window.contentView setDocumentView:self.currentController.view];
}

- (IBAction)goToPreviousView:(id)sender {
    BOOL goToNext = -1;

    [self setNextViewController:goToNext];

    // Adjust the origin.
    NSRect parentFrame = self.window.frame;
    NSRect currentRect = self.currentController.view.bounds;
    float dy = parentFrame.size.height- currentRect.size.height - 128;
    currentRect.origin.y = dy;
    NSRect rect = currentRect;
//    NSRect rect = CGRectMake(40, -30, 1200, 720);
    [self.currentController.view setFrame:rect];
    [self.window.contentView addSubview:self.currentController.view];
}

// Load the table data.
- (void) loadData {
    // Form the query.
//    NSString *query = @"select * from peopleInfo";
//    NSString *query = @"select * from ddte_3d_occ_age_geo_stats";
    NSString *query = @"select w2_field, pct2,pct98 from ddte_1d_fs";
    std::vector<std::string> rowList;
    
    // Get the results.
    if (self.arrPeopleInfo != nil) {
        self.arrPeopleInfo = nil;
    }
    [self.dbManager loadDataFromDB:query withList:rowList];
//    self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the tale view.
    [self.tableView reloadData];
}

// Load the selected data to the detailed fields.
- (void) loadInfoToEdit {
    // Create a query.
    NSString *query = [NSString stringWithFormat:@"select * from poepeleInfo where peopleInfoID=%d", self.recordIDToEdit];
    std::vector<std::string> rowList;
   
    // Load the relevant data.
    [self.dbManager loadDataFromDB:query withList:rowList];
/*
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Set the loaded data to the text fields.
    self.firstName.stringValue = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"firstname"]];
    self.lastName.stringValue = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"lastname"]];
    self.age.stringValue = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"age"]];
 */
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

// This function will return the sigma calculated from DDTE.
- (float) getSigma:(int) selectedIndex
{
    float sigma;
    
    switch (selectedIndex) {
        case 0:
            sigma = 1.5;
            break;
            
        case 1:
            sigma = 3.5;
            break;
        
        case 2:
            sigma = 5.6;
            break;
            
        default:
            sigma = 0.0;
            break;
    }
    
    return sigma;
}

- (IBAction)ddtePopupPressed:(id)sender {
    int selectedIndex = (int) self.ddtePopup.indexOfSelectedItem;
    
    if (selectedIndex < 3) {
        
        // Open a modal window for DDTE
        float sigma = [self getSigma:selectedIndex];
        
        NSLog(@"DDTE popup: Analyzed sigma = %.3f", sigma);
        
        self.ddteWindowController = [[DdteWindowController alloc] initWithWindowNibName:@"DdteWindowController"];
        self.ddteWindowController.sigma = sigma;
        NSRect windowFrame = self.window.frame;
        float kOffset = 120;    // Offset from the top of the window.
        _sheetOrigin.x = 0;
        _sheetOrigin.y = windowFrame.size.height - kOffset;
        
        [self.window beginSheet:self.ddteWindowController.window  completionHandler:^(NSModalResponse returnCode) {
            NSLog(@"Sheet closed");
            
            switch (returnCode) {
                case NSModalResponseOK:
//                    NSLog(@"Done button tapped in Custom Sheet");
                    break;
                case NSModalResponseCancel:
//                    NSLog(@"Cancel button tapped in Custom Sheet");
                    break;
                    
                default:
                    break;
            }
            
            self.ddteWindowController = nil;
        }];
    }
    else {
        // Open a modal window for SQL
        self.sqlWindowController = [[SqlWindowController alloc] initWithWindowNibName:@"SqlWindowController"];
        
        [self.window beginSheet:self.sqlWindowController.window  completionHandler:^(NSModalResponse returnCode) {
            NSLog(@"Sheet closed");
            
            switch (returnCode) {
                case NSModalResponseOK:
//                    NSLog(@"Done button tapped in Custom Sheet");
                    break;
                case NSModalResponseCancel:
//                    NSLog(@"Cancel button tapped in Custom Sheet");
                    break;
                    
                default:
                    break;
            }
            
            self.sqlWindowController = nil;
        }];
    }
}

+ (void) showWarning:(NSString *) message at:(CGPoint) topLeftPt;
{
    AppDelegate *appDelegate = (AppDelegate *) [NSApp delegate];
    appDelegate.sheetOrigin = topLeftPt;
    
    NSImage *iconImage = [ResourceUtil getImage:@"TurboTax icon" withType:@"jpeg"];

    NSAlert *alert = [[NSAlert alloc] init];
    
    [alert addButtonWithTitle:@"Got it"];
    //    [alert addButtonWithTitle:@"Cancel"];
    [alert setMessageText:@"Are you sure?"];
    [alert setInformativeText:message];
    [alert setAlertStyle:NSWarningAlertStyle];
    alert.icon = iconImage;
    
    [alert beginSheetModalForWindow:appDelegate.window completionHandler:nil];
    
    // With a completion handler
    /*
     [alert beginSheetModalForWindow:[self.view window] completionHandler:^(NSInteger returnCode)
     {
     switch(returnCode) {
     case NSAlertFirstButtonReturn:
     // "First" pressed
     break;
     case NSAlertSecondButtonReturn:
     // "Second" pressed
     break;
     
     default:
     break;
     }
     }];
     */
    
    // Run as a modal window.
    /*
     if ([alert runModal] == NSAlertFirstButtonReturn) {
     // OK clicked, delete the record
     }
     */

}

// NSWindowDelegate method
// This is used to place a sheet in a disiered location.
// The given rect has zero value except for rect.origin.y and rect.size.width
- (NSRect)window:(NSWindow *)window willPositionSheet:(NSWindow *)sheet usingRect:(NSRect)rect {
    NSRect fieldRect = rect;            // Bounds of the window
    NSRect sheetRect = sheet.frame;     // Frame of sheet.
    
    // Sheet frame is calculated as the sheet center (in x-coordinate as the middle)
    // We need to shift the following value to place the sheet to the left edge of the window.
    float dx = - (rect.size.width  - sheetRect.size.width)/2;   // We need to send this x-shift to make the s

    // We need to supply the top left corner of the sheet.
    float x1, y1;
    x1 = self.sheetOrigin.x;
    y1 = self.sheetOrigin.y;
    
    float x = x1 + dx;
    float y = y1;

    fieldRect.origin.x = x;
    fieldRect.origin.y = y;
    fieldRect.size.height = 0;
    return fieldRect;
}

@end
