//
//  DatePickerViewController.swift
//  BloodBank
//
//  Created by anova on 14/11/19.
//  Copyright © 2019 codebetter. All rights reserved.
//

import UIKit

protocol DatePickerViewCountrollerDelegate
{
    func didSelectedDate(date:Date,viewConName:String) -> Void
}


class DatePickerViewController: UIViewController {
    
    var ref:AddViewController?
    var delegate:DatePickerViewCountrollerDelegate?
    var getConName:String=""
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func btnOk(_ sender: UIButton) {
       
        print(datePicker.date)
        if delegate != nil
        {
            delegate?.didSelectedDate(date: datePicker!.date,viewConName:getConName)
            
        }
        self.dismiss(animated: true, completion: nil)
     //  self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
    
      self.navigationController?.popViewController(animated: true)
    
    
    }
    
    
}
