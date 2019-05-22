//
//  TrackVC.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/30.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrackVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : TrackViewModel!
    var disposeBag : DisposeBag!
    var id : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initial()
        self.binding()
    }
}

extension TrackVC : ViewControllerProtocol {
    func initial(){
        self.disposeBag = DisposeBag()
        self.viewModel = TrackViewModel.init(id)
    }
    func binding(){
        self.viewModel.output.dataList.asDriver(onErrorJustReturn: []).drive(tableView.rx.items(cellIdentifier: "TrackTVCellID", cellType: TrackTVCell.self)){
            (row,data,cell) in
            cell.setupCell(title: data.name, imageURL: data.album.images.first!.url)
        }.disposed(by: self.disposeBag)
        self.tableView.rx.modelSelected(PlayListDataByIDTracksData.self).subscribe(onNext: { [weak self](data) in
            let albumData = AlbumData()
            albumData.setData(data: data)
            self?.push(Album, data: albumData)
        }).disposed(by: self.disposeBag)
    }
    func push(_ vc:String , data:AlbumData){
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vc) as! AlbumDetailVC
        vc.navigationItem.title = data.name
        vc.albumData = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
