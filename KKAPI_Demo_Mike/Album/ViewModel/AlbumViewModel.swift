//
//  AlbumViewModel.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/30.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AlbumViewModel {
    struct AlbumInput {
        var model : FavoriteData
    }
    struct AlbumOutput {
        let albumName : Driver<String>
        let albumReleaseDate : Driver<String>
        let albumImageURL : Driver<String>
        let artistName : Driver<String>
        let artistImageURL : Driver<String>
        var isFavorited : Driver<Bool>
    }
    var input : AlbumInput
    var output : AlbumOutput
    
    let albumNameRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    let albumReleaseDateRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    let albumImageURLRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    let artistNameRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    let artistImageURLRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    let isFavoritedRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    let PublishTap = PublishSubject<Void>()
    
    init(_ model : FavoriteData) {
        input = AlbumInput.init(model: model)
        output = AlbumOutput.init(albumName: albumNameRelay.asDriver(),
                                  albumReleaseDate: albumReleaseDateRelay.asDriver(),
                                  albumImageURL: albumImageURLRelay.asDriver(),
                                  artistName: artistNameRelay.asDriver(),
                                  artistImageURL: artistImageURLRelay.asDriver(),
                                  isFavorited: isFavoritedRelay.asDriver())
        setupData()
    }
}

extension AlbumViewModel{
    func setupData(){
        albumNameRelay.accept(input.model.albumName)
        albumReleaseDateRelay.accept(input.model.albumRelease)
        albumImageURLRelay.accept(input.model.albumImageURL)
        artistNameRelay.accept(input.model.albumArtistName)
        artistImageURLRelay.accept(input.model.albumArtistImageURL)
        isFavoritedRelay.accept(isFavorited())
        _ = PublishTap.bind { [weak self] _ in
            let nextState = !(self?.isFavoritedRelay.value)!
            self?.realmAccess(nextState, completion: { (success) in
                self?.isFavoritedRelay.accept(nextState)
            })
        }
    }
    func isFavorited() -> Bool{
        let realmData = RealmManager.share.realm.objects(FavoriteData.self)
        return realmData.filter("id = '\(input.model.id)'").count == 0 ? false : true
    }
    func realmAccess(_ isFavorited:Bool , completion:(Bool)->Void){
        let token = User.current.token
        let realm = RealmManager.share
        if isFavorited{
            if let userData = realm.realm.objects(UserData.self).filter("token = '\(token)'").first{
                let newList = userData.favoriteList
                realm.realm.beginWrite()
                newList.append(input.model)
                let newUserData = UserData.init(value: ["token":token,"favoriteList":newList])
                realm.realm.add(newUserData, update: true)
                do  {
                    try realm.realm.commitWrite()
                    completion(true)
                }catch{
                    completion(false)
                }
            }
        }else{
            if let object = realm.realm.objects(FavoriteData.self).filter("id = '\(input.model.id)'").first{
                input.model = FavoriteData.init(value: object)
                realm.realm.beginWrite()
                realm.realm.delete(object)
                do {
                    try realm.realm.commitWrite()
                    completion(true)
                }catch{
                    completion(false)
                }
            }
        }
    }
}
