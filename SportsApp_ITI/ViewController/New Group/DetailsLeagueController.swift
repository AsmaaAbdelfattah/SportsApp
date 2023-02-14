//
//  DetailsLeagueController.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 12/11/1401 AP.
//

import UIKit
import CoreData
import Kingfisher

class DetailsLeagueController: UIViewController,gestureInteraction , ToastMessage  {
   
    
    @IBOutlet weak var LeagueTitle: UILabel!
    var LGKey : Int = 0
    var leagueFromCoreData : [NSManagedObject]!
    var spLabel : String = ""
    @IBOutlet weak var TPLabel: UILabel!
    var managedContext : NSManagedObjectContext!
  
   // var networkfromteams : ServicesForTeams = NetworkServiceForTeams()
   // var networkfromsevices: ServicesForEvents = NetworkServiceForEvents()
   // var network: Services = NetworkService()
  
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
    var viewModel : ViewModel?
    var coreData : CoreDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LeagueTitle.text = league?.league_name
        LeagueTitle.adjustsFontSizeToFitWidth = true
        teamCollection.layer.cornerRadius = 4
        recentComing.layer.cornerRadius = 4
        comingCollection.layer.cornerRadius = 4
        if(spLabel == "tennis"){
            TPLabel.text = "Players"
            TPLabel.adjustsFontSizeToFitWidth = true
        }
   
        viewModel = ViewModel()
        coreData = viewModel?.getInstance()
        if (coreData?.isFavourite(leagueKey: LGKey))!
        {
            stateSelected = 1
            favBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
            
        } else {
            stateSelected = 0
            favBtn.setImage(UIImage(systemName: "star"), for: .normal)
            
        }
            
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
        
        if stateSelected == 1
        {

            coreData?.deleteFromCoreData(leagueKey: LGKey)
            showToast(message: "\(league?.league_name ?? "") Removed From Your Favourites")
           // favBtn.setBackgroundImage(UIImage(named: iconFav[0]), for: .normal)
            favBtn.setImage(UIImage(systemName: "star"), for: .normal)
            stateSelected = 0
            
        }
        else{
            
            coreData?.saveToCoreData(league: league! , sportName: spLabel)
           // favBtn.setBackgroundImage(UIImage(named: iconFav[1]), for: .normal)
            favBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
            showToast(message: "\(league?.league_name ?? "" ) Added to Your Favourites")
            
            stateSelected = 1
           
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
           
            if spLabel == "football" {
                cell.team1.kf.setImage(with: URL(string: upcomingEvents?.result[indexPath.row].home_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
       
                cell.team2.kf.setImage(with: URL(string: upcomingEvents?.result[indexPath.row].away_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
            } else {
                cell.team1.kf.setImage(with: URL(string: upcomingEvents?.result[indexPath.row].event_home_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
          
                cell.team2.kf.setImage(with: URL(string: upcomingEvents?.result[indexPath.row].event_away_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
            
            }
            cell.timeEvent.text =  upcomingEvents?.result[indexPath.row].event_time
            cell.DateEvent.text =  upcomingEvents?.result[indexPath.row].event_date
            
           return cell
        }
        else if(collectionView == recentComing){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recent", for: indexPath) as! recCollectionViewCell
   
            if spLabel == "football" {
                cell.firstTeam.kf.setImage(with: URL(string: latestEvents?.result[indexPath.row].home_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
                cell.firstTeam.layer.cornerRadius = ( cell.firstTeam.frame.size.width ) / 2
                cell.firstTeam.clipsToBounds = true
              
                cell.firstTeam.layer.borderColor = UIColor.black.cgColor
                cell.firstTeam.layer.masksToBounds = true
                cell.secondTeam.kf.setImage(with: URL(string: latestEvents?.result[indexPath.row].away_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
                cell.secondTeam.layer.cornerRadius = ( cell.secondTeam.frame.size.width ) / 2
                cell.secondTeam.clipsToBounds = true
              
                cell.secondTeam.layer.borderColor = UIColor.black.cgColor
                cell.secondTeam.layer.masksToBounds = true
            } else {
                cell.firstTeam.kf.setImage(with: URL(string: latestEvents?.result[indexPath.row].event_home_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
                cell.firstTeam.layer.cornerRadius = ( cell.firstTeam.frame.size.width ) / 2
                cell.firstTeam.clipsToBounds = true
              
                cell.firstTeam.layer.borderColor = UIColor.black.cgColor
                cell.firstTeam.layer.masksToBounds = true
                cell.secondTeam.kf.setImage(with: URL(string: latestEvents?.result[indexPath.row].event_away_team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
                cell.secondTeam.layer.cornerRadius = ( cell.secondTeam.frame.size.width ) / 2
                cell.secondTeam.clipsToBounds = true
              
                cell.secondTeam.layer.borderColor = UIColor.black.cgColor
                cell.secondTeam.layer.masksToBounds = true
            }
            
            
            cell.score.text = latestEvents?.result[indexPath.row].event_final_result
            
       
            return cell
        }
        if(spLabel == "tennis"){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "team", for: indexPath) as! TeamCollectionViewCell
       
            cell.teamName.text = teams?.result[indexPath.row].players?[indexPath.row].player_name
        
            cell.teamImg.kf.setImage(with: URL(string: teams?.result[indexPath.row].players?[indexPath.row].player_image ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        
           return cell
        }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "team", for: indexPath) as! TeamCollectionViewCell
       
        cell.teamName.text = teams?.result[indexPath.row].team_name
        
        cell.teamImg.kf.setImage(with: URL(string: teams?.result[indexPath.row].team_logo ?? "No image"), placeholder: UIImage(named: "real.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        
           return cell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width:collectionView.frame.size.width
                     , height: collectionView.frame.size.height)

         }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if(collectionView == teamCollection){
            
            if(spLabel == "tennis"){
                let PlayersViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "player") as! PlayersViewController
                
                PlayersViewControllerObj.modalPresentationStyle = .fullScreen
                self.present(PlayersViewControllerObj, animated: true, completion: nil)
            }
            else{
                let TeamViewControllerObj : TeamViewController = self.storyboard?.instantiateViewController(withIdentifier: "team") as! TeamViewController
                
                TeamViewControllerObj.team = teams!.result[indexPath.row]
                TeamViewControllerObj.coach = (teams!.result[indexPath.row].coaches?[0].coach_name) ?? "no avaliable data"
                TeamViewControllerObj.modalPresentationStyle = .fullScreen
                self.present(TeamViewControllerObj, animated: true, completion: nil)
            }
            
        }}
    
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
    
    func workWithDispatchQueue () {
        
        let group = DispatchGroup()
        
        group.enter()
        viewModel?.getTeams(url: "https://apiv2.allsportsapi.com/\(spLabel)/?met=Teams&?met=Leagues&leagueId=\(LGKey)&APIkey=\(APIkey)")
        viewModel?.bindResultToViewControllerForTeams = {() in
            self.teams = self.viewModel?.Teams
            group.leave()
        }
        
        group.enter()
        
        viewModel?.getUpcominEvents(url: "https://apiv2.allsportsapi.com/\(spLabel)/?met=Fixtures&leagueId=\(LGKey)&from=2023-02-09&to=2024-02-09&APIkey=\(APIkey)")
        viewModel?.bindResultToViewControllerForUpcomingEvents = {() in
            self.upcomingEvents = self.viewModel?.upCominevents
            group.leave()
        }
        
        group.enter()
        
        viewModel?.getLatestEvents(url: "https://apiv2.allsportsapi.com/\(spLabel)/?met=Fixtures&leagueId=\(LGKey)&from=2022-02-09&to=2023-02-09&APIkey=\(APIkey)")
        viewModel?.bindResultToViewControllerForLatestEvents = {() in
            self.latestEvents = self.viewModel?.latestevents
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.teamCollection.reloadData()
            self.recentComing.reloadData()
            self.comingCollection.reloadData()
        }
    }
    
    
}
