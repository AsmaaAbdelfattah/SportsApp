//
//  TeamViewController.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 18/11/1401 AP.
//

import UIKit
import Kingfisher
class TeamViewController: UIViewController ,gestureInteraction {
    var url : String?
    var viewModel : ViewModel?
    var responseArr : [Teams]?
    var coach : String?
    var team : Teams?
    @IBOutlet weak var teamPlayerCollection: UICollectionView!
    @IBOutlet weak var TeamCoach: UILabel!
    @IBOutlet weak var TeamImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureInteract()
    TeamImage.kf.setImage(with: URL(string: team?.team_logo ?? "No image"), placeholder: UIImage(named: "real.png"))
   
        TeamCoach.text = "Coach Name : " + coach!
        TeamImage.layer.cornerRadius = (TeamImage.frame.size.width ) / 2
        TeamImage.clipsToBounds = true
      
        TeamImage.layer.borderColor = UIColor.black.cgColor
        TeamImage.layer.masksToBounds = true
//        TeamImage.layer.cornerRadius = TeamImage.frame.size.height / 2
//
//        TeamImage.clipsToBounds = true
//
      TeamImage.layer.borderColor = UIColor.white.cgColor
//
//        TeamImage.layer.borderWidth = 2
        let nib = UINib(nibName: "CustomSportCollectionViewCell", bundle: nil)
        teamPlayerCollection.register(nib, forCellWithReuseIdentifier: "cell")
        
     //    self.teamPlayerCollection.reloadData()
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
}
extension TeamViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {



    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return team?.players?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomSportCollectionViewCell

        cell.nameForSport.text = team?.players?[indexPath.row].player_name

        cell.imgForSport.kf.setImage(with: URL(string: team?.players?[indexPath.row].player_image ?? "No image"), placeholder: UIImage(named: "star.png"))
        cell.layer.borderWidth = CGFloat(5)
    cell.layer.cornerRadius = CGFloat(20)
      

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let TeamViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "player") as! PlayersViewController
     
        TeamViewControllerObj.modalPresentationStyle = .fullScreen
        self.present(TeamViewControllerObj, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (UIScreen.main.bounds.size.width/2) , height: (UIScreen.main.bounds.size.height/5) )

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14.0
    }
  }

    

