//
//  SearchItemCell.swift
//  MediaWiki
//

import UIKit

class SearchItemCell: UITableViewCell {
    @IBOutlet weak var fu_title: UILabel!
    @IBOutlet weak var fu_description: UILabel!
    
    @IBOutlet weak var fu_price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    var fuudel:SearchItemModel? {
        didSet {
            self.fu_title.text = fuudel?.ProductName
            self.fu_description.text = fuudel?.SDetails
    }
        
    }
}
