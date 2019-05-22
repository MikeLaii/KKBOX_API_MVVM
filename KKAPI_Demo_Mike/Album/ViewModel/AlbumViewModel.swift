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
        var model : AlbumData
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
    
    let publishTap = PublishSubject<Void>()
    
    init(_ model : AlbumData) {
        self.input = AlbumInput.init(model: model)
        self.output = AlbumOutput.init(albumName: self.albumNameRelay.asDriver(),
                                  albumReleaseDate: self.albumReleaseDateRelay.asDriver(),
                                  albumImageURL: self.albumImageURLRelay.asDriver(),
                                  artistName: self.artistNameRelay.asDriver(),
                                  artistImageURL: self.artistImageURLRelay.asDriver(),
                                  isFavorited: self.isFavoritedRelay.asDriver())
        self.setupData()
    }
}

extension AlbumViewModel{
    func setupData(){
        self.albumNameRelay.accept(input.model.albumName)
        self.albumReleaseDateRelay.accept(input.model.albumRelease)
        self.albumImageURLRelay.accept(input.model.albumImageURL)
        self.artistNameRelay.accept(input.model.albumArtistName)
        self.artistImageURLRelay.accept(input.model.albumArtistImageURL)
        self.isFavoritedRelay.accept(isFavorited())
        _ = publishTap.bind { [weak self] _ in
            let nextState = !(self?.isFavoritedRelay.value)!
            self?.realmAccess(nextState, completion: { (success) in
                self?.isFavoritedRelay.accept(nextState)
            })
        }
    }
    func isFavorited() -> Bool{
        let realmData = RealmManager.share.realm.objects(AlbumData.self)
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
            if let object = realm.realm.objects(AlbumData.self).filter("id = '\(self.input.model.id)'").first{
                self.input.model = AlbumData.init(value: object)
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
