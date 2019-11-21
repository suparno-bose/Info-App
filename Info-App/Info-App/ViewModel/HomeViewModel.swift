//
//  HomeViewModel.swift
//  Info-App
//
//  Created by Suparno on 22/10/2019.
//  Copyright © 2019 BT. All rights reserved.
//

import UIKit
import Toast_Swift

class HomeViewModel {
    // MARK: - UI variables
    var navigationBar   : UINavigationBar!
    var titleView       : UILabel!
    var factTableView   : UITableView!
    var view            : UIView!
    
    var refrehControllerValueChangeHandler : (()->())?
    
    init(view: UIView) {
        self.view = view
    }
    
    // MARK: - UI related methods∫
    func setupUI(){
        self.view.backgroundColor = Utility.THE_COLOR_WET_ASHFALT
        //Table View initialisation
        factTableView = UITableView(frame: CGRect.zero)
        factTableView.accessibilityIdentifier = AccessibilityIdentifiers.FactTableView.rawValue
        factTableView.backgroundColor = UIColor.clear
        self.view.addSubview(factTableView)
        factTableView.translatesAutoresizingMaskIntoConstraints = false
        factTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(2)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }

        factTableView.separatorColor = UIColor.gray
        factTableView.register(FactCellTableViewCell.self, forCellReuseIdentifier: FactCellTableViewCell.identifier)
        factTableView.estimatedRowHeight = 80
        factTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func setupNavigationBar(navController: UINavigationController) {
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.darkGray,
            NSAttributedStringKey.font: Utility.TITLE_FONT_LARGE
            ]
        navController.navigationBar.titleTextAttributes = attrs as Any as? [NSAttributedStringKey: Any]
        navController.navigationBar.backgroundColor = Utility.THE_COLOR_BALIZE_HOLE
    }
    
    func updateUI(navigationItem: UINavigationItem, titleText: String) {
        self.endRefreshing() // stop refresh controller before updating UI
        
        navigationItem.title = titleText
        self.factTableView.reloadData()
    }
    
    func showToast(type: ToastString) {
        self.view!.makeToast(type.rawValue,
                            duration: 3.0, position: .bottom)
    }
    
    @objc func addRefreshControl() {
        // Add refresh Controller to scrollview
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(self.refrehControllerValueChanged), for: UIControlEvents.valueChanged)
        rc.tintColor = UIColor.white
        self.factTableView.refreshControl = rc
    }
    
    func endRefreshing() {
        self.factTableView.refreshControl?.endRefreshing()
    }
    
    @objc func refrehControllerValueChanged() {
        self.refrehControllerValueChangeHandler!()
    }
}
