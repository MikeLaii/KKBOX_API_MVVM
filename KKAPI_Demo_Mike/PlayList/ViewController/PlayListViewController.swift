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
        initial()
        binding()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushToTrackVC" {
            let vc = segue.destination as! TrackVC
            let data = sender as! PlayListDataDetail
            vc.navigationItem.title = data.title
            vc.id = data.id
        }
    }
}

extension PlayListViewController {
    func initial(){
        viewModel = PlayListViewModel()
        disposeBag = DisposeBag()
    }
    func binding(){
        viewModel.output.dataList.asDriver(onErrorJustReturn: []).drive(tableView.rx.items(cellIdentifier: "PlayListCell", cellType: PlayListTVCell.self)){
            (_,data,cell)in
            cell.setupCell(title: data.title, imageURL: data.images.first!.url)
            }.disposed(by: disposeBag)
        tableView.rx.modelSelected(PlayListDataDetail.self).subscribe(onNext: { [weak self](data) in
            self?.performSegue(withIdentifier: "pushToTrackVC", sender: data)
        }).disposed(by: disposeBag)
    }
}
