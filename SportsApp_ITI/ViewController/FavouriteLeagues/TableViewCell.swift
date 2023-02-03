//
//  TableViewCell.swift
//  SportsApp_ITI
//
//  Created by Asmaa_Abdelfattah on 11/11/1401 AP.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var YTIcon: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueImg: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
