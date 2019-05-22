//
//  TrackViewModel.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/30.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

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
        self.dataListRelay = BehaviorRelay.init(value: [])
        self.input = TrackInput.init(id: id)
        self.output = TrackOutput.init(dataList: dataListRelay.asDriver())
        self.getTrackList()
    }
    func getTrackList(){
        _ = User.current.fetchPlayList(type: .playListDetail, id: input.id).subscribe(onSuccess: { [weak self](data) in
            if let json = try? JSONDecoder().decode(PlayListDataByID.self, from: data ){
                self?.dataListRelay.accept(json.tracks.data)
            }
        }, onError: nil)
    }
}
