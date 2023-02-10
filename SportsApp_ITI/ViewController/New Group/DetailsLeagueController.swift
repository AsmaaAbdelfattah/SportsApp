//
//  DetailsLeagueController.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 12/11/1401 AP.
//

import UIKit
import CoreData
import Kingfisher

class DetailsLeagueController: UIViewController,gestureInteraction {
    var LGKey : Int?
    var leagueFromCoreData : Array<NSManagedObject>!
    var spLabel : Int?
    @IBOutlet weak var TPLabel: UILabel!
    var managedContext : NSManagedObjectContext!
  
   // var networkfromteams : ServicesForTeams = NetworkServiceForTeams()
   // var networkfromsevices: ServicesForEvents = NetworkServiceForEvents()
    var network: Services = NetworkService()
  
    var teams : TeamData?
    var upcomingEvents : EventsData?
    var latestEvents : EventsData?
    
    var league : Leagus?
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var teamCollection: UICollectionView!
    @IBOutlet weak var recentComing: UICollectionView!
    @IBOutlet weak var comingCollection: UICollectionView!

    @IBOutlet weak var favBtn: UIButton!
    var iconFav = ["star.png", "filledStar.png"]
    var stateSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
       self.managedContext = appDelegate.persistentContainer.viewContext
        
        if(spLabel == 3){
            TPLabel.text = "Players"
            TPLabel.adjustsFontSizeToFitWidth = true
        }
   
     
            isFavorite()
            
        workWithDispatchQueue()
        
        var nib = UINib(nibName: "comCollectionViewCell", bundle: nil)
        self.comingCollection.register(nib, forCellWithReuseIdentifier: "coming")
         nib = UINib(nibName: "recCollectionViewCell", bundle: nil)
        self.recentComing.register(nib, forCellWithReuseIdentifier: "recent")
         nib = UINib(nibName: "TeamCollectionViewCell", bundle: nil)
        self.teamCollection.register(nib, forCellWithReuseIdentifier: "team")
        gestureInteract()
    }
  
    func gestureInteract(){
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissVC))
                gesture.direction = .down
                view.isUserInteractionEnabled = true // For UIImageView
                view.addGestureRecognizer(gesture)
    }
    @objc
        func dismissVC() {
           dismiss(animated: true)
       }

    @IBAction func starBtnClicked(_ sender: Any) {
        
        
        let entity = NSEntityDescription.entity(forEntityName: "League", in: self.managedContext)
        
        let leagues = NSManagedObject(entity: entity!, insertInto: managedContext)
        leagues.setValue(league?.league_key, forKey: "league_key")
        leagues.setValue(league?.league_name, forKey: "league_name")
        leagues.setValue(league?.league_logo, forKey: "league_logo")
        leagues.setValue(true, forKey: "isFilled")
        do{
            try managedContext.save()
        }catch let error {
            print (error)
        }

        if(stateSelected == 0)
        {
            favBtn.setBackgroundImage(UIImage(named: iconFav[1]), for: .normal)
            showToast(message: "\(league?.league_name ?? "" ) Added to Your Favourites")
            
          
            stateSelected += 1
        }
        else{
            showToast(message: "\(league?.league_name ?? "") Removed From Your Favourites")
            favBtn.setBackgroundImage(UIImage(named: iconFav[0]), for: .normal)
    
            stateSelected = 0
        }
    }
   
   

}
extension DetailsLeagueController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == comingCollection){
            return upcomingEvents?.result.count ?? 0
        }
        else if(collectionView == recentComing){
            return latestEvents?.result.count ?? 0
        }

        return teams?.result.count ?? 0
      
    }
    
     
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == comingCollection){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coming", for: indexPath) as! comCollectionViewCell
            //cell.team1.image =  UIImage(named: "real.png")
            //cell.team2.image =  UIImage(named:"real.png")
            cell.team1.kf.setImage(with: URL(string: upcomingEvents?.result[indexPath.row].home_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
            
            cell.team2.kf.setImage(with: URL(string: upcomingEvents?.result[indexPath.row].away_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
           return cell
        }
        else if(collectionView == recentComing){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recent", for: indexPath) as! recCollectionViewCell
   
            cell.firstTeam.kf.setImage(with: URL(string: latestEvents?.result[indexPath.row].home_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
            
            cell.secondTeam.kf.setImage(with: URL(string: latestEvents?.result[indexPath.row].away_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
            
    
            
            cell.score.text = latestEvents?.result[indexPath.row].event_final_result
            return cell
        }
        if(spLabel == 3){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "team", for: indexPath) as! TeamCollectionViewCell
       
            cell.teamName.text = teams?.result[indexPath.row].players[indexPath.row].player_name
        
            cell.teamImg.kf.setImage(with: URL(string: teams?.result[indexPath.row].players[indexPath.row].player_image ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        
           return cell
        }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "team", for: indexPath) as! TeamCollectionViewCell
       
        cell.teamName.text = teams?.result[indexPath.row].team_name
        
        cell.teamImg.kf.setImage(with: URL(string: teams?.result[indexPath.row].team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        
           return cell
       
    }
    func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width:collectionView.frame.size.width
                     , height: collectionView.frame.size.height)

         }

//         func collectionView(_ collectionView: UICollectionView,
//                             layout collectionViewLayout: UICollectionViewLayout,
//                             minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//             return 4.0
//         }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == teamCollection){
            if(spLabel == 3){
                let PlayersViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "player") as! PlayersViewController
                
                PlayersViewControllerObj.modalPresentationStyle = .fullScreen
                self.present(PlayersViewControllerObj, animated: true, completion: nil)
            }
            else{
                let TeamViewControllerObj : TeamViewController = self.storyboard?.instantiateViewController(withIdentifier: "team") as! TeamViewController
                
                TeamViewControllerObj.team = teams!.result[indexPath.row]
                TeamViewControllerObj.coach = teams!.result[indexPath.row].coaches[0].coach_name
                TeamViewControllerObj.modalPresentationStyle = .fullScreen
                self.present(TeamViewControllerObj, animated: true, completion: nil)
            }
            
        }}
    
    func workWithDispatchQueue () {
        
        let group = DispatchGroup()
        
        group.enter()
        
        self.network.fetch(url: "https://apiv2.allsportsapi.com/football/?met=Teams&?met=Leagues&leagueId=3&APIkey=59dbd205f73cf075a8012c155eec9c37aa90478a4538caf0066c651dc62bb9b8") { result in
         
            self.teams = result
      
            group.leave()
        }
        
        group.enter()
         
        self.network.fetch(url: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=205&from=2023-02-09&to=2024-02-09&APIkey=59dbd205f73cf075a8012c155eec9c37aa90478a4538caf0066c651dc62bb9b8") { result in
        
             self.upcomingEvents = result
             
         
            group.leave()
        }
        
        group.enter()
        self.network.fetch(url: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=205&from=2022-02-09&to=2023-02-09&APIkey=59dbd205f73cf075a8012c155eec9c37aa90478a4538caf0066c651dc62bb9b8") { result in
         
             self.latestEvents = result
             
         
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.teamCollection.reloadData()
            self.recentComing.reloadData()
            self.comingCollection.reloadData()
        }
    }
    func showToast(message:String){
        
        let toast = UILabel(frame: CGRect(x: self.view.bounds.size.width/2-200 , y: self.view.bounds.size.height-100, width: self.view.bounds.size.width, height: 50))
        toast.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toast.textColor = UIColor.white
        toast.font = .boldSystemFont(ofSize: 14)
        toast.textAlignment = .center
        toast.alpha = 1.0
        toast.layer.cornerRadius = 10
        toast.clipsToBounds = true
        toast.text = message
        view.addSubview(toast)
   
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseIn, animations: {
            toast.alpha = 0.0
            
        }, completion: {
            isCompleted in
            toast.removeFromSuperview()
        })
    }
    
    
    func isFavorite(){
        let entity = NSEntityDescription.entity(forEntityName: "League", in: self.managedContext)
        
        let leagues = NSManagedObject(entity: entity!, insertInto: managedContext)
  
      
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"League")
      
      
        do{
            let predicate = NSPredicate(format: "league_name ==%@",league?.league_name ?? "")
            print(predicate)
            fetchRequest.predicate = predicate
           let record  = try managedContext.fetch(fetchRequest)
            print(record)
            if(record.isEmpty == false){
                if(record[0].value(forKey: "isFilled") as! Bool ) {
                    favBtn.setBackgroundImage(UIImage(named: iconFav[1]), for: .normal)
                    
                    stateSelected = 0
                    leagues.setValue(false, forKey: "isFilled")
                }
                else{
                    favBtn.setBackgroundImage(UIImage(named: iconFav[0]), for: .normal)
                    stateSelected += 1
                    leagues.setValue(true, forKey: "isFilled")
                }}
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
}
