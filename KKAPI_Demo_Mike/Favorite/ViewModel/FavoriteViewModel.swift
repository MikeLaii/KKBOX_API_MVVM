//
//  FavoriteViewModel.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/30.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FavoriteViewModel {
    
    struct FavoriteOutput {
        let dataList : Driver<[FavoriteData]>
    }
    var output : FavoriteOutput
    var dataListRelay : BehaviorRelay<[FavoriteData]>
    
    init() {
        let realmList = RealmManager.share.realm.objects(UserData.self).filter("token = '\(User.current.token)'").first!.favoriteList
        dataListRelay = BehaviorRelay.init(value: realmList.toArray(ofType: FavoriteData.self))
        output = FavoriteOutput.init(dataList: dataListRelay.asDriver())
    }
}
