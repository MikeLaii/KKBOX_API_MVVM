//
//  API.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/19.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import RxSwift

class API {
    
    static let share = API()
    
    func fetchAPI(_ urlString:String , method:HttpMethod , body:Data? , header:[String:String]) -> Single<Data>{
        return Single<Data>.create(subscribe: { (single) -> Disposable in
            let url = URL.init(string: urlString)!
            var request = URLRequest.init(url: url)
            request.httpMethod = method.rawValue
            request.httpBody = body
            request.allHTTPHeaderFields = header
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data,_, error) in
                if let _ = error {
                    single(.error(APIError.error))
                }
                guard let data = data else{return}
                single(.success(data))
            })
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        })
    }
}
