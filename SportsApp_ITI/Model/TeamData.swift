//
//  TeamData.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 18/11/1401 AP.
//

import Foundation
struct TeamData : Decodable {
    var success : Int
    var result : [Teams]?
}

struct Teams : Decodable {
    var team_key : Int
    var team_name : String
    var team_logo : String?
    var players : [Players]
    var coaches : Coaches
    struct Players : Decodable{
        var player_key : Int
        var player_name : String
        var player_number : Int
        var player_age : Int
        var player_match_played : String
        var player_goals : String
        var player_yellow_cards : String
        var player_red_cards : String
        var player_image : String
    }
    struct Coaches : Decodable{
        var  coach_name : String
        
    }
}
