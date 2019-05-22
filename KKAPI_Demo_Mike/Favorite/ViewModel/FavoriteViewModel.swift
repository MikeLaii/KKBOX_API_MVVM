//
//  FavoriteViewModel.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/30.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import RxCocoa
import RxSwift

class FavoriteViewModel {
    struct FavoriteOutput {
        let dataList : Driver<[AlbumData]>
    }
    var output : FavoriteOutput
    var dataListRelay : BehaviorRelay<[AlbumData]>
    
    init() {
        self.dataListRelay = BehaviorRelay.init(value: [])
        self.output = FavoriteOutput.init(dataList: dataListRelay.asDriver())
        self.getRealmList()
    }
    func getRealmList(){
        let realmList = RealmManager.share.realm.objects(UserData.self).filter("token = '\(User.current.token)'").first!.favoriteList
        self.dataListRelay.accept(realmList.toArray(ofType: AlbumData.self))
    }
}
