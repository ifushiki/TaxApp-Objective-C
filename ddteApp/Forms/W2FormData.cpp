//
//  W2FormData.cpp
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/16/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#include <iostream>
#include <vector>
#include "W2FormData.h"

W2FormData::W2FormData()
{
    // All the std::string instances are initialized as empty (= "").
    this->addressType = kAddressType_US;
    this->state = kState_Unspecified;
    this->box12LetterCode = kLetterCode_Unspecified;
    this->box13SatutoryEmployee = false;
    this->box13RetirementPlan = false;
    this->box13ThirdPartySickPay = false;
    this->box15 = kState_Unspecified;
    this->box20AssociatedState = kState_Unspecified;
}

/*
W2FormData_InvalidID = 0,
W2FormData_boxB,                  // Employer's identification number (EIN)
W2FormData_boxC,                  // Employer name
W2FormData_employerNameLine2,     // Employer name line 2 (optional)
W2FormData_addressType,            // Address Type as a popup button.
W2FormData_address,               // Address
W2FormData_city,                  // City
W2FormData_state,                  // State
W2FormData_zipCode,               // ZIP code

//-----------------------------------------------------------------------------------------------------------
// Incoem & taxes withheld (Boxes 1-6)
//-----------------------------------------------------------------------------------------------------------
W2FormData_box1,                  // Wages, tips, other
W2FormData_box2,                  // Federal tax withheld
W2FormData_box3,                  // Social Sec. wages
W2FormData_box4,                  // Social Sec. tax withheld
W2FormData_box5,                  // Medicare Wages
W2FormData_box6,                  // Medicre tax withheld

//-----------------------------------------------------------------------------------------------------------
// Employer's information
//-----------------------------------------------------------------------------------------------------------
W2FormData_box7,                  // Social Sec. tips
W2FormData_box8,                  // Allocated tips
W2FormData_box10,                 // Dependent care benefits
W2FormData_box11,                 // Nonqualfied plans
W2FormData_box12LetterCode,        // Letter code
W2FormData_box12Amount,           // Box 12 amount
W2FormData_box13SatutoryEmployee,  // Box 13 - Satutory employee
W2FormData_box13RetirementPlan,    // Box 13 - Retirement plan
W2FormData_box13ThirdPartySickPay, // Box 13 - Third-party sick pay
W2FormData_box14,                 // Box 14
W2FormData_box14Amount,           // Box 14 amount

//-----------------------------------------------------------------------------------------------------------
// State & local taxes (Boxes 15-20) - Leave blank if no value
//-----------------------------------------------------------------------------------------------------------
W2FormData_box15,                  // Box 15 - State
W2FormData_box15EmployerStateID,  // Box 15 - Employer's state ID number
W2FormData_box16,                 // Box 16 - State wages, tips, etc.
W2FormData_box17,                 // Box 17 - State income tax
W2FormData_box18,                 // Box 18 - Local wages, tips, etc.
W2FormData_box19,                 // Box 19 - Local income tax
W2FormData_box20,                 // Box 20 - Locality name
W2FormData_box20AssociatedState,  // Box 20 - Associated State
*/
bool W2FormData::setField(std::string& str, W2FormDataID dataID)
{
    bool success = false;
    
    switch (dataID) {
        case W2FormData_boxB:
            this->boxB = str;
            success = true;
            break;
            
        case W2FormData_boxC:
            this->boxC = str;
            success = true;
            break;
            
        case W2FormData_employerNameLine2:
            this->employerNameLine2 = str;
            success = true;
            break;
            
//        case W2FormData_addressType:
//            this->addressType = str;
//            break;
            
        case W2FormData_address:
            this->address = str;
            success = true;
            break;
            
        case W2FormData_city:
            this->city = str;
            success = true;
            break;
            
//        case W2FormData_state:
//            this->state = str;
//            break;
            
        case W2FormData_zipCode:
            this->zipCode = str;
            success = true;
            break;
            
        case W2FormData_box1:
            this->box1 = str;
            success = true;
            break;
            
        case W2FormData_box2:
            this->box2 = str;
            success = true;
            break;
            
        case W2FormData_box3:
            this->box3 = str;
            success = true;
            break;
            
        case W2FormData_box4:
            this->box4 = str;
            success = true;
            break;
            
        case W2FormData_box5:
            this->box5 = str;
            success = true;
            break;
            
        case W2FormData_box6:
            this->box6 = str;
            success = true;
            break;
            
        case W2FormData_box7:
            this->box7 = str;
            success = true;
            break;
            
        case W2FormData_box8:
            this->box8 = str;
            success = true;
            break;
            
        case W2FormData_box10:
            this->box10 = str;
            success = true;
            break;
            
        case W2FormData_box11:
            this->box11 = str;
            success = true;
            break;
            
//        case W2FormData_box12LetterCode:
//            this->box12LetterCode = str;
//            break;
            
        case W2FormData_box12Amount:
            this->box12Amount = str;
            success = true;
            break;
            
//        case W2FormData_box13SatutoryEmployee:
//            this->box13SatutoryEmployee = str;
//            break;
            
//        case W2FormData_box13RetirementPlan:
//            this->box13RetirementPlan = str;
//            break;
            
//        case W2FormData_box13ThirdPartySickPay:
//            this->box13ThirdPartySickPay = str;
//            break;
            
        case W2FormData_box14:
            this->box14 = str;
            success = true;
            break;
            
        case W2FormData_box14Amount:
            this->box14Amount = str;
            success = true;
            break;
            
//        case W2FormData_box15:
//            this->box15 = str;
//            break;
            
        case W2FormData_box15EmployerStateID:
            this->box15EmployerStateID = str;
            success = true;
            break;
            
        case W2FormData_box16:
            this->box16 = str;
            success = true;
            break;
            
        case W2FormData_box17:
            this->box17 = str;
            success = true;
            break;
            
        case W2FormData_box18:
            this->box18 = str;
            success = true;
            break;
            
        case W2FormData_box19:
            this->box19 = str;
            success = true;
            break;
            
        case W2FormData_box20:
            this->box20 = str;
            success = true;
            break;
            
//        case W2FormData_box20AssociatedState:
//            this->box20AssociatedState = str;
//            break;
            
        default:
            break;
    }

    return success;
}

std::string W2FormData::getField(W2FormDataID dataID)
{
    std::string str;
    
    switch (dataID) {
        case W2FormData_boxB:
            str = this->boxB;
            break;
            
        case W2FormData_boxC:
            str = this->boxC;
            break;
            
        case W2FormData_employerNameLine2:
            str = this->employerNameLine2;
            break;
            
        case W2FormData_addressType:
            str = this->addressType;
            break;
            
        case W2FormData_address:
            str = this->address;
            break;
            
        case W2FormData_city:
            str = this->city;
            break;
            
        case W2FormData_state:
            str = this->state;
            break;
            
        case W2FormData_zipCode:
            str = this->zipCode;
            break;
            
        case W2FormData_box1:
            str = this->box1;
            break;
            
        case W2FormData_box2:
            str = this->box2;
            break;
            
        case W2FormData_box3:
            str = this->box3;
            break;
            
        case W2FormData_box4:
            str = this->box4;
            break;
            
        case W2FormData_box5:
            str = this->box5;
            break;
            
        case W2FormData_box6:
            str = this->box6;
            break;
            
        case W2FormData_box7:
            str = this->box7;
            break;
            
        case W2FormData_box8:
            str = this->box8;
            break;
            
        case W2FormData_box10:
            str = this->box10;
            break;
            
        case W2FormData_box11:
            str = this->box11;
            break;
            
        case W2FormData_box12LetterCode:
            str = this->box12LetterCode;
            break;
            
        case W2FormData_box12Amount:
            str = this->box12Amount;
            break;
            
        case W2FormData_box13SatutoryEmployee:
            str = this->box13SatutoryEmployee;
            break;
            
        case W2FormData_box13RetirementPlan:
            str = this->box13RetirementPlan;
            break;
            
        case W2FormData_box13ThirdPartySickPay:
            str = this->box13ThirdPartySickPay;
            break;
            
        case W2FormData_box14:
            str = this->box14;
            break;
            
        case W2FormData_box14Amount:
            str = this->boxC;
            break;
            
        case W2FormData_box15:
            str = this->boxC;
            break;
            
        case W2FormData_box15EmployerStateID:
            str = this->box15EmployerStateID;
            break;
            
        case W2FormData_box16:
            str = this->box16;
            break;
            
        case W2FormData_box17:
            str = this->box17;
            break;
            
        case W2FormData_box18:
            str = this->box18;
            break;
            
        case W2FormData_box19:
            str = this->box19;
            break;
            
        case W2FormData_box20:
            str = this->box20;
            break;
            
        case W2FormData_box20AssociatedState:
            str = this->box20AssociatedState;
            break;
            
        default:
            break;
    }

    return str;
}
