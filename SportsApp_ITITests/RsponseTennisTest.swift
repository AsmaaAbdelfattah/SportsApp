//
//  RsponseTennisTest.swift
//  SportsApp_ITITests
//
//  Created by Asmaa_Abdelfattah on 24/11/1401 AP.
//

//
//  ResponseBasketballTest.swift
//  SportsApp_ITITests
//
//  Created by Asmaa_Abdelfattah on 24/11/1401 AP.
//

import XCTest
@testable import SportsApp_ITI
final class NetworkServicesTennisTest : XCTestCase{
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
    func testTennisFetchingApi(){
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.fetch (url: "\(mainUrl)tennis/?met=Leagues&APIkey=\(APIkey)", compiletionHandler: { data in
            guard let response : LeguesData = data else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(response.result.count, 0 , "tennis Api Failed")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5,handler: nil)
    }
 
//    func testEventstennisApi(){
//        let expectation = expectation(description: "Waiting for API")
//        
//        NetworkService.fetch (url: "https://apiv2.allsportsapi.com/tennis/?met=Fixtures&leagueId=2833&from=2023-02-09&to=2024-02-09&APIkey=\(APIkey)", compiletionHandler: { data in
//            guard let response : EventsData = data else
//            {
//                XCTFail()
//                expectation.fulfill()
//                return
//            }
//            XCTAssertNotEqual(response.result.count, 0 , "tennis Events Api Failed")
//            expectation.fulfill()
//        })
//        waitForExpectations(timeout: 5,handler: nil)
//    }
//    func testTeamsTennisApi(){
//        let expectation = expectation(description: "Waiting for API")
//        
//        NetworkService.fetch (url: "https://apiv2.allsportsapi.com/tennis/?met=Teams&?met=Leagues&leagueId=2833&APIkey=\(APIkey)", compiletionHandler: { data in
//            guard let response : TeamData = data else
//            {
//                XCTFail()
//                expectation.fulfill()
//                return
//            }
//            XCTAssertNotEqual(response.result.count, 0 , "Tennis Teams Api Failed")
//            expectation.fulfill()
//        })
//        waitForExpectations(timeout: 5,handler: nil)
//    }
}

