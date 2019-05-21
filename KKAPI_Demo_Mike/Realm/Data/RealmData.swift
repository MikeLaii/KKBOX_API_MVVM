//
//  RealmData.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/19.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import RealmSwift

class UserData: Object {

    @objc dynamic var token : String = ""
    dynamic var favoriteList = List<AlbumData>()
    
    override static func primaryKey() -> String? {
        return "token"
    }
}

class AlbumData : Object{
    
    @objc dynamic var id: String = ""
    @objc dynamic var name : String = ""
    @objc dynamic var imageURL : String = ""
    @objc dynamic var albumName : String = ""
    @objc dynamic var albumImageURL : String = ""
    @objc dynamic var albumRelease : String = ""
    @objc dynamic var albumArtistName : String = ""
    @objc dynamic var albumArtistImageURL : String = ""
    
    override static func primaryKey() -> String {
        return "id"
    }

    func setData(data : PlayListDataByIDTracksData) {
        self.id = data.id
        self.name = data.name
        self.imageURL = data.album.images.first!.url
        self.albumName = data.album.name
        self.albumImageURL = data.album.images.last!.url
        self.albumRelease = data.album.release_date
        self.albumArtistName = data.album.artist.name
        self.albumArtistImageURL = data.album.artist.images.first!.url
    }
}

