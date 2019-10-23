//
//  ResponseModel.swift
//  Info-App
//
//  Created by Suparno on 09/10/2019.
//  Copyright © 2019 BT. All rights reserved.
//

import UIKit

class ResponseModel: Codable {
    
    struct InfoModel: Codable {
        var title : String?
        var description : String?
        var imageHref : String?
    }
    
    var title : String?
    var rows : [InfoModel]?
}
