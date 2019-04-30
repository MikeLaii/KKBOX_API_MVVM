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
    
    var id : String!
    var viewModel : TrackViewModel!
    var disposeBag : DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
        binding()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushToAlbumDetailVC"{
            let vc = segue.destination as! AlbumDetailVC
            let data = sender as! FavoriteData
            vc.albumData = data
            vc.navigationItem.title = data.name
        }
    }
}

extension TrackVC  {
   
    func initial(){
        viewModel = TrackViewModel.init(id)
        disposeBag = DisposeBag()
    }
    func binding(){
        viewModel.output.dataList.asDriver(onErrorJustReturn: []).drive(tableView.rx.items(cellIdentifier: "TrackTVCellID", cellType: TrackTVCell.self)){
            (row,data,cell) in
            cell.setupCell(title: data.name, imageURL: data.album.images.first!.url)
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected(PlayListDataByIDTracksData.self).subscribe(onNext: { (data) in
            let newData = FavoriteData()
            newData.setData(data: data)
            self.performSegue(withIdentifier: "pushToAlbumDetailVC", sender: newData)
        }).disposed(by: disposeBag)
    }
    
}
