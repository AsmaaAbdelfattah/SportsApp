//
//  NetworkService.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 15/11/1401 AP.
//

import Foundation
import Alamofire

protocol Services {
    
    static func fetch <T : Decodable>(url:String?,compiletionHandler : @escaping (T?)->Void)
}

class NetworkService : Services{

    static func fetch <T : Decodable>(url:String?,compiletionHandler : @escaping (T?)->Void){
        
        let request = AF.request(url ?? "")
        
        request.responseDecodable(of:T.self) { (response) in
            guard let resultOfAPI = response.value else {

                compiletionHandler(nil)
              return }

        compiletionHandler(resultOfAPI)
        }
   }
}
