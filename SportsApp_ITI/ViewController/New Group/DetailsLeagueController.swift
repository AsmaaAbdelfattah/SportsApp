//
//  DetailsLeagueController.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 12/11/1401 AP.
//

import UIKit
import CoreData
import Kingfisher

class DetailsLeagueController: UIViewController {
    
    var leagueFromCoreData : Array<NSManagedObject>!
    
    var managedContext : NSManagedObjectContext!
    
    var networkfromteams : ServicesForTeams = NetworkServiceForTeams()
    var networkfromsevices: ServicesForEvents = NetworkServiceForEvents()
    
    var teams : [Teams]?
    var upcomingEvents : [Events]?
    var latestEvents : [Events]?
    
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
        workWithDispatchQueue()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.managedContext = appDelegate.persistentContainer.viewContext

        // Do any additional setup after loading the view.
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissVC))
                gesture.direction = .down
                view.isUserInteractionEnabled = true // For UIImageView
                view.addGestureRecognizer(gesture)
        var nib = UINib(nibName: "comCollectionViewCell", bundle: nil)
        self.comingCollection.register(nib, forCellWithReuseIdentifier: "coming")
         nib = UINib(nibName: "recCollectionViewCell", bundle: nil)
        self.recentComing.register(nib, forCellWithReuseIdentifier: "recent")
         nib = UINib(nibName: "TeamCollectionViewCell", bundle: nil)
        self.teamCollection.register(nib, forCellWithReuseIdentifier: "team")
    }
    @objc
       private func dismissVC() {
           dismiss(animated: true)
       }

    @IBAction func starBtnClicked(_ sender: Any) {

        if(stateSelected == 0)
        {
            favBtn.setBackgroundImage(UIImage(named: iconFav[1]), for: .normal)
            
            let entity = NSEntityDescription.entity(forEntityName: "League", in: managedContext)
            
            let leagues = NSManagedObject(entity: entity!, insertInto: managedContext)
            
            leagues.setValue(league?.league_key, forKey: "league_key")
            leagues.setValue(league?.league_name, forKey: "league_name")
            leagues.setValue(league?.league_logo, forKey: "league_logo")
            do{
                try managedContext.save()
            }catch let error {
                print (error)
            }
          
            stateSelected += 1
        }
        else{
            favBtn.setBackgroundImage(UIImage(named: iconFav[0]), for: .normal)
    
            stateSelected = 0
        }
    }
   
   

}
extension DetailsLeagueController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == comingCollection){
            return upcomingEvents?.count ?? 0
        }
        else if(collectionView == recentComing){
            return latestEvents?.count ?? 0
        }
     
        return teams?.count ?? 0
      
    }
    
     
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == comingCollection){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coming", for: indexPath) as! comCollectionViewCell
            //cell.team1.image =  UIImage(named: "real.png")
            //cell.team2.image =  UIImage(named:"real.png")
            cell.team1.kf.setImage(with: URL(string: upcomingEvents?[indexPath.row].home_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
            
            cell.team2.kf.setImage(with: URL(string: upcomingEvents?[indexPath.row].away_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
           return cell
        }
        else if(collectionView == recentComing){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recent", for: indexPath) as! recCollectionViewCell
            //cell.firstTeam.image = UIImage(named:"real.png")
            //cell.secondTeam.image =  UIImage(named:"sp.png")
            cell.firstTeam.kf.setImage(with: URL(string: latestEvents?[indexPath.row].home_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
            
            cell.secondTeam.kf.setImage(with: URL(string: latestEvents?[indexPath.row].away_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
            
            //cell.score.text = "3 : 0"
            
            cell.score.text = latestEvents?[indexPath.row].event_final_result
            return cell
        }
    
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "team", for: indexPath) as! TeamCollectionViewCell
        //cell.teamImg.image = UIImage(named:"pyramids.png")
        //cell.teamName.text = "Pyramids"
        cell.teamName.text = teams?[indexPath.row].team_name
        
        cell.teamImg.kf.setImage(with: URL(string: teams?[indexPath.row].team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        
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
            let TeamViewControllerObj : TeamViewController = self.storyboard?.instantiateViewController(withIdentifier: "team") as! TeamViewController
            
            TeamViewControllerObj.modalPresentationStyle = .fullScreen
            self.present(TeamViewControllerObj, animated: true, completion: nil)
        }
        
    }
    
    func workWithDispatchQueue () {
        
        let group = DispatchGroup()
        
        group.enter()
        
        self.networkfromteams.fetch(url: "https://apiv2.allsportsapi.com/football/?met=Teams&?met=Leagues&leagueId=3&APIkey=59dbd205f73cf075a8012c155eec9c37aa90478a4538caf0066c651dc62bb9b8") { result in
         
            self.teams = result ?? []
             
         
            group.leave()
        }
        
        group.enter()
         
        self.networkfromsevices.fetch(url: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=205&from=2023-02-09&to=2024-02-09&APIkey=59dbd205f73cf075a8012c155eec9c37aa90478a4538caf0066c651dc62bb9b8") { result in
        
             self.upcomingEvents = result
             
         
            group.leave()
        }
        
        group.enter()
        self.networkfromsevices.fetch(url: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=205&from=2022-02-09&to=2023-02-09&APIkey=59dbd205f73cf075a8012c155eec9c37aa90478a4538caf0066c651dc62bb9b8") { result in
         
             self.latestEvents = result
             
         
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.teamCollection.reloadData()
            self.recentComing.reloadData()
            self.comingCollection.reloadData()
        }
    }
}
