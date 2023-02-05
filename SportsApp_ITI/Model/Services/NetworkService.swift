//
//  NetworkService.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 15/11/1401 AP.
//

import Foundation
import Alamofire

protocol Services {
    
    func fetch(url:String?,compiletionHandler : @escaping ([Leagus]?)->Void)
}
class NetworkService : Services{

    func fetch(url:String?,compiletionHandler : @escaping ([Leagus]?)->Void){
        
        let request = AF.request(url ?? "")
        
        request.responseDecodable(of:LeguesData.self) { (response) in
            guard let leagues = response.value?.result else {

              compiletionHandler(nil)
              return }

        compiletionHandler(leagues)
        }
   }
}
