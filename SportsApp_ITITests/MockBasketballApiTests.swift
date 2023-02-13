//
//  MockBasketballApiTests.swift
//  SportsApp_ITITests
//
//  Created by Asmaa_Abdelfattah on 24/11/1401 AP.
//

import XCTest
@testable import SportsApp_ITI
final class MockbasketballApiTest : XCTestCase{
    var mockManger : MockNetworkManager?
    var mockMangerEvents : MockNetworkManagerEvents?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockManger = MockNetworkManager()
        mockMangerEvents = MockNetworkManagerEvents()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockManger = nil
        mockMangerEvents = nil
    }
    func testBasketBallApiWithMocking(){
        mockManger?.loadDataFromURL(url:  "\(mainUrl)basketball/?met=Leagues&APIkey=\(APIkey)", compiletionHandler: { data in
            guard let response : LeguesData = data else
            {
                XCTFail()
             
                return
            }
            XCTAssertNotEqual(response.result.count, 0 , "Basketball Api Failed")
        })
    }
    func testBasketBallEventsApiWithMocking(){
        mockMangerEvents?.loadDataFromURL(url:"\(mainUrl)basketball/?met=Fixtures&leagueId=962&from=2023-02-09&to=2024-02-09&APIkey=\(APIkey)", compiletionHandler: { data in
            guard let response : EventsData = data else
            {
                XCTFail()
             
                return
            }
            XCTAssertNotEqual(response.result.count, 0 , "Basketball Events Api Failed")
        })
    }
    func testBasketBallTeamsApiWithMocking(){
        mockMangerEvents?.loadDataFromURLTeams(url:"\(mainUrl)basketball/?met=Teams&?met=Leagues&leagueId=962&from=2023-02-09&to=2024-02-09&APIkey=\(APIkey)", compiletionHandler: { data in
            guard let response : TeamData = data else
            {
                XCTFail()
             
                return
            }
            XCTAssertNotEqual(response.result.count, 0 , "Basketball Team Api Failed")
        })
    }
}
