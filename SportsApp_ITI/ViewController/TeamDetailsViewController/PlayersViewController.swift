//
//  PlayersViewController.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 20/11/1401 AP.
//

import UIKit

class PlayersViewController: UIViewController ,gestureInteraction {

    override func viewDidLoad() {
        super.viewDidLoad()
        gestureInteract()
        // Do any additional setup after loading the view.
    }
    func gestureInteract(){
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

