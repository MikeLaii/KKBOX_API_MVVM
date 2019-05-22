//
//  PlayListViewModel.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/29.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PlayListViewModel {
 
    struct PlayListOutput {
        let dataList : Driver<[PlayListDataDetail]>
    }
    var output : PlayListOutput
    let dataListRelay : BehaviorRelay<[PlayListDataDetail]>
    
    init() {
        self.dataListRelay = BehaviorRelay.init(value: [])
        self.output = PlayListOutput.init(dataList: dataListRelay.asDriver())
        self.getPlayList()
    }
    
    func getPlayList(){
        _ = User.current.fetchPlayList(type: .playList, id: nil).subscribe(onSuccess: { [weak self](data) in
            if let json = try? JSONDecoder().decode(PlayListData.self, from:data ){
                self?.dataListRelay.accept(json.data)
            }
        }, onError: nil)
    }
}
