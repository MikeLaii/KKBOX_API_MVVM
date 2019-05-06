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

//MARK: - fetch UserToken
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
            let body = ["grant_type": APIBody.grantType.rawValue,
                        "client_id":APIBody.clientID.rawValue,
                        "client_secret":APIBody.clientSecret.rawValue]
            let data = body.toString().data(using: .utf8)!
            let header = ["Content-Type": APIHeader.contentType.rawValue]
            _ = API.share.fetchAPI(APIURL.oauth.rawValue, method: .post, body: data, header: header).subscribe(onSuccess: { (data) in
                if let json = try? JSONDecoder.init().decode(OauthData.self, from: data){
                    if let token = json.access_token {
                        single(.success(token))
                    }else{
                        print(json.error!)
                    }
                }
            }, onError: { (error) in
                single(.error(error))
            })
            return Disposables.create()
        })
    }
}

//MARK: - fetch PlayList
extension User{
    func fetchPlayList(type:PlayListType,id:String?) -> Single<Data> {
        return Single<Data>.create(subscribe: { (single) -> Disposable in
            var path : String = APIURL.playList.rawValue
            switch type {
            case .playList:
                path = path + APIURL.territory.rawValue  + APIURL.limit.rawValue
            case .playListDetail:
                path = path + "/" + (id ?? "") + APIURL.territory.rawValue
            }
            let header : [String:String] = ["Authorization":APIHeader.authorization.rawValue + User.current.token]
            _ = API.share.fetchAPI(path, method: .get, body: nil, header: header).subscribe(onSuccess: { (data) in
                single(.success(data))
            }, onError: { (error) in
                single(.error(error))
            })
            return Disposables.create()
        })
    }
}
