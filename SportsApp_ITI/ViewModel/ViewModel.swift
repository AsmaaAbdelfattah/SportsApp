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
    
    var bindResultToViewControllerForUpcomingEvents : (() -> ()) = {}
    var bindResultToViewControllerForLatestEvents : (() -> ()) = {}
    var bindResultToViewControllerForTeams : (() -> ()) = {}
    
    var upCominevents : EventsData! {
        didSet{
            bindResultToViewControllerForUpcomingEvents()
        }
    }
    
    var latestevents : EventsData! {
        didSet{
            bindResultToViewControllerForLatestEvents()
        }
    }
    
    var Teams : TeamData! {
        didSet{
            bindResultToViewControllerForTeams()
        }
    }
    
    func getUpcominEvents(url : String){
        NetworkService.fetch(url: url) { result in
            self.upCominevents = result
        }
    }
    func getLatestEvents (url : String) {
        NetworkService.fetch(url: url) { result in
            self.latestevents = result
            
        }
    }

    func getTeams(url : String){
        NetworkService.fetch(url: url) { result in
            self.Teams = result
        }
    }
    
}
