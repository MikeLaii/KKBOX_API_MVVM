//
//  TrackViewModel.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/30.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TrackViewModel {
    struct TrackInput {
        var id : String
    }
    struct TrackOutput {
        var dataList : Driver<[PlayListDataByIDTracksData]>
    }
    var input : TrackInput
    var output : TrackOutput
    var dataListRelay : BehaviorRelay<[PlayListDataByIDTracksData]>
    
    init(_ id : String) {
        dataListRelay = BehaviorRelay.init(value: [])
        input = TrackInput.init(id: id)
        output = TrackOutput.init(dataList: dataListRelay.asDriver())
        getTrackList()
    }
    
    func getTrackList(){
        _ = User.current.fetchPlayList(type: .playListDetail, id: input.id).subscribe(onSuccess: { (data) in
            if let json = try? JSONDecoder().decode(PlayListDataByID.self, from: data ){
                self.dataListRelay.accept(json.tracks.data)
            }
        }, onError: nil)
    }
}
