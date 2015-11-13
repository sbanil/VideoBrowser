//
//  ServiceHelper.swift
//  VideoBrowser
//
//  Created by Sanghubattla, Anil on 11/11/15.
//  Copyright © 2015 teamcakes. All rights reserved.
//

import Foundation

class ServiceHelper {
    
    let VIDEO_LIST_URL = "https://s18613401.onlinehome-server.com:9443/PoyntSi/PoyntsiService/Video/getListByUserId?userName=u&password=u"
    
    
    func retrieveVideoList(OnSucess: (videoList: NSArray) -> Void, OnFailure: (errorDesc: String) -> Void) -> Void
    {
        var errorFlag: Bool = false
        var errorDescription: String = ""
        
        guard let url = NSURL(string: VIDEO_LIST_URL) else {
            errorDescription = "Error: cannot create URL"
            print(errorDescription)
            errorFlag = true
            return
        }

        let urlRequest = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: {
            (data, response, error) in
            guard let responseData = data else {
                errorDescription = "Error: did not receive data: "
                print(errorDescription)
                errorFlag = true
                return
            }
            guard error == nil else {
                errorDescription = "error calling GET on /PoyntSi/PoyntsiService/Video/getListByUserId: " + error!.description
                print(errorDescription)
                errorFlag = true
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            let videoList: NSArray
            do {
                videoList = try NSJSONSerialization.JSONObjectWithData(responseData,
                    options: []) as! NSArray
            } catch  {
                errorDescription = "ERROR: Unable to convert JSON to NSDictionary: " + responseData.description
                print(errorDescription)
                errorFlag = true
                return
            }
            
            if errorFlag {
                dispatch_async(dispatch_get_main_queue(), {
                    OnFailure(errorDesc: errorDescription)
                });
                
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    OnSucess(videoList: videoList)
                });
            }
          
        })
        
        task.resume()
    }
    
    
}