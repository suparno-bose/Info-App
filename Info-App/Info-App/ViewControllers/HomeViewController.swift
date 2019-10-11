//
//  ViewController.swift
//  Info-App
//
//  Created by Suparno on 09/10/2019.
//  Copyright © 2019 Wipro. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit
import HexColors
import EasyLoadingShimmer
import Toast_Swift
import Reachability
class HomeViewController: UIViewController {

    // MARK: - UI variables
    var navigationBar   : UINavigationBar!
    var titleView       : UILabel!
    var factTableView   : UITableView!
    // MARK: - Data variables
    var responseData : ResponseModel?
    // MARK: -
    let reachability = Reachability()!
    
    // MARK: - Life-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        //Initialise Reachability
        reachability.whenUnreachable = { _ in
            self.view.makeToast("Please check your internet connection...", duration: 3.0, position: .bottom)
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        fetchInfoData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.addRefreshControl()
    }
    
    // MARK: - UI related methods
    func setupUI(){
        //Navigationbar beautification
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.darkGray,
            NSAttributedStringKey.font: UIFont(name: "Raleway-Light", size: 28.0)
            ]
        navigationController?.navigationBar.titleTextAttributes = attrs as Any as? [NSAttributedStringKey: Any]
        navigationController?.navigationBar.backgroundColor = UIColor("#34495e") // Balize hole
        
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
        
        factTableView.dataSource = self
        factTableView.separatorColor = UIColor.gray
        factTableView.register(FactCellTableViewCell.self, forCellReuseIdentifier: "FactCell")
        factTableView.estimatedRowHeight = 80
        factTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func updateUI() {
        self.navigationItem.title = responseData?.title
        self.factTableView.reloadData()
    }
    
    @objc func addRefreshControl() {
        // Add refresh Controller to scrollview
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(self.fetchInfoData), for: UIControlEvents.valueChanged)
        rc.tintColor = UIColor.white
        self.factTableView.refreshControl = rc
    }
    
    func endRefreshing() {
        self.factTableView.refreshControl?.endRefreshing()
    }
    
    // MARK: - Data mannagement methods
    @objc func fetchInfoData() {
        guard reachability.connection != .none else{
            self.endRefreshing()
            self.view.makeToast("Please check your internet connection...", duration: 3.0, position: .bottom)
            return
        }
        
        EasyLoadingShimmer.startCovering(for: self.factTableView, with: ["Loading..", "Loading..", "Loading..", "Loading.."])
        NetworkManger.getInfoData { (responseModel, error) in
            if error != nil{
                DispatchQueue.main.async {
                    self.endRefreshing()
                    self.view.makeToast("Unable to reach to the server. Try after some time...", duration: 3.0, position: .bottom)
                }
            }
            else{
                self.responseData = responseModel
                DispatchQueue.main.async {
                    self.endRefreshing()
                    EasyLoadingShimmer.stopCovering(for: self.factTableView)
                    self.updateUI()
                }
            }
        }
    }

}

// MARK: - UITableViewDataSource methods
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseData?.infoArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FactCell", for: indexPath) as! FactCellTableViewCell
        cell.update(with: (responseData?.infoArray![indexPath.item])!)
        return cell
    }
}
