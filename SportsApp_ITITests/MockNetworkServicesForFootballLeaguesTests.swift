//
//  MockNetworkServicesForFootballLeaguesTests.swift
//  SportsApp_ITITests
//
//  Created by Zeinab on 12/02/2023.
//

import XCTest
@testable import SportsApp_ITI
final class MockNetworkServicesForFootballLeaguesTests: XCTestCase {
    
    

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
    
//    func testFetchForFootballLeagues () {
//        MockNetworkServicesForFootballLeagues.fetch(url: "\(mainUrl)football/?met=Leagues&APIkey=\(APIkey)") { footballLeagues  in
//            
//            guard footballLeagues != nil else
//            {
//                XCTFail()
//                return
//            }
//            XCTAssertNotNil(footballLeagues , "API Failed")
//        }
//    }

}
