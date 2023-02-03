//
//  DetailsLeagueController.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 12/11/1401 AP.
//

import UIKit

class DetailsLeagueController: UIViewController ,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource{
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var teamCollection: UICollectionView!
    @IBOutlet weak var recentComing: UICollectionView!
    @IBOutlet weak var comingCollection: UICollectionView!

    @IBOutlet weak var favBtn: UIButton!
    var iconFav = ["star.png", "filledStar.png"]
    var stateSelected = 0
    override func viewDidLoad() {
        super.viewDidLoad()

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
          
            stateSelected += 1
        }
        else{
            favBtn.setBackgroundImage(UIImage(named: iconFav[0]), for: .normal)
    
            stateSelected = 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == comingCollection){
            return 15
        }
        else if(comingCollection == recentComing){
            return 10
        }
     
            return 5
      
    }
    
     
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == comingCollection){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coming", for: indexPath) as! comCollectionViewCell
            cell.team1.image =  UIImage(named: "liverpool.png")
            cell.team2.image =  UIImage(named:"manc.png")
           return cell
        }
        else if(collectionView == recentComing){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recent", for: indexPath) as! recCollectionViewCell
            cell.firstTeam.image = UIImage(named:"real.png")
            cell.secondTeam.image =  UIImage(named:"sp.png")
            cell.score.text = "3 : 0"
            return cell
        }
    
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "team", for: indexPath) as! TeamCollectionViewCell
        cell.teamImg.image = UIImage(named:"pyramids.png")
        cell.teamName.text = "Pyramids"
           return cell
       
    }
    func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width:collectionView.frame.size.width
                     , height: collectionView.frame.size.height)

         }

         func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
             return 5.0
         }

     
   

}
