//
//  ViewController.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 11/11/1401 AP.
//

import UIKit
import SwiftyGif

class ViewController: UIViewController {

    @IBOutlet weak var gifImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        gifImg.backgroundColor = .black
        gifImg.layer.cornerRadius = 100
        do {
            let gif = try UIImage(gifName: "splash3.gif")
            self.gifImg.setGifImage(gif, loopCount: -1) // Will loop forever
        } catch {
            print(error)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
           
            self.performSegue(withIdentifier: "initial", sender: nil)
        }
        
    }


}

