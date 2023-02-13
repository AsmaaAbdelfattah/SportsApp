//
//  MockNetworkServicesForFootballLeaguesTests.swift
//  SportsApp_ITITests
//
//  Created by Zeinab on 12/02/2023.
//

import XCTest
@testable import SportsApp_ITI
final class MockNetworkServicesForFootballTests: XCTestCase {
    
    

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
        MockNetworkServicesForFootballLeagues.fetch(url: "\(mainUrl)football/?met=Leagues&APIkey=\(APIkey)") { data  in
            
            guard let footballLeagues : LeguesData =  data else
            {
                XCTFail()
                return
            }
            XCTAssertNotEqual(footballLeagues.result.count, 0, "API Failed")
        }
    }
    
    func testFetchForFootballTeams () {
        MockNetworkServicesForFootballTeams.fetch(url: "\(mainUrl)football/?met=Teams&?met=Leagues&leagueId=4&APIkey=\(APIkey)") { data  in
            
            guard let footballTeams : TeamData =  data else
            {
                XCTFail()
                return
            }
            XCTAssertNotEqual(footballTeams.result.count, 0, "API Failed")
        }
    }
    
    func testFetchForFootballEvents () {
        MockNetworkServicesForFootballEvents.fetch(url: "\(mainUrl)football/?met=Fixtures&leagueId=4&from=2023-02-09&to=2024-02-09&APIkey=\(APIkey)") { data  in
            
            guard let footballEvents : EventsData =  data else
            {
                XCTFail()
                return
            }
            XCTAssertNotEqual(footballEvents.result.count, 0, "API Failed")
        }
    }

}
