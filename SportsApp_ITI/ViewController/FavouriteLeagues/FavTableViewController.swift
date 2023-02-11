//
//  FavTableViewController.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 11/11/1401 AP.
//

import UIKit
import CoreData
import Reachability

class FavTableViewController: UITableViewController {
    
    var managedContext : NSManagedObjectContext!
    
    var leagueFromCoreData : Array<NSManagedObject>!
    
    var tempLague : Leagus!
    
    var viewModel : ViewModel?
    var coreData : CoreDataManager?
   // var leaguesFromCoreData : Array<Leagus> = []
    
    var network : Reachability?
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//        self.managedContext = appDelegate.persistentContainer.viewContext
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
              self.tableView.register(nib, forCellReuseIdentifier: "customCell")
        
        viewModel = ViewModel()
        coreData = viewModel?.getInstance()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.leagueFromCoreData = coreData?.fetchFromCoreData()
        
        self.tableView.reloadData()
    }

 
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagueFromCoreData.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell

        
        
        // Configure the cell...
        
        cell.leagueImg.image = UIImage(named: "youtube.png")
        cell.leagueName.text = leagueFromCoreData[indexPath.row].value(forKey: "league_name") as? String
        cell.leagueImg?.layer.cornerRadius = (cell.leagueImg?.frame.size.width ?? 0.0) / 2
        cell.leagueImg?.clipsToBounds = true
       
        cell.leagueImg?.layer.borderColor = UIColor.white.cgColor
        cell.leagueImg?.layer.masksToBounds = false
        
        //Open Youtube
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
       
        return cell
        
        
      
  
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView

        // Your action
        let youtubeId = "SxTYjptEzZs"
            var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            UIApplication.shared.openURL(youtubeUrl as URL)
            } else{
                    youtubeUrl = NSURL(string:"https://www.youtube.com/watch?v=Dtcqf9RbEDM\(youtubeId)")!
                UIApplication.shared.openURL(youtubeUrl as URL)
            }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0;//Choose your custom row height
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            if(leagueFromCoreData != nil){
                coreData?.deleteFromCoreData(leagueKey: leagueFromCoreData[indexPath.row].value(forKey: "league_key") as! Int)
                self.leagueFromCoreData = coreData?.fetchFromCoreData()
                self.tableView.reloadData()
                
                //    managedContext.delete(leagueFromCoreData[indexPath.row])
//                managedContext.delete(leagueFromCoreData[indexPath.row])
//                // leagueFromCoreData.removeAtIndex(indexPath.row)
//
//                do{
//                    try managedContext.save()
//                }catch let error{
//                    print(error.localizedDescription)
//                }
//                //       tableView.deleteRows(at: [indexPath], with: .fade)
//                fetchDataToCoreData()
            }}
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        network = Reachability.forInternetConnection()
        if network!.isReachable(){
            network!.isReachableViaWiFi()
            print("connected")
            let view = self.storyboard?.instantiateViewController(withIdentifier: "Details") as! DetailsLeagueController
            
           
            //tempLague?.league_name = leagueFromCoreData[indexPath.row].value(forKey: "league_name") as! String
            //tempLague.league_logo = leagueFromCoreData[indexPath.row].value(forKey: "league_logo") as? String
            //tempLague?.league_key = leagueFromCoreData[indexPath.row].value(forKey: "league_key") as! Int
            
       // view.league?.league_name = leagueFromCoreData[indexPath.row].value(forKey: "league_name") as! String
            //view.league = tempLague
           // view.leagueFromCoreData = self.leagueFromCoreData[indexPath.row]
            view.LGKey = (leagueFromCoreData[indexPath.row].value(forKey: "league_key") as! Int)
            view.modalPresentationStyle = .fullScreen
            self.present(view , animated: true, completion: nil)
          
             }
        else{
            print("Not Connected")
           //alert
            let alert = UIAlertController(title: "Internet Connection Not Available", message: "Please Turn on Your Connection", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
     
     
    }

    func fetchDataToCoreData() {
    
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "League")
        
        do{
            self.leagueFromCoreData = try self.managedContext.fetch(fetchRequest)
           
        } catch let error {
            print (error)
        }
        
        self.tableView.reloadData()
       
    }
 

}
