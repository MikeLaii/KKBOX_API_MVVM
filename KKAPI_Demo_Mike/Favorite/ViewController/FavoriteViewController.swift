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
        initial()
        binding()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushToAlbumDetailVC"{
            let vc = segue.destination as! AlbumDetailVC
            let data = sender as! AlbumData
            vc.albumData = data
            vc.navigationItem.title = data.name
        }
    }
}

extension FavoriteViewController{
    func initial(){
        viewModel = FavoriteViewModel()
        disposebag = DisposeBag()
    }
    func binding(){
        viewModel.output.dataList.asDriver(onErrorJustReturn: []).drive(tableView.rx.items(cellIdentifier: "FavoriteTVCellID", cellType: FavoriteTVCell.self)){
            (_,data,cell) in
            cell.setupCell(title: data.name, imageURL: data.imageURL)
        }.disposed(by: disposebag)
        tableView.rx.modelSelected(AlbumData.self).subscribe(onNext: { (data) in
            self.performSegue(withIdentifier: "pushToAlbumDetailVC", sender: data)
        }).disposed(by: disposebag)
    }
}
