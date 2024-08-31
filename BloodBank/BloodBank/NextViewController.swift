//
//  NextViewController.swift
//  BloodBank
//
//  Created by CodeBetter on 12/11/19.
//  Copyright © 2019 codebetter. All rights reserved.
//

import UIKit

class NextViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate {
   
    var dic:[String:String]=[:]
    var arrUser:[[String:Any]]=[]
     var refArr:AddViewController?
   
    @IBOutlet weak var fieldView: UIView!
    
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var txtblood: UITextField!
    
    @IBOutlet weak var tblView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    @IBAction func btnChngPassword(_ sender: UIButton)
    {
        let PVC = self.storyboard?.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
        self.navigationController?.pushViewController(PVC, animated: true)
    }
        
    
    @IBAction func btnProfile(_ sender: UIButton)
    {
        
        let PrVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(PrVC, animated: true)
    }
        
    
    
    
    @IBAction func btnAdd(_ sender: UIButton) {
        let AddVc=self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        self.navigationController?.pushViewController(AddVc, animated: true)
        
        
        
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
    @IBAction func btnBloodGroup(_ sender: UIButton) {
        let bVC=self.storyboard?.instantiateViewController(withIdentifier: "BloodGroupViewController") as! BloodGroupViewController
       
        bVC.refNvc = self
        
        bVC.modalPresentationStyle = UIModalPresentationStyle.popover
        bVC.preferredContentSize = CGSize(width: 380, height: 300)
        bVC.popoverPresentationController!.delegate = self
        
       self.present(bVC, animated: true, completion: nil)
    
        
        let popOver = bVC.popoverPresentationController
        popOver?.sourceView = txtblood
        popOver?.sourceRect = txtblood.bounds
        popOver?.permittedArrowDirections = UIPopoverArrowDirection.up
        
        
        
    }
    
    func getCustomerList()
    {
        dic["city"] = txtCity.text!
        dic["bloodGroup"] = txtblood.text!
        print("AvailibilityAPI!!!",dic)
        
        do
        {
            let data:Data=try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //attach json data with POST request
            let str = "http://192.168.1.13:8080/RedDot/AvailibilityCheck"
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
            print("Error-->",error)
        }
        
        
    }
    
    
    func onDownload(data:Data?,response:URLResponse?,err:Error?)
    {
        
        if data != nil && err == nil
        {
            do{
                
                let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                print("Response:-",dic)
                
                let result = dic["result"] as! String
                
                if result == "SUCCESS"
                {
                    arrUser = dic["data"] as! [[String:Any]]
                   
                    DispatchQueue.main.async
                        {
                            self.tblView.reloadData()
                    }
                    
                    
                }
                else
                {
                    
                    print("Error:-",err)
                    
                }
                
                
            }
            catch
            {
                print("Error-->",error)
                
            }
            
            
            
        }
        
        
        
        
    }
    
    @IBAction func btnCheck(_ sender: UIButton) {
     
        let city = txtCity.text!
        let bGroup = txtblood.text!
        
        if city.count > 0 && bGroup.count > 0
        {
            getCustomerList()
            tblView.isHidden = false
        }else
        {
            print("Enter required Field")
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NextTableViewCell
        
        let dic = arrUser[indexPath.row]
       
        
        
        let gDic = dic["bloodbank"] as! [String:Any]
        let name = gDic["bloodbankName"] as? String
        let bloodbankId = gDic["bloodbankId"] as? String
        let contact = gDic["contact"] as? String
        let email = gDic["email"] as? String
        let address = gDic["address"] as? String
        let city = gDic["city"] as? String
        let bloodbankName = gDic["bloodbankName"] as? String
       
        cell.lblbloodbankId.text = "bloodbankId: \(bloodbankId ?? "NA")"
         cell.lblcontact.text = "Contact: \(contact ?? "NA")"
         cell.lblemail.text = "Email: \(email ?? "NA")"
         cell.lbladdress.text = "Address: \(address ?? "NA")"
        cell.lblCity.text = "City: \(city ?? "NA")"
        cell.lblUserName.text = "Name: \(name ?? "NA")"
        
       
      
        
        cell.refNVc = self
        cell.indexPath = indexPath
        
        return cell
        
    }
    
    
    @IBAction func btnList(_ sender: UIButton)
        {
            
            dic["bloodbankId"] = "b1"
            
            print(dic)
            
            //convert dic to json format data
            do
            {
                let data:Data=try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
                
                //attach json data with POST request
                //"http://192.168.1.13:8080/RedDot​/​BloodBankBloodUnitList"
                let str:String = "http://192.168.1.13:8080/RedDot/BloodBankBloodUnitList"
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
    
    
    func onDownloadd(data:Data?,response:URLResponse?,err:Error?)
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
                        let lVC = self.storyboard?.instantiateViewController(withIdentifier: "ListOfDonorsViewController") as! ListOfDonorsViewController
                        self.navigationController?.pushViewController(lVC, animated: true)
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
