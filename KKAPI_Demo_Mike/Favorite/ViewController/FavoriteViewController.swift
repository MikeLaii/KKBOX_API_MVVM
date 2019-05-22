//
//  FavoriteViewController.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/19.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FavoriteViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel : FavoriteViewModel!
    var disposebag : DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.initial()
        self.binding()
    }
}
extension FavoriteViewController : ViewControllerProtocol{
    func initial(){
        self.viewModel = FavoriteViewModel()
        self.disposebag = DisposeBag()
    }
    func binding(){
        self.viewModel.output.dataList.asDriver(onErrorJustReturn: []).drive(tableView.rx.items(cellIdentifier: "FavoriteTVCellID", cellType: FavoriteTVCell.self)){
            (_,data,cell) in
            cell.setupCell(title: data.name, imageURL: data.imageURL)
            }.disposed(by: self.disposebag)
        self.tableView.rx.modelSelected(AlbumData.self).subscribe(onNext:{ [weak self](data) in
            self?.push(Album, data: data)
        }).disposed(by: self.disposebag)
    }
    func push(_ vc:String , data:AlbumData){
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vc) as! AlbumDetailVC
        vc.navigationItem.title = data.name
        vc.albumData = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
