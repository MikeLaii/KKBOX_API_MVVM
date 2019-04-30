//
//  PlayListDataByID.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/22.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit

class PlayListDataByID : Codable{
    var title : String
    var id : String
    var tracks : PlayListDataByIDTracks
    var images : [PlayListDataDetailImage]
    var url : String
    var description : String
}

class PlayListDataByIDTracks : Codable{
    var data : [PlayListDataByIDTracksData]
}

class PlayListDataByIDTracksData :Codable{
    var name : String
    var url : String
    var explicitness : Bool
    var album : TracksDataAlbum
    var id : String
    var track_number : Int
    var duration : Int
    var available_territories : [String]
}

class TracksDataAlbum : Codable{
    var artist : TracksDataAlbumArtist
    var images : [PlayListDataDetailImage]
    var id : String
    var available_territories : [String]
    var name : String
    var explicitness : Bool
    var url : String
    var release_date : String
}

class TracksDataAlbumArtist :Codable{
    var name : String
    var id : String
    var url : String
    var images : [PlayListDataDetailImage]
}
