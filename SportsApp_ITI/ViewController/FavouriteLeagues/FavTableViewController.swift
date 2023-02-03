//
//  FavTableViewController.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 11/11/1401 AP.
//

import UIKit
import CoreData

class FavTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
              self.tableView.register(nib, forCellReuseIdentifier: "customCell")
        
    }

 
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 15
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell

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
        
        //Open Youtube
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cell.YTIcon.isUserInteractionEnabled = true
        cell.YTIcon.addGestureRecognizer(tapGestureRecognizer)
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
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        
        let view = self.storyboard?.instantiateViewController(withIdentifier: "Details") as! DetailsLeagueController
        view.modalPresentationStyle = .fullScreen
        self.present(view , animated: true, completion: nil)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
