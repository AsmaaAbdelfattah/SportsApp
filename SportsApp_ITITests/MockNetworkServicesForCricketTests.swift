//
//  MockNetworkServicesForCricketTests.swift
//  SportsApp_ITITests
//
//  Created by Zeinab on 13/02/2023.
//

import XCTest
@testable import SportsApp_ITI
final class MockNetworkServicesForCricketTests: XCTestCase {

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
        MockNetworkServicesForCricketLeagues.fetch(url: "\(mainUrl)football/?met=Leagues&APIkey=\(APIkey)") { data  in
            
            guard let cricketLeagues : LeguesData =  data else
            {
                XCTFail()
                return
            }
            XCTAssertNotEqual(cricketLeagues.result.count, 0, "API Failed")
        }
    }
    
    func testFetchForFootballTeams () {
        MockNetworkServicesForCricketTeams.fetch(url: "\(mainUrl)football/?met=Teams&?met=Leagues&leagueId=4&APIkey=\(APIkey)") { data  in
            
            guard let cricketTeams : TeamData =  data else
            {
                XCTFail()
                return
            }
            XCTAssertNotEqual(cricketTeams.result.count, 0, "API Failed")
        }
    }
    
    func testFetchForCricketEvents () {
        MockNetworkServicesForCricketEvents.fetch(url: "\(mainUrl)football/?met=Fixtures&leagueId=4&from=2023-02-09&to=2024-02-09&APIkey=\(APIkey)") { data  in
            
            guard let cricketEvents : EventsData =  data else
            {
                XCTFail()
                return
            }
            XCTAssertNotEqual(cricketEvents.result.count, 0, "API Failed")
        }
    }
    

}
