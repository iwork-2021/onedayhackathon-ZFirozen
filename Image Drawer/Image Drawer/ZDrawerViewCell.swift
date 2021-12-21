//
//  ZDrawerViewCell.swift
//  Image Drawer
//
//  Created by ZFirozen on 2021/12/21.
//

import UIKit

class ZDrawerViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    weak var imageSets: ZImageSets?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
