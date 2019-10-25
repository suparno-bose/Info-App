//
//  ResponseModelTests.swift
//  Info-AppTests
//
//  Created by Suparno on 25/10/2019.
//  Copyright © 2019 BT. All rights reserved.
//

import XCTest

class ResponseModelTests: XCTestCase {
    
    func testSuccessfulJSONParsing() {
        let jsonString : String = """
        {
        "title":"About Canada",
        "rows":[
            {
            "title":"Beavers",
            "description":"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
            "imageHref":"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
            }]
        }
        """
            do {
                let jsonData = jsonString.data(using: .utf8)!
                let actual_response = try JSONDecoder().decode(ResponseModel.self, from: jsonData)
                // Success Persing JSON Model
            }
            catch {
                // Error thrown during json parsing
                XCTAssert(true, "Unable to parse json data")
            }
    }
    
    func testUnsuccessfulJSONParsing() {
        let jsonString : String = """
        {
        "name":"About Canada",
        "infos":[
            {
            "title":"Beavers",
            "description":"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
            "imageHref":"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
            }]
        }
        """
            do {
                let jsonData = jsonString.data(using: .utf8)!
                let response = try JSONDecoder().decode(ResponseModel.self, from: jsonData)
                // Success Persing JSON Model
            }
            catch {
                // Error thrown during json parsing
                XCTAssert(true, "Unable to parse json data")
            }
    }
}
