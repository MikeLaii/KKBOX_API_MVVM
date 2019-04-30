//
//  PlayListTVCell.swift
//  KKAPI_Demo_Mike
//
//  Created by Mike Lai on 2019/4/22.
//  Copyright © 2019 Mike.Lai. All rights reserved.
//

import UIKit
import SDWebImage

class PlayListTVCell: UITableViewCell {

    @IBOutlet weak var coverPhoto: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension PlayListTVCell{
    func setupCell( title: String, imageURL : String){
        titleLabel.text = title
        coverPhoto.sd_setImage(with: URL.init(string: imageURL)!, completed: nil)
    }
}
