//
//  FactCellTableViewCell.swift
//  Info-App
//
//  Created by Suparno on 09/10/2019.
//  Copyright © 2019 BT. All rights reserved.
//

import UIKit
import SDWebImage

class FactCellTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func update(with data: InfoModel) {
        self.textLabel?.text = data.title
        self.detailTextLabel?.text = data.description
        if let urlString = data.imageHref {
            self.imageView?.sd_setImage(with: URL(string: urlString),
                                        placeholderImage: UIImage(named: "default"), options: .progressiveLoad,
                                        completed: {(image, error, cacheType, url) in })
        }else{
            self.imageView?.image = UIImage(named: "default")
        }
        
    }
}
