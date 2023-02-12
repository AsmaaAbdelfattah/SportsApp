//
//  MockNetworkServicesForFootball.swift
//  SportsApp_ITITests
//
//  Created by Zeinab on 12/02/2023.
//

import Foundation
@testable import SportsApp_ITI

class MockNetworkServicesForFootballLeagues {
    
    static let   mockItemsJsonResponseFromFootballLeagues: String = "{\"result\":[{\"league_key\":4,\"league_name\":\"UEFA Europa League\"},{\"league_key\":1,\"league_name\":\"European Championship\"}]"
}

extension MockNetworkServicesForFootballLeagues : Services {
    
    static func fetch<T : Decodable>(url: String?, compiletionHandler: @escaping (T?) -> Void) {
        
        let data = Data(mockItemsJsonResponseFromFootballLeagues.utf8)
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            
            compiletionHandler(response)
        }catch _ {
            compiletionHandler(nil)
        }
    }
}



