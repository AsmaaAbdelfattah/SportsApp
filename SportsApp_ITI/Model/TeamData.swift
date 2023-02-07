//
//  TeamData.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 18/11/1401 AP.
//

import Foundation
struct TeamData : Decodable {
    var success : Int
    var result : [Teams]
}

struct Teams : Decodable {
    var team_name : Int
    var team_logo : String?
    var players : Players
    var coaches : Coaches
    struct Players : Decodable{
     var player_name : String
     var player_number : Int
    }
    struct Coaches : Decodable{
      var  coach_name : String
    }
}
