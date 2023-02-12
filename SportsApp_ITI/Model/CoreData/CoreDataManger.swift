//
//  CoreDataManger.swift
//  SportsApp_ITI
//
//  Created by Zeinab on 11/02/2023.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataOpe {
    func saveToCoreData(league : Leagus , sportName : String)
    func deleteFromCoreData(leagueKey : Int)
    func fetchFromCoreData() -> [NSManagedObject]
    func isFavourite(leagueKey : Int) -> Bool
}
class CoreDataManager : CoreDataOpe{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext : NSManagedObjectContext!
    let entity : NSEntityDescription!
    
    private static var sharedInstance : CoreDataManager?
    
    public static func getInstance()->CoreDataManager{
        
        if sharedInstance == nil {
            sharedInstance = CoreDataManager()
        }
        
        return sharedInstance!
            
    }
    
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "League", in: self.managedContext)
    }
    
    func saveToCoreData(league: Leagus , sportName : String) {
        
        let leagues = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        leagues.setValue(league.league_key, forKey: "league_key")
        leagues.setValue(league.league_name, forKey: "league_name")
        leagues.setValue(league.league_logo, forKey: "league_logo")
        leagues.setValue(sportName, forKey: "sport_name")
        
        do{
            try managedContext.save()
        }catch let error {
            print (error)
        }
    }
    
    func deleteFromCoreData(leagueKey : Int) {
        let fetchLeagues = fetchFromCoreData()
        
        for item in fetchLeagues {
            if item.value(forKey: "league_key") as! Int == leagueKey {
                managedContext.delete(item)
            }
        }
        do {
            try managedContext.save()
        } catch let error {
            print (error)
        }
    }
    
    func fetchFromCoreData() -> [NSManagedObject] {
        
        var leagueFromCoreData : [NSManagedObject]!
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "League")
        
        do{
             leagueFromCoreData = try self.managedContext.fetch(fetchRequest)
           
        } catch let error {
            print (error)
        }
        
        return leagueFromCoreData
    }
    
    func isFavourite(leagueKey : Int) -> Bool {
        
        let fetchLeagues = fetchFromCoreData()
        
        for item in fetchLeagues {
            if item.value(forKey: "league_key") as! Int == leagueKey {
               return true
            }
        }
        return false
    }
    
}
