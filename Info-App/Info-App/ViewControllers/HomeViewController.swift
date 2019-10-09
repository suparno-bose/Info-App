//
//  ViewController.swift
//  Info-App
//
//  Created by Suparno on 09/10/2019.
//  Copyright © 2019 Wipro. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    var navigationBar: UINavigationBar!
    var factTableView: UITableView!
    
    var responseData : ResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchInfoData()
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.4, alpha: 1.0)
        
        let navigationBarHeight = 60 + UIApplication.shared.statusBarFrame.size.height
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0,
                                                      width: self.view.frame.width, height: navigationBarHeight))
        self.view.addSubview(navigationBar)
        
        factTableView = UITableView(frame: CGRect(x: 0, y: navigationBarHeight,
                                                  width: self.view.frame.width,
                                                  height: self.view.frame.height - navigationBarHeight))
        factTableView.dataSource = self
        factTableView.delegate = self
        self.view.addSubview(factTableView)
        factTableView.register(FactCellTableViewCell.self, forCellReuseIdentifier: "FactCell")
        factTableView.estimatedRowHeight = 80
        factTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func updateUI() {
        self.navigationBar.topItem?.title = responseData?.title
        self.factTableView.reloadData()
    }
    
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

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseData?.infoArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "FactCell", for: indexPath) as! FactCellTableViewCell
//        if cell == nil {
//            cell = FactCellTableViewCell(style: .default, reuseIdentifier: "FactCell")
//        }
        cell.update(with: (responseData?.infoArray![indexPath.item])!)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate{
    
}

