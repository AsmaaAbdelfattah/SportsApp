//
//  LegeusViewController.swift
//  SportsApp_ITI
//
//  Created by Zeinab on 03/02/2023.
//

import UIKit
import Kingfisher

class LegeusViewController: UIViewController {
    
    
    @IBOutlet weak var LegeusTableVeiw: UITableView!
    var networkService : NetworkService?
    var responseArr : [Leagus]?
    var url : String?
    var viewModel : ViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LegeusTableVeiw.layer.cornerRadius = 10
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        LegeusTableVeiw.register(nib, forCellReuseIdentifier: "customCell")
        
       viewModel = ViewModel()
        viewModel?.getLeague(url: url ?? "")
        viewModel?.bindResultToViewController = {() in
            self.renderView()
        }
        self.LegeusTableVeiw.reloadData()
        
    }
    
    func renderView(){
        DispatchQueue.main.async {
            self.responseArr = self.viewModel?.resultLeagues
            self.LegeusTableVeiw.reloadData()
        }
    }
}
extension LegeusViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("/////\(indexPath.row)/////////")
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
//        networkService = NetworkService()
//        networkService?.fetch(url:url ,compiletionHandler:
//        { request in
//            DispatchQueue.main.async { [self] in
//
//                self.responseArr = request ?? nil
//                self.LegeusTableVeiw.reloadData()
//
//            }
//
//        })
 
        
        cell.layer.borderWidth = CGFloat(2)
        cell.layer.cornerRadius = CGFloat(10)
        
        // Configure the cell...
        cell.YTIcon.image = UIImage(named: "youtube.png")
        cell.leagueImg.kf.setImage(with: URL(string: (responseArr?[indexPath.row].league_logo) ?? "no image"), placeholder: UIImage(named: "youtube.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        //cell.leagueImg.image = UIImage(named: responseArr?[indexPath.row].league_logo ?? "youtube.png")
        cell.leagueName.text = responseArr?[indexPath.row].league_name
        cell.leagueImg?.layer.cornerRadius = (cell.leagueImg?.frame.size.width ?? 0.0) / 2
        cell.leagueImg?.clipsToBounds = true
       
        cell.leagueImg?.layer.borderColor = UIColor.white.cgColor
        cell.leagueImg?.layer.masksToBounds = false
        cell.YTIcon?.layer.cornerRadius = (cell.leagueImg?.frame.size.width ?? 0.0) / 2
        cell.YTIcon?.clipsToBounds = true
        
        cell.YTIcon?.layer.borderColor = UIColor.white.cgColor
        cell.YTIcon?.layer.masksToBounds = false
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let storyBoard = UIStoryboard(name: "FavouriteStoryboard", bundle: nil)
        
        let legeusDetailsObj = storyBoard.instantiateViewController(withIdentifier: "Details") as! DetailsLeagueController
        
        legeusDetailsObj.modalPresentationStyle = .fullScreen
        
        legeusDetailsObj.league = responseArr?[indexPath.row]
        self.present(legeusDetailsObj , animated: true, completion: nil)
    }
}
