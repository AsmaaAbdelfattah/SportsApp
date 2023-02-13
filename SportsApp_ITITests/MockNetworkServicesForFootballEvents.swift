//
//  MockNetworkServicesForFootballEvents.swift
//  SportsApp_ITITests
//
//  Created by Zeinab on 13/02/2023.
//

import Foundation
@testable import SportsApp_ITI

class MockNetworkServicesForFootballEvents {
    
    static let   mockItemsJsonResponseFromFootballEvents: String = "{\"success\":1,\"result\":[{\"event_key\":1162956,\"event_home_team\":\"Manchester United\",\"home_team_key\":102,\"event_away_team\":\"Barcelona\",\"away_team_key\":97,\"league_name\":\"UEFA Europa League - Knockout Round Play-offs\",\"league_key\":4}]}"
}

extension MockNetworkServicesForFootballEvents : Services {
    
    static func fetch<T : Decodable>(url: String?, compiletionHandler: @escaping (T?) -> Void) {
        
        let data = Data(mockItemsJsonResponseFromFootballEvents.utf8)
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            
            compiletionHandler(response)
        }catch _ {
            compiletionHandler(nil)
        }
    }
}
