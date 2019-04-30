//
//  RealmManager.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/23.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import RealmSwift

enum WriteType {
    case add
    case delete
}

class RealmManager {
    
    static let share = RealmManager()
    let realm : Realm
    
    private init() {
        self.realm = try! Realm()
    }
    
    func tryWrite(_ object : Object ,type:WriteType, complete:(Bool)->Void){
        do {
            try self.realm.write {
                switch type{
                case .add : self.realm.add(object, update: true)
                case .delete :
                    self.realm.delete(object)
                }
            }
            complete(true)
        } catch {
            complete(false)
        }
    }
}
