//
//  CreateUserTableViewController.swift
//  CRUDDemo
//
//  Created by Agustín Embuena on 4/11/21.
//




import UIKit
import Alamofire

class CreateUserTableViewController: UITableViewController {
    
    var user : User?
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.becomeFirstResponder()
        self.birthdateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = self.user else {
            //new user
            return
        }
        self.nameTextField.text = user.name
        self.birthdateTextField.text = UserModule.service.prettyDate(user.birthdate)
    }
    
    // MARK: - IBActions
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        guard let name = nameTextField.text,
              !name.isEmpty else {
                  ErrorPresenter.showError(message: "You must specify a name", on: self)
                  return
              }
        
        guard let birthdate = birthdateTextField.text,
              !birthdate.isEmpty else {
                  ErrorPresenter.showError(message: "You must specify a birthdate", on: self)
                  return
              }
        
        guard let _ = self.user else {
            createUser(name, birthdate)
            return
        }
        
        editUser(name, birthdate)
    }
    
    func editUser(_ name:String, _ birthdate:String){
        self.user?.name = name
        self.user?.birthdate = birthdate
        UserModule.service.editUser(user!) { [weak self] success in
            if !success {
                ErrorPresenter.showError(message: "There was a problem editing the user", on: self)
            }else{
                DispatchQueue.main.async { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    
    func createUser(_ name:String, _ birthdate:String){
        
        let user = User(name: name, birthdate: UserModule.service.requestDate(birthdate))
        UserModule.factory.createUser(user) { [weak self] success in
            if !success {
                ErrorPresenter.showError(message: "There was a problem saving the user", on: self)
            }else{
                DispatchQueue.main.async { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    //datepicker actions
    
    @objc func tapDone() {
            if let datePicker = self.birthdateTextField.inputView as? UIDatePicker { 
                self.birthdateTextField.text = datePicker.date.toString()
            }
            self.birthdateTextField.resignFirstResponder()
        }
    
    }
