//
//  TimeAgoTests.swift
//  TimeAgoTests
//
//  Created by LawLincoln on 2016/12/1.
//  Copyright © 2016年 SelfStudio. All rights reserved.
//

import XCTest
@testable import TimeAgo
class TimeAgoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let date = Date(timeIntervalSince1970: 1460370965)
        print(date.timeAgoSinceNow())
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
