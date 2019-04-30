//
//  User.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/29.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class User {
    static let current = User()
    var token : String {
        get{
            return UserDefaults.standard.string(forKey: "token") ?? ""
        }
        set{
            return UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
}

extension User {
    func getToken() -> Single<String>{
        return Single<String>.create(subscribe: { (single) -> Disposable in
            if User.current.token.isEmpty{
                _ = self.fetchToken().subscribe(onSuccess: { (token) in
                    User.current.token = token
                    single(.success(token))
                }, onError: { (error) in
                    single(.error(error))
                })
            }else{
                single(.success(User.current.token))
            }
            return Disposables.create()
        })
    }
    
    func fetchToken()->Single<String>{
        return Single<String>.create(subscribe: { (single) -> Disposable in
            let body = ["grant_type": APIBody.GrantType.rawValue,"client_id":APIBody.ClientID.rawValue,"client_secret":APIBody.ClientSecret.rawValue]
            let data = body.toString().data(using: .utf8)!
            
            let header = ["Content-Type": APIHeader.ContentType.rawValue]
            _ = API.share.fetchAPI(APIURL.Oauth.rawValue, method: .post, body: data, header: header).subscribe(onSuccess: { (data) in
                if let json = try? JSONDecoder.init().decode(UserInfo.self, from: data){
                    if let token = json.access_token {
                        single(.success(token))
                    }else{
                        single(.error(APIError.error))
                    }
                }
            }, onError: { (error) in
                single(.error(error))
            })
            return Disposables.create()
        })
    }
}

extension User{
    func fetchPlayList(type:PlayListType,id:String?) -> Single<Data> {
        return Single<Data>.create(subscribe: { (single) -> Disposable in
            var path : String = APIURL.PlayList.rawValue
            switch type {
            case .PlayList:
                path = path + APIURL.PlayListTerritory.rawValue  + APIURL.limit.rawValue
            case .PlayListDetail:
                path = path + "/" + (id ?? "") + APIURL.PlayListTerritory.rawValue
            }
            let header : [String:String] = ["Authorization":APIHeader.Auth.rawValue + User.current.token]
            _ = API.share.fetchAPI(path, method: .get, body: nil, header: header).subscribe(onSuccess: { (data) in
                single(.success(data))
            }, onError: { (error) in
                single(.error(error))
            })
            return Disposables.create()
        })
    }
}
