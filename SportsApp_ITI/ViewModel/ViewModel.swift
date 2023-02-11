//
//  ViewModel.swift
//  SportsApp_ITI
//
//  Created by Zeinab on 05/02/2023.
//

import Foundation
class ViewModel {
    
    var bindResultToViewController : (() -> ()) = {}
    var resultLeagues : LeguesData! {
        didSet {
            bindResultToViewController()
        }
    }
   
   // var networkObj : Services = NetworkService()
    
    //get data from model
    func getLeague(url : String){
        NetworkService.fetch(url: url) { result in
            self.resultLeagues = result
        }
    }
    
    func getInstance () -> CoreDataManager {
        
        return CoreDataManager.getInstance()

    }
    
    
}
