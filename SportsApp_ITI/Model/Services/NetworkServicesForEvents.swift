//
//  NetworkServicesForEvents.swift
//  SportsApp_ITI
//
//  Created by Zeinab on 09/02/2023.
//

import Foundation
import Alamofire

protocol ServicesForEvents {
    
    func fetch(url:String?,compiletionHandler : @escaping ([Events]?)->Void)
}
class NetworkServiceForEvents : ServicesForEvents{

    func fetch(url:String?,compiletionHandler : @escaping ([Events]?)->Void){
        
        let request = AF.request(url ?? "")
        
        request.responseDecodable(of:EventsData.self) { (response) in
            guard let events = response.value?.result else {

              compiletionHandler(nil)
              return }

        compiletionHandler(events)
        }
   }
}
