//
//  ViewController.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/18.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model : SignInModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
        requestAuth()
    }
}

extension ViewController {
    
    func initial(){
        model = SignInModel()
        print("file url:\(RealmManager.share.realm.configuration.fileURL!)")
    }
    func requestAuth(){
        model.defaultSignIn { (completion) in
            if completion{
                self.performSegue(withIdentifier: "pushToTabBarVC", sender: nil)
            }
        }
    }
}
