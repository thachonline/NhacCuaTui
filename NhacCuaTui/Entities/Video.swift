//
//  Video.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 3/31/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import Foundation
struct Video: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    
    var description: String {
        return self.videoTitle
    }
    
    let videoKey : String
    let videoTitle : String
    let videoImage : String
    let artistName : String
    let time : String
    let likes : Int
    let views : Int
    let sharedLink : String
    let streamUrl : String
    let liked : Bool
    let downloadURL : String
    let streamURLs : [VideoQuality]
    let downloadURLs : [VideoQuality]
    let quality : String
    let artistId : Int
    let hasSubtitle : Bool
    let songKey : String
    let isDemo : Bool
    let advVast : Any
    let publicationDate : CLongLong
    let artistImage : String
    
    
    init?(response: HTTPURLResponse?, representation: Any) {
        guard
        let representation = representation as? [String: Any],
        let videoKey = representation["1"] as? String,
        let videoTitle = representation["2"] as? String,
        let videoImage = representation["3"] as? String,
        let artistName = representation["4"] as? String,
        let time = representation["5"] as? String,
        let likes =  representation["6"] as? Int,
        let views = representation["7"] as? Int,
        let sharedLink = representation["8"] as? String,
        let streamUrl = representation["9"] as? String,
        let liked = representation["10"] as? Bool,
        let downloadURL = representation["11"] as? String,
        let streamUrlArr = representation["12"] as? [Any],
        let downloadURLArr = representation["13"] as? [Any],
        let quality = representation["14"] as? String,
        let artistId = representation["15"] as? Int,
        let hasSubtitle = representation["16"] as? Bool,
        let songKey = representation["17"] as? String,
        let isDemo = representation["18"] as? Bool,
        let advVast = representation["19"]   ,
        let publicationDate = representation["20"] as? CLongLong,
            let artistImage = representation["21"] as? String else {
        
                return nil
        }
        
        
        self.videoKey = videoKey
        self.videoTitle = videoTitle
        self.videoImage = videoImage
        self.artistName = artistName
        self.time = time
        self.likes = likes
        self.views = views
        self.sharedLink = sharedLink
        self.streamUrl = streamUrl
        self.liked = liked
        self.downloadURL = downloadURL
        self.streamURLs = VideoQuality.collection(from: response, withRepresentation: streamUrlArr)
        self.downloadURLs = VideoQuality.collection(from: response, withRepresentation: downloadURLArr)
        self.quality = quality
        self.artistId = artistId
        self.hasSubtitle = hasSubtitle
        self.songKey = songKey
        self.isDemo = isDemo
        self.advVast = advVast
        self.publicationDate = publicationDate
        self.artistImage = artistImage
        
    }
    
    
    
    
    
    //video quality
    struct VideoQuality: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
        enum VideoType:String {
            case q240 = "240"
            case q360 = "360"
            case q480 = "480"
            case q720 = "720"
            case qHD = "1080"
        }
        
        var description: String {
            return "\(self.qualityType):\(self.streamUrl)"
        }
        
        let qualityType : VideoType
        let streamUrl : String
        let vipOnly : Bool
        let downloadUrl : String
        
        internal init?(response: HTTPURLResponse?, representation: Any) {
            guard
            let representation = representation as? [String: Any],
            let qualityType = representation["1"] as? String,
            let streamUrl = representation["2"] as? String,
            let vipOnly = representation["3"] as? Bool,
            let downloadUrl = representation["4"] as? String else {
                    return nil
            }
            
            self.qualityType = VideoType(rawValue: qualityType) != nil ? VideoType(rawValue: qualityType)! : .q240
            self.streamUrl = streamUrl
            self.vipOnly = vipOnly
            self.downloadUrl = downloadUrl
        
        }
        
    }
}
