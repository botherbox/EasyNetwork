//
//  EasyNetworkTests.swift
//  EasyNetworkTests
//
//  Created by BotherBox on 15/3/3.
//  Copyright (c) 2015年 sz. All rights reserved.
//

import UIKit
import XCTest

class EasyNetworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestJSON() {
        let urlString = "http://localhost/getJSON.php"
        let worker = EasyNetwork()
        
        let ex = expectationWithDescription("期望 - GET with none")
        
        // GET - none param
        worker.requestJSONWithURL(urlString, method: .GET, params: nil) { (data, error) -> Void in
            println("data - \(data)")
            println("error - \(error)")
            ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(1.0 as NSTimeInterval, handler: { (error) -> Void in
            println("expectation - \(error)")
        })
        
        
        let ex1 = expectationWithDescription("期望 － GET with params")
        // GET - with param
        worker.requestJSONWithURL(urlString, method: .GET, params: ["param": "YES"]) { (data, error) -> Void in
            println("data - \(data)")
            println("error - \(error)")
            ex1.fulfill()
        }
        waitForExpectationsWithTimeout(1.0 as NSTimeInterval, handler: { (error) -> Void in
            println("expectation - \(error)")
        })
        
        // POST - with param
        let ex2 = expectationWithDescription("期望 － POST with params")
        worker.requestJSONWithURL(urlString, method: .POST, params: ["param": "YES"]) { (data, error) -> Void in
            println("data - \(data)")
            println("error - \(error)")
            ex2.fulfill()
        }
        waitForExpectationsWithTimeout(1.0 as NSTimeInterval, handler: { (error) -> Void in
            println("expectation - \(error)")
        })
    }
    
    func testCreatRequest() {
        
        let urlString = "http://www.baidu.com"
        var params: [String: String]?
        var method = HTTPMethod.GET
        // Get- Zero param
        let worker = EasyNetwork()
        var req: NSURLRequest?

        req = worker.creatRequest(urlString, method: method, params: params)
        println("\(req)")
        
        // GET - Some Params
        params = ["name":"Tom", "age":"18"]
        req = worker.creatRequest(urlString, method: method, params: params)
        println("\(req)")
        
        method = HTTPMethod.POST
        // POST - none params
        params = [String: String]()
        req = worker.creatRequest(urlString, method: method, params: params)
        println("\(req)")
        
        // POST - some params
        params = ["amount": "1000"]
        req = worker.creatRequest(urlString, method: method, params: params)
        println("\(req)")
        
    }
    
    func testParseParams() {
        
        // Test when the params is Nil
        var params: [String: String]?
        println("-----")
        println(EasyNetwork.networker.parseParams(params))
        println("-----")
        
        params = [String: String]()
        println()
        println(EasyNetwork.networker.parseParams(params))
        println()
        
        // Test Normal
        params = ["name": "Jack", "age": "18", "Mob": ""]
        let re = EasyNetwork.networker.parseParams(params)
        println(re)
//        XCTAssert(re == "name=Jack&age=18&Mob=", "解析错误")
        
//        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
