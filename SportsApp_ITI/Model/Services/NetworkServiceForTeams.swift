//
//  NetworkServiceForTeams.swift
//  SportsApp_ITI
//
//  Created by Zeinab on 09/02/2023.
//

import Foundation
import Alamofire

protocol ServicesForTeams {
    
    func fetch(url:String?,compiletionHandler : @escaping ([Teams]?)->Void)
}
class NetworkServiceForTeams : ServicesForTeams{

    func fetch(url:String?,compiletionHandler : @escaping ([Teams]?)->Void){
        
        let request = AF.request(url ?? "")
        
        request.responseDecodable(of:TeamData.self) { (response) in
            guard let teams = response.value?.result else {

              compiletionHandler(nil)
              return }

        compiletionHandler(teams)
        }
   }
}
