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

    weak var lightsMeaningLabel: UILabel!
    weak var circularBGView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchInfoData()
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.4, alpha: 1.0)
    }
    
    func updateUI() {
        
    }
    
    func fetchInfoData() {
        NetworkManger.getInfoData { (info, error) in
            if error != nil{
                
            }
            else{
                self.updateUI()
            }
        }
    }

}

