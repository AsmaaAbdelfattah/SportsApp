//
//  MockManagerTennisEvents.swift
//  SportsApp_ITITests
//
//  Created by Asmaa_Abdelfattah on 24/11/1401 AP.
//

import Foundation
@testable import SportsApp_ITI
class MockNetworkManagerTennisEvents{
    let mockNTTennisEvents : String  = "{\"success\":1,\"result\":[{\"event_key\":3592977,\"event_date\":\"2023-02-15\",\"event_time\":\"05:30\",\"event_first_player\":\"Lock\\/ Lock\",\"first_player_key\":263,\"event_second_player\":\"Clarke\\/ Kadhe\",\"second_player_key\":39874,\"event_final_result\":\"-\",\"event_game_result\":\"-\",\"event_serve\":null,\"event_winner\":null,\"event_status\":\"1\",\"country_name\":\"Challenger Men Doubles\",\"league_name\":\"Chennai Challenger Men\",\"league_key\":8575,\"league_round\":\"\",\"league_season\":\"2023\",\"event_live\":\"0\",\"event_first_player_logo\":null,\"event_second_player_logo\":null,\"pointbypoint\":[],\"scores\":[]}]}"
    func loadDataFromURL<T : Decodable>(url: String, compiletionHandler: @escaping (T?) -> Void) {
        let data = Data(mockNTTennisEvents.utf8)
        do {
            let response  = try JSONDecoder().decode(T.self, from: data)
            compiletionHandler(response)
        } catch {
            compiletionHandler(nil)
        }
    }
}
