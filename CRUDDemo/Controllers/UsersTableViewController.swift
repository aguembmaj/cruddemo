//
//  UsersTableViewController.swift
//  CRUDDemo
//
//  Created by Agustín Embuena on 4/11/21.
//


import UIKit

class UsersTableViewController: UITableViewController {
    
    // MARK: - Properties
    var users: [User] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh(nil)
    }
    
    // MARK: - IBActions
    @IBAction func refresh(_ sender: UIRefreshControl?) {
        UserModule.service.getAllUsers { [weak self] result in
            DispatchQueue.main.async {
                sender?.endRefreshing()
            }
            guard let users = result else {
                ErrorPresenter.showError(message: "There was an error getting the users", on: self)
                return
            }
            
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.users = users
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension UsersTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = UserModule.service.prettyDate(user.birthdate)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let createUserTableViewController = storyBoard.instantiateViewController(withIdentifier: "CreateUserTableViewController") as! CreateUserTableViewController
            createUserTableViewController.user = user
            self!.navigationController?.pushViewController (createUserTableViewController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let user = self.users[indexPath.row]
        UserModule.service.deleteUser(user.id) { success in
            if success && editingStyle == .delete {
                self.users.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .middle)
                tableView.endUpdates()
            }
        }
    }
    
    
    
    
}
