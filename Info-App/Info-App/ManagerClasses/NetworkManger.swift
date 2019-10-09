//
//  NetworkManger.swift
//  Info-App
//
//  Created by Suparno on 09/10/2019.
//  Copyright © 2019 BT. All rights reserved.
//

import UIKit

let DATA_URL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

class NetworkManger: NSObject {

    static func getInfoData(callBackHandler : @escaping (InfoModel?, Error?) -> ()) {
        if let url = URL(string: DATA_URL) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    callBackHandler(nil, error)
                }
                else{
                    callBackHandler(InfoModel(), nil)
                }
            }).resume()
        }
    }
    
}
