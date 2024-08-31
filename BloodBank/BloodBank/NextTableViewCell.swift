//
//  NextTableViewCell.swift
//  BloodBank
//
//  Created by anova on 15/11/19.
//  Copyright © 2019 codebetter. All rights reserved.
//

import UIKit

class NextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblemail: UILabel!
    
   
    @IBOutlet weak var lbladdress: UILabel!
    
    
    @IBOutlet weak var lblbloodbankId: UILabel!
    
    
    @IBOutlet weak var lblcontact: UILabel!
    
    
    
    
    
    
    var refNVc:NextViewController?
    var indexPath:IndexPath?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
