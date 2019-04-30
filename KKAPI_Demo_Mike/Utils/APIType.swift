//
//  APIType.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/19.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit

enum HttpMethod : String {
    case post = "POST"
    case get = "GET"
}
enum APIURL : String{
    case Oauth = "https://account.kkbox.com/oauth2/token"
    case PlayList = "https://api.kkbox.com/v1.1/featured-playlists"
    case PlayListTerritory = "?territory=TW"
    case limit = "&limit=50"
}
enum APIHeader : String {
    case ContentType = "application/x-www-form-urlencoded"
    case Auth = "Bearer "
}
enum APIBody : String {
    case GrantType = "client_credentials"
    case ClientID = "59e7e92bd24b67830e1fb44c7769d41c"
    case ClientSecret = "459fc993b023fc4e518046f46f5645db"
}
enum PlayListType {
    case PlayList
    case PlayListDetail
}
enum APIError:Error {
    case error
    case decodeFail
}
