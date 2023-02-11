//
//  EventsData.swift
//  SportsApp_ITI
//
//  Created by Zeinab on 09/02/2023.
//

import Foundation

class EventsData : Decodable {
    var success : Int
    var result : [Events]
}

class Events : Decodable {
    var event_key : Int
    var event_date : String
    var event_time : String
    var event_home_team : String
    var home_team_key : Int
    var event_away_team : String
    var away_team_key : Int
    var event_final_result : String?
    var event_status : String
    var league_name : String
    var league_key : Int
    var league_round : String?
    var event_stadium : String?
    var home_team_logo : String?
    var away_team_logo : String?
    var event_home_team_logo : String?
    var event_away_team_logo : String?
}
