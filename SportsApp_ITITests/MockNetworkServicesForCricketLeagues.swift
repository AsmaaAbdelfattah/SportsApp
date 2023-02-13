//
//  MockNetworkServicesForCricketLeagues.swift
//  SportsApp_ITITests
//
//  Created by Zeinab on 13/02/2023.
//

import Foundation
@testable import SportsApp_ITI

class MockNetworkServicesForCricketLeagues {
    
    static let   mockItemsJsonResponseFromCricketLeagues: String = "{\"success\":1,\"result\":[{\"league_key\":733,\"league_name\":\"4-Day Franchise Series\"},{\"league_key\":8301,\"league_name\":\"Abu Dhabi T10\"}]}"
}

extension MockNetworkServicesForCricketLeagues : Services {
    
    static func fetch<T : Decodable>(url: String?, compiletionHandler: @escaping (T?) -> Void) {
        
        let data = Data(mockItemsJsonResponseFromCricketLeagues.utf8)
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            
            compiletionHandler(response)
        }catch _ {
            compiletionHandler(nil)
        }
    }
}
