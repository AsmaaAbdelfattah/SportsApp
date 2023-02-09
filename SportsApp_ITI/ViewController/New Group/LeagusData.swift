//
//  LeagusData.swift
//  SportsApp_ITI
//
//  Created by Zeinab on 03/02/2023.
//

import Foundation

class LeguesData : Decodable {
    var success : Int
    var result : [Leagus]
}

class Leagus : Decodable {
    var league_key : Int
    var league_name : String
    var league_logo : String?

}
