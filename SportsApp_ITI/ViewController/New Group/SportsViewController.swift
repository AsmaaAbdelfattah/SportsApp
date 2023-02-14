//
//  SportsViewController.swift
//  SportsApp_ITI
//
//  Created by Zeinab on 03/02/2023.
//

import UIKit


class SportsViewController: UIViewController {

    static var  notifCounter  = 0

    var sportsImg: [String]?
    var sportsName: [String]?
    var leagues : [Leagus]?
    var viewModel : ViewModel!
  
    var leaguesUrl =
    ["\(mainUrl)football/?met=Leagues&APIkey=\(APIkey)",
     "\(mainUrl)basketball/?met=Leagues&APIkey=\(APIkey)",
     "\(mainUrl)cricket/?met=Leagues&APIkey=\(APIkey)",
     "\(mainUrl)tennis/?met=Leagues&APIkey=\(APIkey)"]
    
    @IBOutlet weak var Sportscollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sportsImg = ["football.jpg" , "basketball.jpg" , "Cricket.jpg" , "Tennis.jpeg"]
        
        sportsName = ["football" , "basketball" , "cricket" ,  "tennis" ]
        
        
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

        cell.layer.cornerRadius = CGFloat(20)
        
        cell.nameForSport.text = sportsName?[indexPath.row] ?? ""
        cell.imgForSport.image = UIImage(named: sportsImg?[indexPath.row] ?? "")
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: (UIScreen.main.bounds.size.width/2) - 30, height: (UIScreen.main.bounds.size.height/3) - 30)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            let legeusViewControllerObj : LegeusViewController = self.storyboard?.instantiateViewController(withIdentifier: "legeus") as! LegeusViewController
            
        legeusViewControllerObj.url = leaguesUrl[indexPath.row]
           
        legeusViewControllerObj.sport = sportsName![indexPath.row]
        
        self.navigationController?.pushViewController(legeusViewControllerObj, animated: true)
        }

  
}
