//
//  TableViewCell.swift
//  APIClosure
//
//  Created by Ngọc Anh on 6/5/18.
//  Copyright © 2018 Ngọc Anh. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameVnText: UITextField!
    @IBOutlet weak var nameEnText: UITextField!
    
    @IBOutlet weak var leveText: UITextField!
   
    @IBOutlet weak var imagePhotoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
