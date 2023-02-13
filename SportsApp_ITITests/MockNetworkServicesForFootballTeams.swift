//
//  MockNetworkServicesForFootballTeams.swift
//  SportsApp_ITITests
//
//  Created by Zeinab on 13/02/2023.
//

import Foundation
@testable import SportsApp_ITI

class MockNetworkServicesForFootballTeams {
    
    static let   mockItemsJsonResponseFromFootballTeams: String = "{\"success\":1,\"result\":[{\"team_key\":74,\"team_name\":\"Salzburg\"},{\"team_key\":78,\"team_name\":\"Shakhtar Donetsk\"}]}"
}

extension MockNetworkServicesForFootballTeams : Services {
    
    static func fetch<T : Decodable>(url: String?, compiletionHandler: @escaping (T?) -> Void) {
        
        let data = Data(mockItemsJsonResponseFromFootballTeams.utf8)
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            
            compiletionHandler(response)
        }catch _ {
            compiletionHandler(nil)
        }
    }
}
