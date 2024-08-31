//
//  ProfileViewController.swift
//  BloodBank
//
//  Created by CodeBetter on 12/11/19.
//  Copyright © 2019 codebetter. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var lblbloodBankId: UILabel!
    
    @IBOutlet weak var lblContact: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblprofilePicture: UILabel!
    
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblPassword: UILabel!
    
    
    @IBOutlet weak var lblBloodBankName: UILabel!
    
    var dic:[String:String]=[:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Load()
    }
    
    func Load()
    {
    
     dic["bloodbankId"] = "b1"
   
    
    //convert dic to json format data
    do
    {
    let data:Data=try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
    
    //attach json data with POST request
    let str = "http://192.168.1.13:8080/RedDot/ShowProfile"
    let myURL = URL(string: str)!
    var request = URLRequest(url: myURL)
    request.httpMethod = "POST"
    request.httpBody = data
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue(String(data.count), forHTTPHeaderField: "Content-Length")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    //execute request
    URLSession.shared.dataTask(with: request, completionHandler: onDownload).resume()
    
    }
    catch
    {
    print("Error:",error)
    }
    
    }
    func onDownload(data:Data?,response:URLResponse?,err:Error?)
    {
        // convert json response data into dictionary
        if data != nil && err == nil
        {
            do{
                let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                print("Response :-",dic)

                let result = dic["result"] as! String

                if result == "SUCCESS"
                {
                    let resp=dic["data"] as! [String:Any]
                    print(resp)
                    print("Response get Successfully!!!")

                    DispatchQueue.main.async {
                        self.lblEmail.text = resp["email"] as! String
                        self.lblBloodBankName.text = resp["bloodbankName"] as! String
                        self.lblbloodBankId.text = resp["bloodbankId"] as! String
                        self.lblAddress.text = resp["address"] as! String
                        self.lblCity.text = resp["city"] as! String
                        self.lblContact.text = resp["contact"] as! String
                       // self.lblPassword.text = resp["password"] as! String
                        self.lblprofilePicture.text = resp["profilePicture"] as! String
                    }
                }else
                {
                    print("API error:",result)
                }

          }
            catch{
                print("Response Error:",err!)
            }




        }





    }
    
 
    
    @IBAction func btnCancel(_ sender: UIButton) {
       
    }
}
