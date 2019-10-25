//
//  Define.swift
//  Info-App
//
//  Created by Suparno on 22/10/2019.
//  Copyright © 2019 BT. All rights reserved.
//

import Foundation
import HexColors

enum ToastString : String {
    case Connection_Problem = "Please check your internet connection..."
    case Server_Unreachable = "Unable to reach to the server. Try after some time..."
}

let DATA_URL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

let THE_COLOR_WET_ASHFALT = UIColor("#34495e") // Wet Ashfalt
let THE_COLOR_BALIZE_HOLE  = UIColor("#34495e") // Balize hole
let THE_COLOR_SILVER = UIColor("##bdc3c7") //Silver
let THE_COLOR_CLOUD = UIColor("#ecf0f1") //Cloud

let TITLE_FONT_LARGE =  UIFont(name: "Raleway-Light", size: 28.0)
let TITLE_FONT_MEDIUM =  UIFont(name: "Raleway-Light", size: 24.0)
let TITLE_FONT_SMALL = UIFont(name: "Raleway-Regular", size: 18.0)

let DEFAULT_IMAGE = UIImage(named: "default")
