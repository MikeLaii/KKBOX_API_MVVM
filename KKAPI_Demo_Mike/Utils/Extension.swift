//
//  Extension.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/29.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

extension Dictionary where Key == String {
    func toString() -> String{
        var str = String()
        for (key,value) in self{
            str.append("\(key)=\(value)&")
        }
        str.removeLast()
        return str
    }
}

extension UIImageView {
    func setImage(_ urlString: String){
        self.sd_setImage(with: URL.init(string: urlString)!, completed: nil)
    }
}

extension List {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
