//
//  AddViewController.swift
//  BloodBank
//
//  Created by CodeBetter on 12/11/19.
//  Copyright © 2019 codebetter. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UIPopoverPresentationControllerDelegate,  DatePickerViewCountrollerDelegate{
    
    
    var refDate:DatePickerViewController?
    var refArrr:NextViewController?
   
    
    @IBOutlet weak var txtbagNo: UITextField!
    
    @IBOutlet weak var txtbloodGroup: UITextField!
    
    @IBOutlet weak var txtQuantity: UITextField!
    
    
    @IBOutlet weak var txtDate: UITextField!
    
    
    @IBOutlet weak var txtExpiryDate: UITextField!
    
    @IBOutlet weak var txtDonorName: UITextField!
    
    @IBOutlet weak var txtDonorContact: UITextField!
    
    @IBOutlet weak var txtStatus: UITextField!
    
    
    @IBOutlet weak var txtBloodId: UITextField!
    
    
    var dic:[String:Any]=[:]
    var str:String=""
    var bId:String=""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
       
    }
    func didSelectedDate(date: Date,viewConName:String) {
        print("Date",date)
        
        let dater:DateFormatter = DateFormatter()
        dater.dateFormat = "dd-MM-yyy"
        str = dater.string(from: date)
        
        if viewConName == "first"
        {
            txtDate.text = "\(str)"
        }
        else if viewConName == "second"
        {
            txtExpiryDate.text = "\(str)"
        }
      
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    @IBAction func btnBloodGroup(_ sender: UIButton) {
        
    }
    
    @IBAction func btnDatePicker(_ sender: UIButton) {
        let dVC = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        dVC.delegate=self
        dVC.getConName="first"
       // self.navigationController?.pushViewController(dVC, animated: true)
//        let dVC = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController

        //dVC.r = self

        dVC.modalPresentationStyle = UIModalPresentationStyle.popover
        dVC.preferredContentSize = CGSize(width: 375, height: 400)
        dVC.popoverPresentationController!.delegate = self


        self.present(dVC,animated: true,completion: nil)

        let popOver = dVC.popoverPresentationController
        popOver?.sourceView = txtDate
        popOver?.sourceRect = txtDate.bounds
        popOver?.permittedArrowDirections = UIPopoverArrowDirection.up
  }
    
    @IBAction func btnDate(_ sender: UIButton) {
        
        let dateVC = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        dateVC.delegate=self
        dateVC.getConName="second"
      //  self.navigationController?.pushViewController(dateVC, animated: true)
        
        dateVC.modalPresentationStyle = UIModalPresentationStyle.popover
        dateVC.preferredContentSize = CGSize(width: 375, height: 400)
        dateVC.popoverPresentationController!.delegate = self
        
        
        self.present(dateVC,animated: true,completion: nil)
        
        let popOver = dateVC.popoverPresentationController
        popOver?.sourceView = txtExpiryDate
        popOver?.sourceRect = txtExpiryDate.bounds
        popOver?.permittedArrowDirections = UIPopoverArrowDirection.up
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        
            
            let bagNo = txtbagNo.text!
            let bloodGroup = txtbloodGroup.text!
            let quan = Int(txtQuantity.text!)!
            let submitdate = txtDate.text!
            let expirydate = txtExpiryDate.text!
            let donorName = txtDonorName.text!
            let donorContact = txtDonorContact.text!
            let status = txtStatus.text!
        
            dic["bloodBankId"]="b1"
            dic["bagNo"] = bagNo
            dic["bloodGroup"] = bloodGroup
            dic["quantity"] = quan
            dic["submissionDate"] = submitdate
            dic["expiryDate"] = expirydate
            dic["donorName"] = donorName
            dic["donorContact"] = donorContact
            dic["status"] = status
        
            print(dic)
            
            //convert dic to json format data
            do
            {
                let data:Data=try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
                
                //attach json data with POST request
                let str = "http://192.168.1.13:8080/RedDot/BloodUnitEntry"
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
    
    
    
    
    @IBAction func btnCancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
  
    
    
    
    
}
