//
//  SigninModel.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/30.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit

class SignInModel {
    
    func defaultSignIn(completion:@escaping (Bool)->Void){
        _ = User.current.getToken().subscribe(onSuccess: { (token) in
            if !token.isEmpty{
                DispatchQueue.main.async {
                    let realm = RealmManager.share
                    if realm.realm.objects(UserData.self).filter("token = '\(token)'").count != 0{
                        completion(true)
                    }else{
                        let userData = UserData()
                        userData.token = token
                        realm.tryWrite(userData, type: .add, complete: { (success) in
                            if success{
                                completion(true)
                            }else{
                                completion(false)
                            }
                        })
                    }
                }
            }else{
                completion(false)
            }
        })
    }
}
