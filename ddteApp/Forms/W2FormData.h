//
//  W2FormData.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/16/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#include <iostream>
#import "W2FormTypes.h"

class W2FormData
{
public:
    W2FormData();
    
    W2Error setField(std::string& str, W2FormDataID dataID);
    W2Error checkField(std::string& str, W2FormDataID dataID);
    std::string getField(W2FormDataID dataID);
    
    W2Error setSelection(int selectionID, W2FormDataID dataID);
    W2Error checkSelection(int selectionID, W2FormDataID dataID);
    int getSelection(W2FormDataID dataID);
    
    W2Error setCheckBoxStatus(CheckBoxStatus status, W2FormDataID dataID);
    W2Error checkCheckBoxStatus(CheckBoxStatus status, W2FormDataID dataID);
    CheckBoxStatus getFormCheckBoxStatus(W2FormDataID dataID);
    bool getDouble(const std::string& str, double&d);
    bool getInteger(const std::string& str, int&i);
    W2Error checkOutlier(double amount, const std::string& w2FieldString);
    
    void setOccupationString(const std::string& str);
    
    std::string getErrorMessage();
    std::string getAgeBracket(int age);
    
    std::string getQueryString();

private:
    std::string errorMessage;               // An Error Message for an operation.

    std::string boxB;                       // Employer's identification number (EIN)
    std::string boxC;                       // Employer name
    std::string employerNameLine2;          // Employer name line 2 (optional)
    int         addressType;                // Address Type as a popup button.
    std::string address;                    // Address
    std::string city;                       // City
    int         state;                      // State
    std::string zipCode;                    // ZIP code
    
    //-----------------------------------------------------------------------------------------------------------
    // Extra fields needed for Query (Boxes 0)
    //-----------------------------------------------------------------------------------------------------------
    std::string box0_Age;                  // Age
    int         box0_Occupation;            // Occupation

    //-----------------------------------------------------------------------------------------------------------
    // Incoem & taxes withheld (Boxes 1-6)
    //-----------------------------------------------------------------------------------------------------------
    std::string box1;                       // Wages, tips, other
    std::string box2;                       // Federal tax withheld
    std::string box3;                       // Social Sec. wages
    std::string box4;                       // Social Sec. tax withheld
    std::string box5;                       // Medicare Wages
    std::string box6;                       // Medicre tax withheld
    
    //-----------------------------------------------------------------------------------------------------------
    // Employer's information
    //-----------------------------------------------------------------------------------------------------------
    std::string box7;                       // Social Sec. tips
    std::string box8;                       // Allocated tips
    std::string box10;                      // Dependent care benefits
    std::string box11;                      // Nonqualfied plans
    int         box12LetterCode;            // Letter code
    std::string box12Amount;                // Box 12 amount
    CheckBoxStatus box13SatutoryEmployee;   // Box 13 - Satutory employee is unchecked.
    CheckBoxStatus box13RetirementPlan;     // Box 13 - Retirement plan is unchecked.
    CheckBoxStatus box13ThirdPartySickPay;  // Box 13 - Third-party sick pay
    std::string box14;                      // Box 14
    std::string box14Amount;                // Box 14 amount
    
    //-----------------------------------------------------------------------------------------------------------
    // State & local taxes (Boxes 15-20) - Leave blank if no value
    //-----------------------------------------------------------------------------------------------------------
    int         box15;                      // Box 15 - State
    std::string box15EmployerStateID;       // Box 15 - Employer's state ID number
    std::string box16;                      // Box 16 - State wages, tips, etc.
    std::string box17;                      // Box 17 - State income tax
    std::string box18;                      // Box 18 - Local wages, tips, etc.
    std::string box19;                      // Box 19 - Local income tax
    std::string box20;                      // Box 20 - Locality name
    int         box20AssociatedState;       // Box 20 - Associated State


    //-----------------------------------------------------------------------------------------------------------
    // Query strings
    //-----------------------------------------------------------------------------------------------------------
    std::string ageString;
    std::string occupationString;
    std::string geoString;
    std::string w2FieldString;
    
};
