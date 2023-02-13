//
//  MockManagerEvents.swift
//  SportsApp_ITITests
//
//  Created by Asmaa_Abdelfattah on 24/11/1401 AP.
//

import Foundation
@testable import SportsApp_ITI
class MockNetworkManagerEvents{
    let mockNTManager : String =
    "{\"success\":1,\"result\":[{\"event_key\":56660,\"event_date\":\"2023-04-05\",\"event_time\":\"18:00\",\"event_home_team\":\"Dziki Warszawa\",\"home_team_key\":3015,\"event_away_team\":\"Bytom\",\"away_team_key\":4583,\"event_final_result\":\"-\",\"event_quarter\":null,\"event_status\":\"\",\"country_name\":\"Poland\",\"league_name\":\"1. Liga\",\"league_key\":962,\"league_round\":null,\"league_season\":\"2022\\/2023\",\"event_live\":\"0\",\"event_home_team_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo-basketball\\/3015_dziki_warszawa.png\",\"event_away_team_logo\":null,\"scores\":{\"1stQuarter\":[],\"2ndQuarter\":[],\"3rdQuarter\":[],\"4thQuarter\":[]},\"statistics\":[],\"lineups\":{\"home_team\":{\"starting_lineups\":[],\"substitutes\":[]},\"away_team\":{\"starting_lineups\":[],\"substitutes\":[]}},\"player_statistics\":{\"home_team\":[],\"away_team\":[]}}]}"
    let mockNTManagerTeams = "{\"success\":1,\"result\":[{\"team_key\":251,\"team_name\":\"Slask Wroclaw II\",\"team_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo-basketball\\/251_slask_wroclaw_ii.png\"}]}"
    func loadDataFromURL<T : Decodable>(url: String, compiletionHandler: @escaping (T?) -> Void) {
        let data = Data(mockNTManager.utf8)
        do {
            let response  = try JSONDecoder().decode(T.self, from: data)
            compiletionHandler(response)
        } catch {
            compiletionHandler(nil)
        }
    }
    func loadDataFromURLTeams<T : Decodable>(url: String, compiletionHandler: @escaping (T?) -> Void) {
        let data = Data(mockNTManagerTeams.utf8)
        do {
            let response  = try JSONDecoder().decode(T.self, from: data)
            compiletionHandler(response)
        } catch {
            compiletionHandler(nil)
        }
    }
}
