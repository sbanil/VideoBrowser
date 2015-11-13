//
//  VideoModel.swift
//  VideoBrowser
//
//  Created by Sanghubattla, Anil on 11/7/15.
//  Copyright © 2015 teamcakes. All rights reserved.
//

import Foundation
import UIKit

class VideoModel {
    
    var videoId : Int = 0
    var videoName : String?
    var artists : String?
    var brands : String?
    var directors: String?
    var fps: Int = 0
    var posterImage: UIImage?
    var productCount: Int = 0
    var segmentCount: Int = 0
    var status: String?
    var timestamp: String?
    var userId: Int
    var videoLength: Int = 0
    var videoLocationType: String?
    var videoOperations: String?
    var videoType: String?
    var videoLocationUrl: String?
    
    init?(json: NSDictionary) {
        
        self.videoName = json["videoName"] as? String
        self.videoId = json["videoId"] as! Int
        self.artists = json["artists"] as? String
        self.brands = json["brands"] as? String
        self.directors = json["directors"] as? String
        self.fps = json["userId"] as! Int
        let posterImageString = json["posterImage"] as? String
        let decodedData = NSData(base64EncodedString: posterImageString!, options: NSDataBase64DecodingOptions(rawValue: 0))
        self.posterImage = UIImage(data: decodedData!)
        
        self.productCount = json["productCount"] as! Int
        self.segmentCount = json["segmentCount"] as! Int
        self.status = json["status"] as? String
        self.timestamp = json["timestamp"] as? String
        self.userId = json["userId"] as! Int
        self.videoLength = json["videoLength"] as! Int
        self.videoLocationType = json["videoLocationType"] as? String
        self.videoName = json["videoName"] as? String
        self.videoOperations = json["videoOperations"] as? String
        self.videoType = json["videoType"] as? String
        self.videoLocationUrl = json["videoLocationUrl"] as? String
    }
}