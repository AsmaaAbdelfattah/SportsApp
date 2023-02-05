//
//  SportsViewController.swift
//  SportsApp_ITI
//
//  Created by Zeinab on 03/02/2023.
//

import UIKit

class SportsViewController: UIViewController {

    var sportsImg: [String]?
    var sportsName: [String]?
    var leagues : [Leagus]?
    var viewModel : ViewModel!
    
    var leaguesUrl =
    ["https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=59dbd205f73cf075a8012c155eec9c37aa90478a4538caf0066c651dc62bb9b8",
        "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=59dbd205f73cf075a8012c155eec9c37aa90478a4538caf0066c651dc62bb9b8",
      "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=59dbd205f73cf075a8012c155eec9c37aa90478a4538caf0066c651dc62bb9b8",
      "https://apiv2.allsportsapi.com/hockey/?met=Leagues&APIkey=59dbd205f73cf075a8012c155eec9c37aa90478a4538caf0066c651dc62bb9b8",
       "https://apiv2.allsportsapi.com/baseball/?met=Leagues&APIkey=59dbd205f73cf075a8012c155eec9c37aa90478a4538caf0066c651dc62bb9b8",
       "https://apiv2.allsportsapi.com/amircanfootball/?met=Leagues&APIkey=59dbd205f73cf075a8012c155eec9c37aa90478a4538caf0066c651dc62bb9b8"]
    
    @IBOutlet weak var Sportscollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sportsImg = ["football.jpg" , "basketball.jpg" , "Cricket.jpg" , "Hockey.jpeg" , "Baseball.jpeg" , "AmericanFootball.jpeg"]
        
        sportsName = ["Football" , "Basketball" , "Cricket" , "Hockey" , "Baseball" , "AmericanFootball"]
        

        let nib = UINib(nibName: "CustomSportCollectionViewCell", bundle: nil)
        Sportscollection.register(nib, forCellWithReuseIdentifier: "cell")
        
        
        
    }
    

}

extension SportsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsName?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomSportCollectionViewCell
        
        cell.nameForSport.text = sportsName?[indexPath.row] ?? ""
        cell.imgForSport.image = UIImage(named: sportsImg?[indexPath.row] ?? "")
        cell.layer.borderWidth = CGFloat(5)
        cell.layer.cornerRadius = CGFloat(20)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: (UIScreen.main.bounds.size.width/2) - 30, height: (UIScreen.main.bounds.size.height/5) - 15)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if(indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5){
                          let alert = UIAlertController(title: "We Are Sorry!", message: "This Sport Not available", preferredStyle: UIAlertController.Style.alert)
                          alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                          present(alert, animated: true, completion: nil)
        }
        else{
            let legeusViewControllerObj : LegeusViewController = self.storyboard?.instantiateViewController(withIdentifier: "legeus") as! LegeusViewController
            legeusViewControllerObj.url = leaguesUrl[indexPath.row]
            //legeusViewControllerObj.responseArr = leagues
            
            self.navigationController?.pushViewController(legeusViewControllerObj, animated: true)
        }}

    
}
