//
//  BloodGroupViewController.swift
//  BloodBank
//
//  Created by anova on 15/11/19.
//  Copyright © 2019 codebetter. All rights reserved.
//

import UIKit

class BloodGroupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
   

    @IBOutlet weak var tblView: UITableView!
    
    var refNvc:NextViewController?
    var arrBlood:[String] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        arrBlood.append("A+")
        arrBlood.append("A-")
        arrBlood.append("B+")
        arrBlood.append("B-")
        arrBlood.append("O+")
        arrBlood.append("O-")
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  arrBlood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BloodGroupTableViewCell
       let lblmsg = cell.viewWithTag(10) as! UILabel
        lblmsg.text = arrBlood[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let grp = arrBlood[indexPath.row]
        refNvc?.txtblood.text = grp
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnOk(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
