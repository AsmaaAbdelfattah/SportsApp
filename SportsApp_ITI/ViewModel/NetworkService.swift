//
//  NetworkService.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 15/11/1401 AP.
//

import Foundation
import Alamofire
class NetworkService{

    func fetch(url:String?,compiletionHandler : @escaping (LeguesData?)->Void){
        let request = AF.request(url ?? "")
       request.responseDecodable(of:LeguesData .self) { (response) in
          guard let leagues = response.value else {

              compiletionHandler(nil)
              return }

        compiletionHandler(leagues)
        }
   }
}
