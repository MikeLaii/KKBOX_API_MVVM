//
//  AlertManager.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/5/22.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit

class AlertManager {
    static let share = AlertManager()
    
    func showMessage(_ message:String , delegate:ViewController){
        let alertVC = UIAlertController.init(title: message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "ok", style: .default, handler: nil)
        alertVC.addAction(action)
        delegate.show(alertVC, sender: nil)
    }
}
