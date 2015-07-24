//
//  W2FormTypes.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/17/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#ifndef ddteApp_W2FormTypes_h
#define ddteApp_W2FormTypes_h

typedef enum {
    kW2Error_OK = 0,
    kW2Error_Warning = 1,
    kW2Error_Invalid = -1,
} W2Error;

// This matches with the index ID of State popup menu.
typedef enum {
    kState_Unspecified = 0,
    kState_Alabama,
    kState_Alaska,
    kState_Arizona,
    kState_Arkansas,
    kState_California,
    kState_Colorado,
    kState_Connecticut,
    kState_Delaware,
    kState_Florida,
    kState_Georgia,
    
    kState_Hawaii,
    kState_Idaho,
    kState_Illinois,
    kState_Indiana,
    kState_Iowa,
    kState_Kansas,
    kState_Kentucky,
    kState_Louisiana,
    kState_Maine,
    kState_Maryland,
    
    kState_Massachussetts,
    kState_Michigan,
    kState_Minnesota,
    kState_Mississippi,
    kState_Missouri,
    kState_Montana,
    kState_Nebraska,
    kState_Nevada,
    kState_NewHampshire,
    kState_NewJersey,
    
    kState_NewMexico,
    kState_NewYork,
    kState_NorthCarolina,
    kState_NorthDakoda,
    kState_Ohio,
    kState_Oklahoma,
    kState_Oregon,
    kState_Pennsylvania,
    kState_RhodoIsland,
    kState_SouthCarolina,
    
    kState_SouthDakota,
    kState_Tennessee,
    kState_Texas,
    kState_Utah,
    kState_Vermont,
    kState_Virginia,
    kState_Washington,
    kState_WestVerginia,
    kState_Wisconsin,
    kState_Wyoming,
} StateAbbreviationID;

// Box 12 Letter Code
// This is the same as index id of the popup menu in Box 12.
typedef enum {
    kLetterCode_Unspecified = 0,
    kLetterCode_A,
    kLetterCode_B,
    kLetterCode_C,
    kLetterCode_D,
    kLetterCode_E,
    kLetterCode_F,
    kLetterCode_G,
    kLetterCode_H,
    kLetterCode_J,
    kLetterCode_K,
    kLetterCode_L,
    kLetterCode_M,
    kLetterCode_N,
    kLetterCode_P,
    kLetterCode_Q,
    kLetterCode_R,
    kLetterCode_S,
    kLetterCode_T,
    kLetterCode_V,
    kLetterCode_W,
    kLetterCode_Y,
    kLetterCode_Z,
    kLetterCode_AA,
    kLetterCode_BB,
    kLetterCode_DD,
    kLetterCode_EE,
} W2FormLetterCode;

typedef enum
{
    kCheckBoxStatus_Off = 0,
    kCheckBoxStatus_On = 1,
    kCheckBoxStatus_Mixed = -1,
} CheckBoxStatus;

typedef enum
{
    kAddressType_Invalid = 0,
    kAddressType_US,
    kAddressType_Canada,
} W2FormAddressType;

typedef enum {
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
    // Extra fields needed for Query (Boxes 0)
    //-----------------------------------------------------------------------------------------------------------
    W2FormData_box0_Age,              // Age
    W2FormData_box0_Occupation,       // Occupation
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
} W2FormDataID;

typedef enum {
    kOccupationType_Unspecified = 0,
    accounting_supervisor,
    kOccupationType_art_conservator,
    kOccupationType_art_teacher,
    kOccupationType_auto_body_technician,
    kOccupationType_banquet_chef,
    kOccupationType_billing_representative,
    kOccupationType_bryologist,
    kOccupationType_budget_analyst,
    kOccupationType_bus_driver,
    kOccupationType_car_washer,
    kOccupationType_chief_executive_officer,
    kOccupationType_child_care_worker,
    kOccupationType_claims_processor,
    kOccupationType_cleaning_service,
    kOccupationType_clinic_director,
    kOccupationType_courtroom_clerk,
    kOccupationType_debt_collector,
    kOccupationType_defense_contractor,
    kOccupationType_deli,
    kOccupationType_dental_office_manager,
    kOccupationType_detention_deputy,
    kOccupationType_diabetes_educator,
    kOccupationType_diesel_technician,
    kOccupationType_dog_bather,
    kOccupationType_drywall_hanger,
    kOccupationType_dsp,
    kOccupationType_electrical_drafter,
    kOccupationType_elevator_constructor,
    kOccupationType_facility_manager,
    kOccupationType_financial,
    kOccupationType_food_scientist,
    kOccupationType_funeral_arranger,
    kOccupationType_gis_specialist,
    kOccupationType_hospice_social_worker,
    kOccupationType_hostess,
    kOccupationType_hr_assistant,
    kOccupationType_independent_consultant,
    kOccupationType_inside_sales_rep,
    kOccupationType_law_enforcement,
    kOccupationType_limousine_driver,
    kOccupationType_logistics_planner,
    kOccupationType_lpta,
    kOccupationType_maintenance_manager,
    kOccupationType_maintenance_supervisor,
    kOccupationType_maintenance_technician,
    kOccupationType_mason,
    kOccupationType_material_expediter,
    kOccupationType_medical_scientist,
    kOccupationType_meteorologist,
    kOccupationType_municipal_clerk,
    kOccupationType_neurologist,
    kOccupationType_occ,
    kOccupationType_parking_attendant,
    kOccupationType_payroll_clerk,
    kOccupationType_pharmacist_technician,
    kOccupationType_pharmacy_assistant,
    kOccupationType_phlebotomist,
    kOccupationType_port_captain,
    kOccupationType_prison_guard,
    kOccupationType_production,
    kOccupationType_production_engineer,
    kOccupationType_professor,
    kOccupationType_radiologist,
    kOccupationType_radiology_technologist,
    kOccupationType_risk_management,
    kOccupationType_rn,
    kOccupationType_sahm,
    kOccupationType_sales_person,
    kOccupationType_school_bus_mechanic,
    kOccupationType_security_manager,
    kOccupationType_service,
    kOccupationType_sheet_metal_worker,
    kOccupationType_shipper,
    kOccupationType_software_architect,
    kOccupationType_software_programmer,
    kOccupationType_software_tester,
    kOccupationType_songwriter,
    kOccupationType_sous_chef,
    kOccupationType_specialist,
    kOccupationType_state_employee,
    kOccupationType_teacher_aide,
    kOccupationType_team_leader,
    kOccupationType_tool_maker,
    kOccupationType_township_clerk,
    kOccupationType_truckdriver,
    kOccupationType_veterinary_assistant,
    kOccupationType_volunteer_coordinator,
    kOccupationType_xray_tech,
} W2FormOccupationType;

#endif
