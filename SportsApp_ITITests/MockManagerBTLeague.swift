//
//  MockManager.swift
//  SportsApp_ITITests
//
//  Created by Asmaa_Abdelfattah on 24/11/1401 AP.
//

import Foundation
@testable import SportsApp_ITI
class MockNetworkManager{
    let mockNTManager : String =
    "{\"success\":1,\"result\":[{\"league_key\":962,\"league_name\":\"1. Liga\",\"country_key\":216,\"country_name\":\"Poland\"}]}"
    func loadDataFromURL<T : Decodable>(url: String, compiletionHandler: @escaping (T?) -> Void) {
        let data = Data(mockNTManager.utf8)
        do {
            let response  = try JSONDecoder().decode(T.self, from: data)
            compiletionHandler(response)
        } catch {
            compiletionHandler(nil)
        }
    }
}

