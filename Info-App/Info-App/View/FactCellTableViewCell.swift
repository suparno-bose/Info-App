//
//  FactCellTableViewCell.swift
//  Info-App
//
//  Created by Suparno on 09/10/2019.
//  Copyright © 2019 BT. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit
import HexColors

class FactCellTableViewCell: UITableViewCell {
    static let identifier = "FactCell"
    var iconView : UIImageView!
    var titleLabel : UILabel!
    var descriptionLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        super.textLabel?.removeFromSuperview()
        super.imageView?.removeFromSuperview()

        self.selectionStyle = .none
        
        self.addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        backgroundColor = UIColor.clear
    }
    
    func addSubViews(){
        addImageView()
        addTitleLabel()
        addDescriptionLabel()
    }
    
    func addImageView() {
        self.iconView = UIImageView(frame: CGRect.zero)
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        self.contentView.addSubview(self.iconView)
        
        iconView.layer.borderWidth = 2
        iconView.layer.borderColor = UIColor.white.cgColor
        iconView.layer.cornerRadius = 5

        iconView.translatesAutoresizingMaskIntoConstraints = false
        self.iconView!.snp.updateConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.leading.equalTo(self.contentView)
            make.height.equalTo(90)
            make.width.equalTo(90)
            make.bottom.equalTo(contentView).offset(-8).priority(500)
        }
        
        iconView.accessibilityIdentifier = AccessibilityIdentifiers.FactImageView.rawValue
    }
    
    func addTitleLabel() {
        self.titleLabel = UILabel(frame: CGRect.zero)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.text = ""
        self.titleLabel.textColor = Utility.THE_COLOR_CLOUD
        self.titleLabel.font = Utility.TITLE_FONT_MEDIUM
        self.contentView.addSubview(self.titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel!.snp.updateConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.leading.equalTo(self.iconView!.snp.trailing).offset(8)
            make.trailing.equalTo(self.contentView).offset(8)
        }
        titleLabel.accessibilityIdentifier = AccessibilityIdentifiers.FactTitleLabel.rawValue
    }
    
    func addDescriptionLabel() {
        self.descriptionLabel = UILabel(frame: CGRect.zero)
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.text = ""
        self.descriptionLabel.textColor = Utility.THE_COLOR_SILVER
        self.descriptionLabel.font = Utility.TITLE_FONT_SMALL
        self.contentView.addSubview(self.descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel!.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel!.snp.bottom).offset(8)
            make.leading.equalTo(self.iconView!.snp.trailing).offset(8)
            make.bottom.equalTo(self.contentView).offset(-8)
            make.trailing.equalTo(self.contentView)
        }
        descriptionLabel.accessibilityIdentifier = AccessibilityIdentifiers.FactDescriptionLabel.rawValue
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func update(with data: ResponseModel.InfoModel) {
        self.titleLabel?.text = data.title
        self.descriptionLabel?.text = data.description
        if let urlString = data.imageHref {
            self.iconView?.sd_setImage(with: URL(string: urlString),
                                       placeholderImage: Utility.DEFAULT_IMAGE, options: .fromLoaderOnly,
                                        completed: {(image, error, cacheType, url) in })
        }else{
            self.iconView?.image = Utility.DEFAULT_IMAGE
        }
        
    }
}
