//
//  APIType.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/19.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//


enum HttpMethod : String {
    case post = "POST"
    case get = "GET"
}
enum APIURL : String{
    case oauth = "https://account.kkbox.com/oauth2/token"
    case playList = "https://api.kkbox.com/v1.1/featured-playlists"
    case territory = "?territory=TW"
    case limit = "&limit=50"
}
enum APIHeader : String {
    case contentType = "application/x-www-form-urlencoded"
    case authorization = "Bearer "
}
enum APIBody : String {
    case grantType = "client_credentials"
    case clientID = "59e7e92bd24b67830e1fb44c7769d41c"
    case clientSecret = "459fc993b023fc4e518046f46f5645db"
}
enum PlayListType {
    case playList
    case playListDetail
}
enum APIError:Error {
    case error
    case decodeFail
}
