//
//  PasswordViewController.swift
//  BloodBank
//
//  Created by CodeBetter on 12/11/19.
//  Copyright © 2019 codebetter. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtOldPassword: UITextField!
    
    @IBOutlet weak var txtNewPassword: UITextField!
    
     var dic:[String:String]=[:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnChange(_ sender: UIButton)
    {
        
        let username = txtUsername.text!
        let oldpassword = txtOldPassword.text!
        let newpassword = txtNewPassword.text!
        
        dic["bloodbankId"] = username
        dic["oldPassword"] = oldpassword
        dic["newPassword"] = newpassword
        print(dic)
        
        //convert dic to json format data
        do
        {
            let data:Data=try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //attach json data with POST request
            let str = "http://192.168.1.13:8080/RedDot/ChangePassword"
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
                    
                    print("Response get Successfully!!!")
                
                    DispatchQueue.main.async {
                        
                        self.navigationController?.popViewController(animated: true)
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
    
        
        
        
        
        
    }


