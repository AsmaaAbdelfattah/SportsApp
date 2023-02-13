//
//  MockTennisApiTest.swift
//  SportsApp_ITITests
//
//  Created by Asmaa_Abdelfattah on 24/11/1401 AP.
//

//
//  MockBasketballApiTests.swift
//  SportsApp_ITITests
//
//  Created by Asmaa_Abdelfattah on 24/11/1401 AP.
//

import XCTest
@testable import SportsApp_ITI
final class MockTennisApiTest : XCTestCase{
    var mockManger : MockNetworkManager?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      mockManger = MockNetworkManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockManger = nil
    }
    func testTennisApiWithMocking(){
        mockManger?.loadDataFromURL(url:  "\(mainUrl)tennis/?met=Leagues&APIkey=\(APIkey)", compiletionHandler: { data in
            guard let response : LeguesData = data else
            {
                XCTFail()
             
                return
            }
            XCTAssertNotEqual(response.result.count, 0 , "tennis Api Failed")
        })
    }
}

