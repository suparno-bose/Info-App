//
//  Info_AppTests.swift
//  Info-AppTests
//
//  Created by Suparno on 09/10/2019.
//  Copyright © 2019 BT. All rights reserved.
//

import XCTest
@testable import Info_App

class Info_AppTests: XCTestCase {

    func testNeworkAPI(){
        NetworkManger.getInfoData { (info, error) in
            if let error = error{
                XCTAssert(true, "Unable to fetch info data")
            }
            else{
                // API success
            }
        }
    }

}
