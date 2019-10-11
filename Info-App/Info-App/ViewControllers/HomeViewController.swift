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

class HomeViewController: UIViewController {

    // MARK: - UI variables
    var navigationBar   : UINavigationBar!
    var titleView       : UILabel!
    var factTableView   : UITableView!
    // MARK: - Data variables
    var responseData : ResponseModel?
    
    // MARK: - Life-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchInfoData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - UI related methods
    func setupUI(){
        self.view.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.4, alpha: 1.0)
        
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
        
        factTableView.register(FactCellTableViewCell.self, forCellReuseIdentifier: "FactCell")
        factTableView.estimatedRowHeight = 80
        factTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func updateUI() {
        self.navigationItem.title = responseData?.title
        self.factTableView.reloadData()
    }
    
    // MARK: - Data mannagement methods
    func fetchInfoData() {
        NetworkManger.getInfoData { (responseModel, error) in
            if error != nil{
                
            }
            else{
                self.responseData = responseModel
                DispatchQueue.main.async {
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
