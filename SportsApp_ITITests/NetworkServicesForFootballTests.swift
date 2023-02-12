//
//  NetworkServicesForFootballTests.swift
//  SportsApp_ITITests
//
//  Created by Zeinab on 12/02/2023.
//

import XCTest
@testable import SportsApp_ITI

final class NetworkServicesForFootballTests: XCTestCase {

    
    
    
    
    
    
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
    
    func testFetchForFootballLeagues () {
       
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.fetch(url: "\(mainUrl)football/?met=Leagues&APIkey=\(APIkey)") { result in
            guard let footballLeagues : LeguesData = result else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(footballLeagues.result.count, 0, "API Failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchForFootballLeaguesTeams () {
        
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.fetch(url: "\(mainUrl)football/?met=Teams&?met=Leagues&leagueId=4&APIkey=\(APIkey)") { result in
            guard let footballLeaguesTeams : TeamData = result else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(footballLeaguesTeams.result.count, 0, "API Failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
      
    func testFetchForFootballLeaguesEvents () {
        
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.fetch(url: "\(mainUrl)football/?met=Fixtures&leagueId=4&from=2023-02-09&to=2024-02-09&APIkey=\(APIkey)") { result in
            guard let footballLeaguesEvents : EventsData = result else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(footballLeaguesEvents.result.count, 0, "API Failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
    }

}
