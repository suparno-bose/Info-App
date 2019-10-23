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
    
    // MARK: - UI related methods
    func setupUI(){
        //Navigationbar beautification

        
        self.view.backgroundColor = UIColor("#34495e") // Wet Ashfalt
        //Table View initialisation
        factTableView = UITableView(frame: CGRect.zero)
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
        factTableView.register(FactCellTableViewCell.self, forCellReuseIdentifier: "FactCell")
        factTableView.estimatedRowHeight = 80
        factTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func setupNavigationBar(navController: UINavigationController) {
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.darkGray,
            NSAttributedStringKey.font: UIFont(name: "Raleway-Light", size: 28.0)
            ]
        navController.navigationBar.titleTextAttributes = attrs as Any as? [NSAttributedStringKey: Any]
        navController.navigationBar.backgroundColor = UIColor("#34495e") // Balize hole
    }
    
    func updateUI(navigationItem: UINavigationItem, titleText: String) {
        self.endRefreshing() // stop refresh controller before updating UI
        
        navigationItem.title = titleText
        self.factTableView.reloadData()
    }
    
    func showToast(type: Toast_String) {
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
