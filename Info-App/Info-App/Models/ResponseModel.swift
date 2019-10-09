//
//  ResponseModel.swift
//  Info-App
//
//  Created by Suparno on 09/10/2019.
//  Copyright © 2019 BT. All rights reserved.
//

import UIKit
import ObjectMapper

class ResponseModel: Mappable {
    
    var title : String?
    var infoArray : [InfoModel]?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        title    <- map["title"]
        infoArray <- map["rows"]
    }
}
