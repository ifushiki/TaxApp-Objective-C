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
    this->box13SatutoryEmployee = kCheckBoxStatus_Off;
    this->box13RetirementPlan = kCheckBoxStatus_Off;
    this->box13ThirdPartySickPay = kCheckBoxStatus_Off;
    this->box15 = kState_Unspecified;
    this->box20AssociatedState = kState_Unspecified;
}

W2Error W2FormData::checkField(std::string& str, W2FormDataID dataID)
{
    // Not implemented yet.  Simply retuns a warning for now.
    return kW2Error_Warning;
}

W2Error W2FormData::checkSelection(int selectionID, W2FormDataID dataID)
{
    // Not implemented yet.  Simply retuns a warning for now.
    return kW2Error_Warning;
}

W2Error W2FormData::checkCheckBoxStatus(CheckBoxStatus status, W2FormDataID dataID)
{
    // Not implemented yet.  Simply retuns a warning for now.
    return kW2Error_Warning;
}

std::string W2FormData::getErrorMessage()
{
    // Not fully implemented.  But return the same error message now.
    this->errorMessage  = "Are you sure you typed the data correctly?";
    
    return this->errorMessage;
}

W2Error W2FormData::setField(std::string& str, W2FormDataID dataID)
{
    W2Error success = kW2Error_Invalid;
    
    switch (dataID) {
        case W2FormData_boxB:
            this->boxB = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_boxC:
            this->boxC = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_employerNameLine2:
            this->employerNameLine2 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_addressType:
            std::cout << "Use setSelection() for the selected ID." << std::endl;
            break;
            
        case W2FormData_address:
            this->address = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_city:
            this->city = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_state:
            std::cout << "Use setSelection() for the selected ID." << std::endl;
            break;
            
        case W2FormData_zipCode:
            this->zipCode = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box1:
            this->box1 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box2:
            this->box2 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box3:
            this->box3 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box4:
            this->box4 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box5:
            this->box5 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box6:
            this->box6 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box7:
            this->box7 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box8:
            this->box8 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box10:
            this->box10 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box11:
            this->box11 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box12LetterCode:
            std::cout << "Use setSelection() for the selected ID." << std::endl;
            break;
            
        case W2FormData_box12Amount:
            this->box12Amount = str;
            success = this->checkField(str, dataID);
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
            this->box14 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box14Amount:
            this->box14Amount = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box15:
            std::cout << "Use setSelection() for the selected ID." << std::endl;
            break;
            
        case W2FormData_box15EmployerStateID:
            this->box15EmployerStateID = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box16:
            this->box16 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box17:
            this->box17 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box18:
            this->box18 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box19:
            this->box19 = str;
            success = this->checkField(str, dataID);
            break;
            
        case W2FormData_box20:
            this->box20 = str;
            success = this->checkField(str, dataID);
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
