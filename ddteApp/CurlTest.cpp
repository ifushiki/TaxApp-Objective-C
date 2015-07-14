//
//  CurlTest.cpp
//  ddteApp
//
//  Created by Fushiki, Ikko on 7/13/15.
//  Copyright (c) 2015 Fushiki, Ikko. All rights reserved.
//

#include "CurlTest.h"
#include <string>

CURLcode CurlTest::Post(std::string& url, std::string* data) {
    
    // clear things ready for our 'fetch'
    mHttpStatus = 0;
    mContent.clear();
    mHeaders.clear();
    
    // set our callbacks
    curl_easy_setopt(pCurlHandle , CURLOPT_WRITEFUNCTION, HttpContent);
    curl_easy_setopt(pCurlHandle, CURLOPT_HEADERFUNCTION, HttpHeader);
    curl_easy_setopt(pCurlHandle, CURLOPT_WRITEDATA, this);
    curl_easy_setopt(pCurlHandle, CURLOPT_WRITEHEADER, this);
    
//    std::string data = "data: {title: 'foo2',body: 'bar', userId: 1}";
//    curl_easy_setopt(pCurlHandle, CURLOPT_POSTFIELDS, "name=daniel&project=curl");
    if (data) {
        curl_easy_setopt(pCurlHandle, CURLOPT_POSTFIELDS, data->c_str());
    }
    
    // set the URL we want
    curl_easy_setopt(pCurlHandle, CURLOPT_URL, url.c_str());
    
    //  go get 'em, tiger
    CURLcode curlErr = curl_easy_perform(pCurlHandle);
    if (curlErr == CURLE_OK){
        
        // assuming everything is ok, get the content type and status code
        char* content_type = NULL;
        if ((curl_easy_getinfo(pCurlHandle, CURLINFO_CONTENT_TYPE,
                               &content_type)) == CURLE_OK)
            mType = std::string(content_type);
        
        unsigned int http_code = 0;
        if((curl_easy_getinfo (pCurlHandle, CURLINFO_RESPONSE_CODE,
                               &http_code)) == CURLE_OK)
            mHttpStatus = http_code;
        
    }
    return curlErr;
}

CURLcode CurlTest::Get(std::string& url) {
    return this->Post(url, NULL);
/*
    
    // clear things ready for our 'fetch'
    mHttpStatus = 0;
    mContent.clear();
    mHeaders.clear();
    
    // set our callbacks
    curl_easy_setopt(pCurlHandle , CURLOPT_WRITEFUNCTION, HttpContent);
    curl_easy_setopt(pCurlHandle, CURLOPT_HEADERFUNCTION, HttpHeader);
    curl_easy_setopt(pCurlHandle, CURLOPT_WRITEDATA, this);
    curl_easy_setopt(pCurlHandle, CURLOPT_WRITEHEADER, this);
    
    std::string data = "data: {title: 'foo2',body: 'bar', userId: 1}";
    //    curl_easy_setopt(pCurlHandle, CURLOPT_POSTFIELDS, "name=daniel&project=curl");
    curl_easy_setopt(pCurlHandle, CURLOPT_POSTFIELDS, data.c_str());
    
    // set the URL we want
    curl_easy_setopt(pCurlHandle, CURLOPT_URL, url.c_str());
    
    //  go get 'em, tiger
    CURLcode curlErr = curl_easy_perform(pCurlHandle);
    if (curlErr == CURLE_OK){
        
        // assuming everything is ok, get the content type and status code
        char* content_type = NULL;
        if ((curl_easy_getinfo(pCurlHandle, CURLINFO_CONTENT_TYPE,
                               &content_type)) == CURLE_OK)
            mType = std::string(content_type);
        
        unsigned int http_code = 0;
        if((curl_easy_getinfo (pCurlHandle, CURLINFO_RESPONSE_CODE,
                               &http_code)) == CURLE_OK)
            mHttpStatus = http_code;
        
    }
    return curlErr;
 */
}

size_t CurlTest::HttpContent(void* ptr, size_t size,
                          size_t nmemb, void* stream) {
    
    CurlTest* handle = (CurlTest*) stream;
    size_t data_size = size*nmemb;
    if (handle != NULL){
        handle->mContent.append((char *)ptr,data_size);
    }
    return data_size;
}

size_t CurlTest::HttpHeader(void* ptr, size_t size,
                         size_t nmemb, void* stream) {
    
    CurlTest* handle = (CurlTest*) stream;
    size_t data_size = size*nmemb;
    if (handle != NULL){
        std::string header_line((char *)ptr,data_size);
        handle->mHeaders.push_back(header_line);
    }
    return data_size;
}