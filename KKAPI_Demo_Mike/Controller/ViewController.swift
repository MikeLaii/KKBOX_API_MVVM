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
        self.initial()
        self.quickSignIn()
    }
}
extension ViewController {
    func initial(){
        self.model = SignInModel()
        print("file url:\(RealmManager.share.realm.configuration.fileURL!)")
    }
    func quickSignIn(){
        self.model.defaultSignIn { (completion) in
            if completion{
                let sb = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "TabVC") as! TabBarViewController
                self.show(vc, sender: nil)
            }else{
                AlertManager.share.showMessage("無法取得token！\n請檢查kkbox id是否過期。", delegate: self)
            }
        }
    }
}
