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
import Reachability
class HomeViewController: UIViewController {

    var viewModel : HomeViewModel!
    // MARK: - Data variables
    var responseData : ResponseModel?
    // MARK: -
    var reachability : Reachability?
    
    // MARK: - Life-cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HomeViewModel(view: self.view)
        if let navigationController = self.navigationController {
            viewModel.setupNavigationBar(navController: navigationController)
        }
        
        viewModel.setupUI()
        viewModel.factTableView.dataSource = self
        viewModel.refrehControllerValueChangeHandler = {
            self.fetchInfoData()
        }
        
        self.navigationItem.accessibilityLabel = "Navigation Title"
        //Initialise Reachability
        do {
            reachability = try Reachability()
            reachability?.whenUnreachable = { _ in
                self.viewModel.showToast(type: ToastString.Connection_Problem)
            }
            do {
                try reachability?.startNotifier()
            } catch {
                // Unable to start notifier
            }
        } catch {
            // Unable to start notifier
        }
        fetchInfoData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.addRefreshControl()
    }

    // MARK: - Data mannagement methods
    @objc func fetchInfoData() {
        guard reachability?.connection != .none else{
            viewModel.endRefreshing()
            self.viewModel.showToast(type: ToastString.Connection_Problem)
            return
        }
        NetworkManger.getInfoData { (responseModel, error) in
            if error != nil{
                DispatchQueue.main.async {
                    self.viewModel.endRefreshing()
                    self.viewModel.showToast(type: ToastString.Server_Unreachable)
                }
            }
            else{
                self.responseData = responseModel
                DispatchQueue.main.async {
                    self.viewModel.endRefreshing()
                    self.viewModel.updateUI(navigationItem: self.navigationItem, titleText: self.responseData!.title!)
                }
            }
        }
    }

}

// MARK: - UITableViewDataSource methods
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseData?.rows?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FactCellTableViewCell.identifier, for: indexPath) as! FactCellTableViewCell
        cell.accessibilityIdentifier = AccessibilityIdentifiers.FactCellTableViewCell.rawValue + String(indexPath.row)
        cell.update(with: (responseData?.rows![indexPath.item])!)
        return cell
    }
}
