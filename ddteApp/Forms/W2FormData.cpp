//
//  W2FormData.cpp
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/16/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#include <iostream>
#include <vector>
#include <string>
#include "W2FormData.h"
#import "SQLite.h"

W2FormData::W2FormData()
{
    // All the std::string instances are initialized as empty (= "").
    this->addressType = kAddressType_US;
    this->state = kState_Unspecified;
    this->box12LetterCode = kLetterCode_Unspecified;
    this->box13SatutoryEmployee = kCheckBoxStatus_Off;
    this->box13RetirementPlan = kCheckBoxStatus_Off;
    this->box13ThirdPartySickPay = kCheckBoxStatus_Off;
    this->box15 = kState_Unspecified;
    this->box20AssociatedState = kState_Unspecified;
}

bool W2FormData::getDouble(const std::string& str, double&d)
{
    bool success = false;
    try {
        size_t n_size;
        d = std::stod(str, &n_size);
        success = true;
    }
    catch (...) {
        std::cout << "An exception in converting a string to double";
        this->errorMessage = "This field must be a number.";
    }
    
    return success;
}

bool W2FormData::getInteger(const std::string& str, int&i)
{
    bool success = false;
    try {
        i = std::stoi(str);
        success = true;
    }
    catch (...) {
        std::cout << "An exception in converting a string to integer";
        this->errorMessage = "This field must be a number.";
    }
    
    return success;
}

W2Error W2FormData::checkOutlier(double amount, const std::string& w2FieldString)
{
    const clock_t begin_time = std::clock();
    
    bool hasRange = false;
    double xmin = 0, xmax = 10000000;
    double d;
    if (geoString != "") {
        std::vector<std::string> rowList1;
        getRangeFromGeo(rowList1, geoString, w2FieldString);
        std::cout << w2FieldString << " with Geo." << std::endl;
        if (rowList1.size() >= 2) {
            hasRange = true;
            std::cout << "column count = " << rowList1.size() << std::endl;
            for(int i = 0; i < rowList1.size(); i++)
            {
                std::cout << rowList1[i] << ", ";
            }
            std::cout << std::endl;
            
            if (getDouble(rowList1[0], d)) {
                xmin = xmin > d ? xmin: d;  // Increase the minimum
            }
            if (getDouble(rowList1[1], d)) {
                xmax = xmax < d ? xmax: d;  // decreading the maximum
            }
        }
    }
    if (occupationString != "") {
        std::vector<std::string> rowList2;
        getRangeFromOccupation(rowList2, occupationString, w2FieldString);
        std::cout << w2FieldString << " with Occupation." << std::endl;
        std::cout << "column count = " << rowList2.size() << std::endl;
        if (rowList2.size() >= 2) {
            hasRange = true;
            for(int i = 0; i < rowList2.size(); i++)
            {
                std::cout << rowList2[i] << ", ";
            }
            std::cout << std::endl;
            
            if (getDouble(rowList2[0], d)) {
                xmin = xmin > d ? xmin: d;  // Increase the minimum
            }
            if (getDouble(rowList2[1], d)) {
                xmax = xmax < d ? xmax: d;  // decreading the maximum
            }
        }
    }
    if (ageString != "") {
        std::vector<std::string> rowList3;
        getRangeFromAge(rowList3, ageString, w2FieldString);
        std::cout << w2FieldString << " with Age." << std::endl;
        std::cout << "column count = " << rowList3.size() << std::endl;
        if (rowList3.size() >= 2) {
            hasRange = true;
            for(int i = 0; i < rowList3.size(); i++)
            {
                std::cout << rowList3[i] << ", ";
            }
            std::cout << std::endl;
            if (getDouble(rowList3[0], d)) {
                xmin = xmin > d ? xmin: d;  // Increase the minimum
            }
            if (getDouble(rowList3[1], d)) {
                xmax = xmax < d ? xmax: d;  // decreading the maximum
            }
        }
    }
    
    W2Error success = kW2Error_OK;
    if (hasRange && xmax > xmin) {
        std::string message = "You have entered $" + std::to_string(amount) + ".  However, your value seems to be too ";
        if (amount > xmax ) {
            // This is an outlier.
            success = kW2Error_Warning;
            errorMessage = message + "high.";
        }
        else if (amount < xmin) {
            // This is an outlier.
            success = kW2Error_Warning;
            errorMessage = message + "low.";
        }
    }
    
    const clock_t end_time = std::clock();
    
    std::cout << float (end_time - begin_time)/ CLOCKS_PER_SEC;

    return success;
}

W2Error W2FormData::checkField(std::string& str, W2FormDataID dataID)
{
    // Retuns OK unless there are some issues.
    W2Error success = kW2Error_OK;
    this->errorMessage = "";    // Initialized to an empty string.
    
    switch (dataID) {
        case W2FormData_boxB:
            // Check the validity
            break;
            
        case W2FormData_boxC:
            // Check the validity
            break;
            
        case W2FormData_employerNameLine2:
            // Check the validity
            break;
            
//        case W2FormData_addressType:
//            std::cout << "Use setSelection() for the selected ID." << std::endl;
//            break;
            
        case W2FormData_address:
            // Check the validity
            break;
            
        case W2FormData_city:
            // Check the validity
            break;
            
//        case W2FormData_state:
//            std::cout << "Use setSelection() for the selected ID." << std::endl;
//            break;
            
        case W2FormData_zipCode:
        {
            // First check the given input is a number.  get
            int i;
            if (getInteger(str, i)) {
                std::cout << "The number = " << i << std::endl;
                geoString = getDMACode(str);
            }
            else {
                std::cout << "Failed the double conversion." << std::endl;
                success = kW2Error_Invalid;
            }
        }
            break;
            
        case W2FormData_box0_Age:
        {
            double d;
            if (getDouble(str, d)) {
                std::cout << "The number = " << d << std::endl;
                ageString = this->getAgeBracket((int) d);
            }
            else {
                std::cout << "Failed the double conversion." << std::endl;
                success = kW2Error_Invalid;
            }
        }
             break;
            
//        case W2FormData_box0_Occupation:
//            std::cout << "Use setSelection() for the selected ID." << std::endl;
//            break;
            
        case W2FormData_box1:
        {
            double d;
            if (getDouble(str, d)) {
                std::cout << "The number = " << d << std::endl;
                w2FieldString = "wages";
                success = checkOutlier(d, w2FieldString);
            }
            else {
                std::cout << "Failed the double conversion." << std::endl;
                success = kW2Error_Invalid;
            }
        }
            break;
            
        case W2FormData_box2:
        {
            double d;
            if (getDouble(str, d)) {
                std::cout << "The number = " << d << std::endl;
                w2FieldString = "federal_tax_withheld";
                success = checkOutlier(d, w2FieldString);
            }
            else {
                std::cout << "Failed the double conversion." << std::endl;
                success = kW2Error_Invalid;
            }
        }
            break;
            
        case W2FormData_box3:
        {
            double d;
            if (getDouble(str, d)) {
                std::cout << "The number = " << d << std::endl;
                w2FieldString = "social_security_wages";
                success = checkOutlier(d, w2FieldString);
            }
            else {
                std::cout << "Failed the double conversion." << std::endl;
                success = kW2Error_Invalid;
            }
        }
            break;
            
        case W2FormData_box4:
        {
            double d;
            if (getDouble(str, d)) {
                std::cout << "The number = " << d << std::endl;
                w2FieldString = "federal_tax_withheld";
                success = checkOutlier(d, w2FieldString);
            }
            else {
                std::cout << "Failed the double conversion." << std::endl;
                success = kW2Error_Invalid;
            }
        }
            break;
            
        case W2FormData_box5:
        {
            double d;
            if (getDouble(str, d)) {
                std::cout << "The number = " << d << std::endl;
                w2FieldString = "medicare_wages";
                success = checkOutlier(d, w2FieldString);
            }
            else {
                std::cout << "Failed the double conversion." << std::endl;
                success = kW2Error_Invalid;
            }
        }
            break;
            
        case W2FormData_box6:
        {
            double d;
            if (getDouble(str, d)) {
                std::cout << "The number = " << d << std::endl;
                w2FieldString = "medicare_tax_withheld";
                success = checkOutlier(d, w2FieldString);
            }
            else {
                std::cout << "Failed the double conversion." << std::endl;
                success = kW2Error_Invalid;
            }
        }
            break;
            
        case W2FormData_box7:
        {
            double d;
            if (getDouble(str, d)) {
                std::cout << "The number = " << d << std::endl;
            }
            else {
                std::cout << "Failed the double conversion." << std::endl;
                success = kW2Error_Invalid;
            }
        }
            break;
            
        case W2FormData_box8:
        {
            double d;
            if (getDouble(str, d)) {
                std::cout << "The number = " << d << std::endl;
            }
            else {
                std::cout << "Failed the double conversion." << std::endl;
                success = kW2Error_Invalid;
            }
        }
            break;
            
        case W2FormData_box10:
        {
            double d;
            if (getDouble(str, d)) {
                std::cout << "The number = " << d << std::endl;
            }
            else {
                std::cout << "Failed the double conversion." << std::endl;
                success = kW2Error_Invalid;
            }
        }
            break;
            
        case W2FormData_box11:
        {
            double d;
            if (getDouble(str, d)) {
                std::cout << "The number = " << d << std::endl;
            }
            else {
                std::cout << "Failed the double conversion." << std::endl;
            }
            success = kW2Error_Invalid;
        }
            break;
            
//        case W2FormData_box12LetterCode:
//            std::cout << "Use setSelection() for the selected ID." << std::endl;
//            break;
            
        case W2FormData_box12Amount:
            // Check the validity
            break;
            
//        case W2FormData_box13SatutoryEmployee:
//            std::cout << "Use setCheckBoxStatus() for the checkbox status." << std::endl;
//            break;
            
//        case W2FormData_box13RetirementPlan:
//            std::cout << "Use setCheckBoxStatus() for the checkbox status." << std::endl;
//            break;
            
//        case W2FormData_box13ThirdPartySickPay:
//            std::cout << "Use setCheckBoxStatus() for the checkbox status." << std::endl;
//            break;
            
        case W2FormData_box14:
            // Check the validity
            break;
            
        case W2FormData_box14Amount:
            // Check the validity
            break;
            
//        case W2FormData_box15:
//            std::cout << "Use setSelection() for the selected ID." << std::endl;
//            break;
            
        case W2FormData_box15EmployerStateID:
            // Check the validity
            break;
            
        case W2FormData_box16:
            // Check the validity
            break;
            
        case W2FormData_box17:
            // Check the validity
            break;
            
        case W2FormData_box18:
            // Check the validity
            break;
            
        case W2FormData_box19:
            // Check the validity
            break;
            
        case W2FormData_box20:
            // Check the validity
            break;
            
//        case W2FormData_box20AssociatedState:
//            std::cout << "Use setSelection() for the selected ID." << std::endl;
//            break;
            
        default:
            break;
    }
    
    return success;
}

void W2FormData::setOccupationString(const std::string& str)
{
    occupationString = str;
}

W2Error W2FormData::checkSelection(int selectionID, W2FormDataID dataID)
{
    W2Error success = kW2Error_Invalid;
    
    switch (dataID) {
        case W2FormData_addressType:
            this->addressType = selectionID;
            success = kW2Error_OK;
            break;
            
        case W2FormData_state:
            this->state = selectionID;
            success = kW2Error_OK;
            break;
            
        case W2FormData_box0_Occupation:
            this->box0_Occupation = selectionID;
            success = kW2Error_OK;
            break;
            
        case W2FormData_box12LetterCode:
            this->box12LetterCode = selectionID;
            success = kW2Error_OK;
            break;
            
        case W2FormData_box15:
            this->box15 = selectionID;
            success = kW2Error_OK;
            break;
            
        case W2FormData_box20AssociatedState:
            this->box20AssociatedState = selectionID;
            success = kW2Error_OK;
            break;
            
        default:
            break;
    }
    
    return success;
}

W2Error W2FormData::checkCheckBoxStatus(CheckBoxStatus status, W2FormDataID dataID)
{
    // Not implemented yet.  Simply retuns a OK for now.
    return kW2Error_OK;
}

std::string W2FormData::getErrorMessage()
{
    // Not fully implemented.  But return the same error message now.
//    this->errorMessage  = "Are you sure you typed the data correctly?";
    
    return this->errorMessage;
}

// This return the age bracket as a string for the given age.
std::string W2FormData::getAgeBracket(int age)
{
    std::string bracket;
    
    if (age < 10) {
        bracket = "0-9";
    }
    else if (age < 20) {
        bracket = "10-19";
    }
    else if (age < 30) {
        bracket = "20-29";
    }
    else if (age < 40) {
        bracket = "30-39";
    }
    else if (age < 50) {
        bracket = "40-49";
    }
    else if (age < 60) {
        bracket = "50-60";
    }
    else if (age < 70) {
        bracket = "60-69";
    }
    else if (age < 80) {
        bracket = "70-79";
    }
    else if (age < 90) {
        bracket = "80-89";
    }
    else {
        // Peopel over 99 is also included in this braket.
        bracket = "90-99";
    }
    return bracket;
}


W2Error W2FormData::setField(std::string& str, W2FormDataID dataID)
{
    W2Error success = kW2Error_OK;
    
    switch (dataID) {
        case W2FormData_boxB:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->boxB = str;
            }
            break;
            
        case W2FormData_boxC:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->boxC = str;
            }
            break;
            
        case W2FormData_employerNameLine2:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->employerNameLine2 = str;
            }
            break;
            
        case W2FormData_addressType:
            std::cout << "Use setSelection() for the selected ID." << std::endl;
            break;
            
        case W2FormData_address:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->address = str;
            }
            break;
            
        case W2FormData_city:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->city = str;
            }
            break;
            
        case W2FormData_state:
            std::cout << "Use setSelection() for the selected ID." << std::endl;
            break;
            
        case W2FormData_zipCode:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->zipCode = str;
            }
            break;
            
        case W2FormData_box0_Age:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box0_Age = str;
            }
            break;
            
        case W2FormData_box0_Occupation:
            std::cout << "Use setSelection() for the selected ID." << std::endl;
            break;

        case W2FormData_box1:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box1 = str;
            }
            break;
            
        case W2FormData_box2:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box2 = str;
            }
            break;
            
        case W2FormData_box3:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box3 = str;
            }
            break;
            
        case W2FormData_box4:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box4 = str;
            }
            break;
            
        case W2FormData_box5:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box5 = str;
            }
            break;
            
        case W2FormData_box6:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box6 = str;
            }
            break;
            
        case W2FormData_box7:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box7 = str;
            }
            break;
            
        case W2FormData_box8:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box8 = str;
            }
            break;
            
        case W2FormData_box10:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box10 = str;
            }
            break;
            
        case W2FormData_box11:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box11 = str;
            }
            break;
            
        case W2FormData_box12LetterCode:
            std::cout << "Use setSelection() for the selected ID." << std::endl;
            break;
            
        case W2FormData_box12Amount:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box12Amount = str;
            }
            break;
            
        case W2FormData_box13SatutoryEmployee:
            std::cout << "Use setCheckBoxStatus() for the checkbox status." << std::endl;
            break;
            
        case W2FormData_box13RetirementPlan:
            std::cout << "Use setCheckBoxStatus() for the checkbox status." << std::endl;
            break;
            
        case W2FormData_box13ThirdPartySickPay:
            std::cout << "Use setCheckBoxStatus() for the checkbox status." << std::endl;
            break;
            
        case W2FormData_box14:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box14 = str;
            }
            break;
            
        case W2FormData_box14Amount:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box14Amount = str;
            }
            break;
            
        case W2FormData_box15:
            std::cout << "Use setSelection() for the selected ID." << std::endl;
            break;
            
        case W2FormData_box15EmployerStateID:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box15EmployerStateID = str;
            }
            break;
            
        case W2FormData_box16:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box16 = str;
            }
            break;
            
        case W2FormData_box17:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box17 = str;
            }
            break;
            
        case W2FormData_box18:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box18 = str;
            }
            break;
            
        case W2FormData_box19:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box19 = str;
            }
            break;
            
        case W2FormData_box20:
            success = this->checkField(str, dataID);
            if (success != kW2Error_Invalid) {
                this->box20 = str;
            }
            break;
            
        case W2FormData_box20AssociatedState:
            std::cout << "Use setSelection() for the selected ID." << std::endl;
            break;
            
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
            
        case W2FormData_address:
            str = this->address;
            break;
            
        case W2FormData_city:
            str = this->city;
            break;
            
        case W2FormData_zipCode:
            str = this->zipCode;
            break;
            
        case W2FormData_box0_Age:
            str = this->box0_Age;
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
            
        case W2FormData_box12Amount:
            str = this->box12Amount;
            break;
            
        case W2FormData_box14:
            str = this->box14;
            break;
            
        case W2FormData_box14Amount:
            str = this->box14Amount;
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
            
        default:
            break;
    }

    return str;
}

W2Error W2FormData::setSelection(int selectionID, W2FormDataID dataID)
{
//    bool success = false;
    W2Error success = kW2Error_Invalid;
    
    switch (dataID) {
        case W2FormData_addressType:
            this->addressType = selectionID;
            success = this->checkSelection(selectionID, dataID);
            break;
            
        case W2FormData_state:
            this->state = selectionID;
            success = this->checkSelection(selectionID, dataID);
            break;
            
        case W2FormData_box0_Occupation:
            this->box0_Occupation = selectionID;
            success = this->checkSelection(selectionID, dataID);
            break;
            
        case W2FormData_box12LetterCode:
            this->box12LetterCode = selectionID;
            success = this->checkSelection(selectionID, dataID);
            break;

        case W2FormData_box15:
            this->box15 = selectionID;
            success = this->checkSelection(selectionID, dataID);
            break;
            
        case W2FormData_box20AssociatedState:
            this->box20AssociatedState = selectionID;
            success = this->checkSelection(selectionID, dataID);
            break;
            
        default:
            break;
    }
    
    return success;
}

int W2FormData::getSelection(W2FormDataID dataID)
{
    int selectedID = 0;
    
    switch (dataID) {
        case W2FormData_addressType:
            selectedID = this->addressType;
            break;
            
        case W2FormData_state:
            selectedID = this->state;
            break;
            
        case W2FormData_box0_Occupation:
            selectedID = this->box0_Occupation;
            break;

        case W2FormData_box12LetterCode:
            selectedID = this->box12LetterCode;
            break;
            
        case W2FormData_box15:
            selectedID = this->box15;
            break;
            
        case W2FormData_box20AssociatedState:
            selectedID = this->box20AssociatedState;
            break;
            
        default:
            break;
    }
    return selectedID;
}

W2Error W2FormData::setCheckBoxStatus(CheckBoxStatus status, W2FormDataID dataID)
{
//    bool success = false;
    W2Error success = kW2Error_Invalid;
    
    switch (dataID) {
        case W2FormData_box13SatutoryEmployee:
            this->box13SatutoryEmployee = status;
            success = this->checkCheckBoxStatus(status, dataID);
            break;
            
        case W2FormData_box13RetirementPlan:
            this->box13RetirementPlan = status;
            success = this->checkCheckBoxStatus(status, dataID);
            break;
            
        case W2FormData_box13ThirdPartySickPay:
            this->box13ThirdPartySickPay = status;
            success = this->checkCheckBoxStatus(status, dataID);
            break;
            
        default:
            break;
    }
    
    return success;
}

CheckBoxStatus W2FormData::getFormCheckBoxStatus(W2FormDataID dataID)
{
    CheckBoxStatus status = kCheckBoxStatus_Off;
    
    switch (dataID) {
        case W2FormData_box13SatutoryEmployee:
            status = this->box13SatutoryEmployee;
            break;
            
        case W2FormData_box13RetirementPlan:
            status = this->box13RetirementPlan;
            break;
            
        case W2FormData_box13ThirdPartySickPay:
            status = this->box13ThirdPartySickPay;
            break;
            
            
        default:
            break;
    }

    return status;
}

std::string getQueryString()
{
    std::string query;
    
    return query;
}

