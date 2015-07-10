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

namespace SqLite
{
    
    
    /**
     * @brief Encapsulation of the error message from SQLite3, based on std::runtime_error.
     */
    class Exception : public std::runtime_error
    {
    public:
        /**
         * @brief Encapsulation of the error message from SQLite3, based on std::runtime_error.
         *
         * @param[in] aErrorMessage The string message describing the SQLite error
         */
        explicit Exception(const std::string& aErrorMessage) : std::runtime_error(aErrorMessage)
        {
        }
    };
    
    
}  // namespace SQLite

namespace SqLite {

}

#endif /* defined(__ddteApp__SqLite__) */
