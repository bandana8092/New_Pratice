//
//  PostsTableViewCell.swift
//  Bandana_Pratice_2
//
//  Created by Rakesh Nangunoori on 31/01/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
  
        // Configure the view for the selected state
    }
    //Mark:-Cell Update
       func updateCell(postModel:[PostModel],indexPath:IndexPath){
           self.switchButton.isUserInteractionEnabled = false
           self.titleLabel.text = postModel[indexPath.row].title
           self.createdLabel.text = postModel[indexPath.row].createdDate.convertdateToFormate(formate: "dd MMM YYY")
           self.switchButton.isOn =  postModel[indexPath.row].switchStatus
           self.contentView.backgroundColor = postModel[indexPath.row].switchStatus ? UIColor.lightText : UIColor.white
    }
           
}
