//
//  ViewController.swift
//  Info-App
//
//  Created by Suparno on 09/10/2019.
//  Copyright © 2019 Wipro. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManger.getInfoData { (info, error) in
            if let error = error{
                
            }
            else{
                
            }
        }
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.4, alpha: 1.0)
    }


}

