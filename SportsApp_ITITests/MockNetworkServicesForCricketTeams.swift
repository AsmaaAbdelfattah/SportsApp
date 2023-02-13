//
//  MockNetworkServicesForCricketTeams.swift
//  SportsApp_ITITests
//
//  Created by Zeinab on 13/02/2023.
//

import Foundation
@testable import SportsApp_ITI

class MockNetworkServicesForCricketTeams {
    
    static let   mockItemsJsonResponseFromCricketTeams: String = "{\"success\":1,\"result\":[{\"team_key\":14,\"team_name\":\"Dolphins\"},{\"team_key\":15,\"team_name\":\"Titans\"}]}"
}

extension MockNetworkServicesForCricketTeams : Services {
    
    static func fetch<T : Decodable>(url: String?, compiletionHandler: @escaping (T?) -> Void) {
        
        let data = Data(mockItemsJsonResponseFromCricketTeams.utf8)
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            
            compiletionHandler(response)
        }catch _ {
            compiletionHandler(nil)
        }
    }
}
