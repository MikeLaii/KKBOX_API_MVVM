//
//  AlbumDetailVC.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/24.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AlbumDetailVC: UIViewController {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumDateLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var viewModel : AlbumViewModel!
    var albumData : AlbumData!
    var disposeBag : DisposeBag!
    var button : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
        setupBarButtonItem()
        binding()
    }
}

extension AlbumDetailVC : ViewControllerProtocol {
    func initial(){
        disposeBag = DisposeBag()
        viewModel = AlbumViewModel.init(albumData)
    }
    func setupBarButtonItem(){
        button = UIButton()
        button.tintColor = #colorLiteral(red: 0.8413805962, green: 0.3514380455, blue: 0.2925212979, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
    }
    func binding(){
        viewModel.output.albumName.drive(albumNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.albumReleaseDate.drive(albumDateLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.artistName.drive(artistNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.albumImageURL.asObservable().bind{ [weak self](url) in
            self?.albumImageView.sd_setImage(with: URL.init(string: url)!, completed: nil)
        }.disposed(by: disposeBag)
        viewModel.output.artistImageURL.asObservable().bind{ [weak self](url) in
            self?.artistImageView.sd_setImage(with: URL.init(string: url)!, completed: nil)
            }.disposed(by: disposeBag)
        viewModel.output.isFavorited.asObservable().bind{ [weak self](isFavorite) in
            if isFavorite{
                self?.button.setImage(UIImage.init(named: "fullLove"), for: .normal)
            }else{
                self?.button.setImage(UIImage.init(named: "defaultLove"), for: .normal)
            }
            }.disposed(by: disposeBag)
        button.rx.tap.subscribe(viewModel.publishTap).disposed(by: disposeBag)
    }
}
