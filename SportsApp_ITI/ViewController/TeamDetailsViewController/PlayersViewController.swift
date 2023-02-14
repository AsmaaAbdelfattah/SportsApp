//
//  PlayersViewController.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 20/11/1401 AP.
//

import UIKit

class PlayersViewController: UIViewController ,gestureInteraction {
    @IBOutlet weak var yellowCards: UILabel!
    
    @IBOutlet weak var plNumber: UILabel!
    @IBOutlet weak var goals: UILabel!
    @IBOutlet weak var redCards: UILabel!
    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    var name :String?
    var number : String?
    var goalNum : String?
    var rCards : String?
    var yCards : String?
    var img : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureInteract()
        // Do any additional setup after loading the view.
        plNumber.text = ( "Player Number " + (number ?? "unKnown"))
        goals.text = ("Goal Numbers " + (goalNum ?? "unKnown"))
        redCards.text = rCards ?? "unKnown"
      
        playerName.text = ("Player Name : " + (name ?? "unKnown"))
         yellowCards.text = yCards ?? "unKnown"
        
        playerImg.kf.setImage(with: URL(string: img ?? "No image"), placeholder: UIImage(named: "none.png"))
        
        
    }
    
    
    func
    
    gestureInteract(){
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissVC))
                gesture.direction = .left
        view.isUserInteractionEnabled = true
        
                view.addGestureRecognizer(gesture)
    }
    @objc
       func dismissVC() {
           dismiss(animated: true)
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

