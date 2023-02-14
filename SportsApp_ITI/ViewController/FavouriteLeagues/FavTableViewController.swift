//
//  FavTableViewController.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 11/11/1401 AP.
//

import UIKit
import CoreData
import Reachability
import Kingfisher

class FavTableViewController: UITableViewController ,gestureInteraction,Notification{
 
    
    @IBOutlet weak var leagueTap: UILabel!
    
    var managedContext : NSManagedObjectContext!
    
    var leagueFromCoreData : Array<NSManagedObject>!
    
    var tempLague : Leagus!
    
    var viewModel : ViewModel?
    var coreData : CoreDataManager?
   // var leaguesFromCoreData : Array<Leagus> = []
    
    var network : Reachability?
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//        self.managedContext = appDelegate.persistentContainer.viewContext
        UITabBar.appearance().tintColor = UIColor.green
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
              self.tableView.register(nib, forCellReuseIdentifier: "customCell")
        
        viewModel = ViewModel()
        coreData = viewModel?.getInstance()
        leagueTap.isUserInteractionEnabled = true
   
            gestureInteract()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.leagueFromCoreData = coreData?.fetchFromCoreData()
        if(leagueFromCoreData != nil){
            print("llll")
            showNotification()
            for item in leagueFromCoreData{
              
                schduleNotification(message: "Check out \(item.value(forKey: "league_name") ?? "") Your favourite league", Title: "Sports App")
            }
            
        }
        self.tableView.reloadData()
    }

    @IBOutlet var favTableView: UITableView!
    func gestureInteract(){
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissVC))
                gesture.direction = .right
                view.isUserInteractionEnabled = true // For UIImageView
                view.addGestureRecognizer(gesture)
    }
    @objc
    func dismissVC() {
         navigationController?.popViewController(animated: true)
          //dismiss(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return leagueFromCoreData.count
   
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell

        cell.layer.cornerRadius = cell.frame.height/3
    
        // Configure the cell...
//        let scale = UIScreen.main.scale
//        let resizingProcessor = ResizingImageProcessor(referenceSize: CGSize(width: 100.0 * scale, height: 100.0 * scale))
        cell.leagueImg.kf.setImage(with: URL(string: leagueFromCoreData[indexPath.section].value(forKey: "league_logo") as? String ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading ], progressBlock: nil, completionHandler: nil)

        cell.leagueName.text = leagueFromCoreData[indexPath.section].value(forKey: "league_name") as? String
       cell.leagueImg?.layer.cornerRadius = (cell.leagueImg?.frame.size.width ?? 0.0) / 2
        cell.leagueImg?.clipsToBounds = true
     
        cell.leagueImg?.layer.borderColor = UIColor.black.cgColor
        cell.leagueImg?.layer.masksToBounds = true
       
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(1);
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView : UIView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
           
       }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 90.0;//Choose your custom row height
//    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            if(leagueFromCoreData != nil){
                coreData?.deleteFromCoreData(leagueKey: leagueFromCoreData[indexPath.section].value(forKey: "league_key") as! Int)
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
            view.LGKey = (leagueFromCoreData[indexPath.section].value(forKey: "league_key") as! Int)
            view.spLabel = (leagueFromCoreData[indexPath.section].value(forKey: "sport_name") as! String)
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
    func schduleNotification(message: String, Title: String) {
        let content = UNMutableNotificationContent()
        content.title = Title
        content.body = message
        content.sound = .default
        content.badge = (SportsViewController.notifCounter) as NSNumber
        SportsViewController.notifCounter += 1
        let trigger =  UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(60), repeats:
    true)
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func showNotification() {
     //   SportsViewController.showNotification(SportsViewController.self)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert , .sound , .badge]){
            (granted , error) in
            if granted {
                print("granted")
            }
            else{
                print("Deined")
            }
        }
    }
    

}
