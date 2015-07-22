//
//  SQLite.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/8/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#ifndef __ddteApp__SqLite__
#define __ddteApp__SqLite__

#include <iostream>
#include <sqlite3.h>
#include "SqLiteException.h"
#include "SqLiteDatabase.h"
#include "SqLiteQuery.h"
#include "SqLiteValue.h"

std::string getDMACode(std::string& zipCode);
void getRangeFromGeo(std::vector<std::string>& rowList, const std::string& dmaCode, const std::string& w2Field);
void getRangeFromAge(std::vector<std::string>& rowList, const std::string& ageBracket, const std::string& w2Field);
void getRangeFromOccupation(std::vector<std::string>& rowList, const std::string& occupation, const std::string& w2Field);

namespace SqLite
{
        
}  // namespace SQLite

#endif /* defined(__ddteApp__SqLite__) */
