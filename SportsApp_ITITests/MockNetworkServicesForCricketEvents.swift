//
//  MockNetworkServicesForCricketEvents.swift
//  SportsApp_ITITests
//
//  Created by Zeinab on 13/02/2023.
//

import Foundation
@testable import SportsApp_ITI

class MockNetworkServicesForCricketEvents {
    
    static let   mockItemsJsonResponseFromCricketEvents: String = "{\"success\":1,\"result\":[{\"event_key\":5843,\"event_home_team\":\"Colombo\",\"home_team_key\":162,\"event_away_team\":\"Galle\",\"away_team_key\":161,\"league_name\":\"National Super League 4-Day Tournament\",\"league_key\":1181}]}"
}

extension MockNetworkServicesForCricketEvents : Services {
    
    static func fetch<T : Decodable>(url: String?, compiletionHandler: @escaping (T?) -> Void) {
        
        let data = Data(mockItemsJsonResponseFromCricketEvents.utf8)
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            
            compiletionHandler(response)
        }catch _ {
            compiletionHandler(nil)
        }
    }
}
