//
//  ContactListViewController.swift
//  VIPERDemo
//
//  Created by Macmini on 10/6/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import UIKit

class ContactListViewController: BaseViewController {
    
    // MARK: - IBOutlet's
    @IBOutlet weak var contactListTableView : UITableView!
    
    // MARK: - ContactListViewProtocol Property Requirements
    
    /// Reference to ContactList presenter to list out all the contacts
    var presenter: ContactListPresenterProtocol?
    
    // MARK: - UIViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        contactListTableView.dataSource = self
        contactListTableView.delegate = self
        presenter?.showContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lookupForUpdates()
    }
    
    override var isViewObstructed : Bool {
        if isViewPopupObstructed == true || isViewNavigationObstructed == true {
            return true
        }
        return false
    }
    
    // MARK: - Instance Methods
    
    /// It talks to presenter for any update on the presented data
    func lookupForUpdates() {
        if isViewObstructed == false {
            presenter?.proceedWitMOCUpdates()
        }
    }
    
    // MARK: - IBAction Methods
    /// Display "Add Contact" module
    @IBAction func createNewContact() {
        // Here we assume that new context come to create a contact
        isViewNavigationObstructed = true
        presenter?.createNewContact()
    }
    
}

extension ContactListViewController : ContactListViewProtocol {
    func insertContacts(atIndexes indexs: [Int]) {
        print("insert contacts at given set of indexes")
        var indexPaths = [IndexPath]()
        for index in indexs {
            let indexPath = IndexPath(row: index, section: 0)
            indexPaths.append(indexPath)
        }
        contactListTableView.insertRows(at: indexPaths, with: .left)
    }
    
    func updateContacts(atIndexes indexs: [Int]) {
        print("update contacts at given set of indexes")
    }
    
    func deleteContacts(atIndexes indexs: [Int]) {
        print("delete contacts from given set of indexes")
    }
    
    func readData() {
        contactListTableView.reloadData()
        print("data is ready to be listed")
    }
    
    func updatesReceived() {
        print("refresh list for the MOC event")
        lookupForUpdates()
    }
}

extension ContactListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfContacts = presenter?.numberOfContacts() ?? 0
        return numberOfContacts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "contact-cell")
        let contactName = presenter?.nameOfContact(atIndex: indexPath.row)
        let contactPhone = presenter?.phoneOfContact(atIndex: indexPath.row)
        cell.textLabel?.text = contactName
        cell.detailTextLabel?.text = contactPhone
        return cell
    }
}

extension ContactListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.updateContact(atIndex: indexPath.row)
    }
}
