//
//  InfoModel.swift
//  Info-App
//
//  Created by Suparno on 09/10/2019.
//  Copyright © 2019 BT. All rights reserved.
//

import UIKit
import ObjectMapper

class InfoModel: Mappable {
    
    var title : String = ""
    var description : String = ""
    var imageHref : String?
    
    convenience required init?(map: Map) {
        self.init()
    }

    // Mappable
    func mapping(map: Map) {
        title    <- map["title"]
        description <- map["description"]
        imageHref <- map["imageHref"]
    }
}

