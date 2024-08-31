//
//  ViewController.swift
//  BloodBank
//
//  Created by CodeBetter on 12/11/19.
//  Copyright © 2019 codebetter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var dic:[String:String]=[:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden=true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        txtEmail.text = "b1@gmail.com"
        txtPassword.text = "123"
    }
    
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        let name = txtEmail.text!
        let password = txtPassword.text!
        
        dic["email"] = name
        dic["password"] = password
        print(dic)
        
        //convert dic to json format data
        do
        {
            let data:Data=try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //attach json data with POST request
            let str = "http://192.168.1.13:8080/RedDot/BloodBankLogin"
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
                        let lVC = self.storyboard?.instantiateViewController(withIdentifier: "NextViewController") as! NextViewController
                   self.navigationController?.pushViewController(lVC, animated: true)
                    }
                }else
                    {
                        print("API error:",result)
                    }
                    
                    DispatchQueue.main.async {
                        self.txtEmail.text = nil
                        self.txtPassword.text = nil
                        
                    }
        }
                catch{
                    print("Response Error:",err!)
                }
        
        
        
        
    }
    
    
    


}

}
