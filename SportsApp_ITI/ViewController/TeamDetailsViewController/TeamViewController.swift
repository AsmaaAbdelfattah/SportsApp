//
//  TeamViewController.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 18/11/1401 AP.
//

import UIKit

class TeamViewController: UIViewController {
    var url : String?
    var viewModel : ViewModel?
    var responseArr : [Teams]?
  
    @IBOutlet weak var teamPlayerCollection: UICollectionView!
    @IBOutlet weak var TeamCoach: UILabel!
    @IBOutlet weak var TeamImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        url = "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=4&APIkey=59dbd205f73cf075a8012c155eec9c37aa90478a4538caf0066c651dc62bb9b8"
        TeamImage.image = UIImage(named: "football.png")
  

        TeamImage.layer.cornerRadius = TeamImage.frame.size.width / 2

        TeamImage.clipsToBounds = true

        TeamImage.layer.borderColor = UIColor.white.cgColor

        TeamImage.layer.borderWidth = 2
        let nib = UINib(nibName: "CustomSportCollectionViewCell", bundle: nil)
        teamPlayerCollection.register(nib, forCellWithReuseIdentifier: "cell")
        viewModel = ViewModel()
         viewModel?.getLeague(url: url ?? "")
         viewModel?.bindResultToViewController = {() in
             self.renderView()
         }
         self.teamPlayerCollection.reloadData()
    }
    func renderView(){
//        DispatchQueue.main.async {
//            self.responseArr = self.viewModel?.resultLeagues
//            self.teamPlayerCollection.reloadData()
//        }
    }
}
extension TeamViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomSportCollectionViewCell
        
        cell.nameForSport.text = "Mohamed Salah"
        cell.imgForSport.image = UIImage(named:  "real.png" )
        cell.layer.borderWidth = CGFloat(5)
        cell.layer.cornerRadius = CGFloat(20)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: (UIScreen.main.bounds.size.width/2) - 30, height: (UIScreen.main.bounds.size.height/5) - 15)
       
    }
    
  }

    

