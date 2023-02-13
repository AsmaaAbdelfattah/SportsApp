//
//  NetworkServicesForcricketTests.swift
//  SportsApp_ITITests
//
//  Created by Zeinab on 12/02/2023.
//

import XCTest
@testable import SportsApp_ITI
final class NetworkServicesForcricketTests: XCTestCase {

    override func setUpWithError() throws {
       
    }

    override func tearDownWithError() throws {
        
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchForCricketLeagues () {
       
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.fetch(url: "\(mainUrl)cricket/?met=Leagues&APIkey=\(APIkey)") { result in
            guard let cricketLeagues : LeguesData = result else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(cricketLeagues.result.count, 0, "API Failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 6, handler: nil)
    }
    
    func testFetchForCricketLeaguesTeams () {
        
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.fetch(url: "\(mainUrl)cricket/?met=Teams&?met=Leagues&leagueId=733&APIkey=\(APIkey)") { result in
            guard let cricketLeaguesTeams : TeamData = result else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(cricketLeaguesTeams.result.count, 0, "API Failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 6, handler: nil)
        
    }
    
      
    func testFetchForCricketLeaguesEvents () {
        
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.fetch(url: "\(mainUrl)cricket/?met=Fixtures&leagueId=&from=2023-02-09&to=2024-02-09&APIkey=\(APIkey)") { result in
            guard let cricketLeaguesEvents : EventsData = result else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(cricketLeaguesEvents.result.count, 0, "API Failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
    }

}
