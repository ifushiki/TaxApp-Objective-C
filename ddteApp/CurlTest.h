//
//  CurlTest.h
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/13/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#ifndef __ddteApp__CurlTest__
#define __ddteApp__CurlTest__

#include <iostream>
#include <string>
#include <vector>
#include <curl/curl.h>

class CurlTest {
private:
    std::string        mContent;
    std::string        mType;
    std::vector<std::string>       mHeaders;
    unsigned int       mHttpStatus;
    CURL*              pCurlHandle;
    static size_t      HttpContent(void* ptr, size_t size,
                                   size_t nmemb, void* stream);
    static size_t      HttpHeader(void* ptr, size_t size,
                                  size_t nmemb, void* stream);
    
public:
    CurlTest(): pCurlHandle(curl_easy_init()){};  // constructor
    ~CurlTest(){};

    // NULL data will call Get(url).
    CURLcode Post (std::string& url, std::string* data);
    CURLcode Get (std::string& url);
    
    inline std::string   Content()    const { return mContent; }
    inline std::string   Type()       const { return mType; }
    inline unsigned int  HttpStatus() const { return mHttpStatus; }
    inline std::vector<std::string>   Headers()    const { return mHeaders; }
};

#endif /* defined(__ddteApp__Curly__) */
