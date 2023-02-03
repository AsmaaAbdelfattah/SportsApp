//
//  LegeusViewController.swift
//  SportsApp_ITI
//
//  Created by Zeinab on 03/02/2023.
//

import UIKit

class LegeusViewController: UIViewController {

    
    @IBOutlet weak var LegeusTableVeiw: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LegeusTableVeiw.layer.cornerRadius = 10
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        LegeusTableVeiw.register(nib, forCellReuseIdentifier: "customCell")
    }
}

extension LegeusViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
        
        cell.layer.borderWidth = CGFloat(2)
        cell.layer.cornerRadius = CGFloat(10)
        
        // Configure the cell...
        cell.YTIcon.image = UIImage(named: "youtube.png")
        cell.leagueImg.image = UIImage(named: "youtube.png")
        cell.leagueName.text = "Try"
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
    
}
