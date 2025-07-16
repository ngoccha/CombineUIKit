//
//  NameListTableViewCell.swift
//  UINaviVC
//
//  Created by iKame Elite Fresher 2025 on 6/26/25.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var wAh: UILabel!
    
    @IBAction func toProfile(_ sender: UIButton) {
        onProfileTapped?()
    }
    
    var onProfileTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configCell(name: String, weightAndHeight: String) {
        fullNameLabel.text = name
        wAh.text = weightAndHeight
    }
}
