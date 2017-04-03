//
//  Album.swift
//  NhacCuaTui
//
//  Created by Hoan Nguyen on 4/3/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import Foundation
struct Playlist: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    let playlistKey : String
    let playlistTitle : String
    let playlistCover : String
    let playlistImage : String
    let singerName : String
    let likes : Int
    let plays : Int
    let sharedLink : String
    let songKeys : [String]
    let liked : Bool
    let playlistDescription : String
    let totalSongs : Int
    
    var description: String {
        return self.playlistTitle
    }
    
    init?(response: HTTPURLResponse?, representation: Any) {
        guard
        let representation = representation as? [String: Any],
        let playlistKey = representation["1"] as? String,
        let playlistTitle = representation["2"] as? String,
        let playlistCover = representation["3"] as? String,
        let playlistImage = representation["4"] as? String,
        let singerName = representation["5"] as? String,
        let likes = representation["6"] as? Int,
        let plays = representation["7"] as? Int,
        let sharedLink = representation["8"] as? String,
        let songKeys = representation["9"] as? [String],
        let liked = representation["10"] as? Bool,
        let playlistDescription = representation["11"] as? String,
            let totalSongs = representation["12"] as? Int else {
                return nil
        }
        
        
        self.playlistKey = playlistKey
        self.playlistTitle = playlistTitle
        self.playlistCover = playlistCover
        self.playlistImage = playlistImage
        self.singerName = singerName
        self.likes = likes
        self.plays = plays
        self.sharedLink = sharedLink
        self.songKeys = songKeys
        self.liked = liked
        self.playlistDescription = playlistDescription
        self.totalSongs = totalSongs
        
        
    }
}
