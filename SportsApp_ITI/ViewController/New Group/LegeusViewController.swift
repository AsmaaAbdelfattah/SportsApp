//
//  LegeusViewController.swift
//  SportsApp_ITI
//
//  Created by Zeinab on 03/02/2023.
//

import UIKit
import Kingfisher

class LegeusViewController: UIViewController {
    
    var sport : String = ""
    var networkService : NetworkService?
    var responseArr : LeguesData?
    var searchedLeagues : [Leagus]?
    var url : String?
    var viewModel : ViewModel?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var LegeusTableVeiw: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 10
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
            self.searchedLeagues = self.responseArr?.result
            self.LegeusTableVeiw.reloadData()
        }
    }
}

extension LegeusViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchedLeagues?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return CGFloat(1)
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView : UIView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("/////\(indexPath.section)/////////")
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell

        
        cell.layer.cornerRadius = cell.frame.height/3
        
        cell.leagueImg.kf.setImage(with: URL(string: (searchedLeagues?[indexPath.section].league_logo) ?? "no image"), placeholder: UIImage(named: "none.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        
    
        cell.leagueImg?.layer.cornerRadius = 30
        cell.leagueImg?.clipsToBounds = true
       // cell.leagueImg?.layer.borderColor = UIColor.white.cgColor
      //  cell.leagueImg?.layer.masksToBounds = false
        
        cell.leagueName.text = searchedLeagues?[indexPath.section].league_name
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let storyBoard = UIStoryboard(name: "FavouriteStoryboard", bundle: nil)
        
        let legeusDetailsObj = storyBoard.instantiateViewController(withIdentifier: "Details") as! DetailsLeagueController
        
        legeusDetailsObj.LGKey = (searchedLeagues?[indexPath.section].league_key)!
        legeusDetailsObj.spLabel = sport
        legeusDetailsObj.league = searchedLeagues?[indexPath.section]
        legeusDetailsObj.leagueName = (searchedLeagues?[indexPath.section].league_name)!
        
        legeusDetailsObj.modalPresentationStyle = .fullScreen
        self.present(legeusDetailsObj , animated: true, completion: nil)
    }
}

extension LegeusViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
        searchedLeagues = []
        
        if searchText == "" {
            searchedLeagues = responseArr?.result
        }
        
        for letter in responseArr!.result
        {
            
            if letter.league_name.uppercased().contains(searchText.uppercased())
            {
                searchedLeagues?.append(letter)
            }
        }
        
        self.LegeusTableVeiw.reloadData()
    }
    
}
