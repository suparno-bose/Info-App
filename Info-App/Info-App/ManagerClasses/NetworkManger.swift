//
//  NetworkManger.swift
//  Info-App
//
//  Created by Suparno on 09/10/2019.
//  Copyright © 2019 BT. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case networkError(description: String)
    case jsonError
    case noDataError
}

class NetworkManger: NSObject {
    
    static func getInfoData(callBackHandler : @escaping (ResponseModel?, Error?) -> ()) {
        if let url = URL(string: Utility.DATA_URL) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    callBackHandler(nil, NetworkError.networkError(description: error.localizedDescription))
                }
                else{
                    if let jsonString = String(data: data!, encoding: .ascii){
                        do {
                            let jsonData = jsonString.data(using: .utf8)!
                            let response = try JSONDecoder().decode(ResponseModel.self, from: jsonData)
                            callBackHandler(response, nil)
                        }
                        catch {
                            // Error thrown during json parsing
                            callBackHandler(nil,NetworkError.jsonError)
                        }
                    }
                    else{
                        //Data is Empty
                        callBackHandler(nil, NetworkError.noDataError)
                    }
                }
            }).resume()
        }
    }
}
