//
//  PlayListViewController.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/19.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PlayListViewController: UIViewController  {
    @IBOutlet weak var tableView: UITableView!
    var viewModel : PlayListViewModel!
    var disposeBag : DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initial()
        self.binding()
    }
}
extension PlayListViewController : ViewControllerProtocol{
    func initial(){
        self.viewModel = PlayListViewModel()
        self.disposeBag = DisposeBag()
    }
    func binding(){
        self.viewModel.output.dataList.asDriver(onErrorJustReturn: []).drive(tableView.rx.items(cellIdentifier: "PlayListCell", cellType: PlayListTVCell.self)){
            (_,data,cell)in
            cell.setupCell(title: data.title, imageURL: data.images.first!.url)
            }.disposed(by: self.disposeBag)
        self.tableView.rx.modelSelected(PlayListDataDetail.self).subscribe(onNext:{ [weak self](data) in
            self?.push(Track, data: data)
        }).disposed(by: self.disposeBag)
    }
    func push(_ vc:String , data:PlayListDataDetail){
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vc) as! TrackVC
        vc.navigationItem.title = data.title
        vc.id = data.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
