//
//  Utils.swift
//  CRUDDemo
//
//  Created by Agustín Embuena on 4/11/21.
//
import Foundation
import UIKit

extension Date {
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toRequestString(format: String = "yyyy-MM-dd'T'HH:mm:ss'.661Z'") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date {
        var string = self
        if self.contains("."){
            string = String(self.split(separator: ".")[0])
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: string) else {
            preconditionFailure("Take a look to your format")
        }        
        return date
    }
    
    func toDateRequest(withFormat format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            preconditionFailure("Take a look to your format")
        }
        return date
    }
}



extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        // iOS 14 and above
        if #available(iOS 14, *) {// Added condition for iOS 14
          datePicker.preferredDatePickerStyle = .wheels
          datePicker.sizeToFit()
        }
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}
