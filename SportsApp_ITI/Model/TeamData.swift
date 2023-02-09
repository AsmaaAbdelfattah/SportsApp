//
//  TeamData.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 18/11/1401 AP.
//

import Foundation
class TeamData : Decodable {
    var success : Int
    var result : [Teams]
}

class Teams : Decodable {
    var team_key : Int
    var team_name : String
    var team_logo : String?
   var players : [Players]
   var coaches : [Coaches]
  
    
}
class Players : Decodable{
    var player_key : Int?
    var player_name : String?
    var player_number : String?
    var player_age : String?
    var player_match_played : String?
    var player_goals : String?
    var player_yellow_cards : String?
    var player_red_cards : String?
    var player_image : String?
}
class Coaches : Decodable{
    var  coach_name : String
    
}
