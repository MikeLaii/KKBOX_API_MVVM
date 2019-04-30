//
//  ViewController.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/18.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    var model : SigninModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
        requestAuth()
    }
}

extension ViewController {

    func initial(){
        model = SigninModel()
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
