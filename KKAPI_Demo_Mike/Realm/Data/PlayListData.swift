//
//  PlayListData.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/22.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//


class PlayListData : Codable {
    var data : [PlayListDataDetail]
}
class PlayListDataDetail : Codable{
    var id : String
    var description: String
    var title : String
    var url : String
    var images : [PlayListDataDetailImage]
}
class PlayListDataDetailImage : Codable {
    var url: String
    var height: Int
    var width: Int
}
