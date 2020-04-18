//
//  ViewController.swift
//  DiffableDataSource
//
//  Created by Ahmed Ramzy on 4/15/20.
//  Copyright © 2020 Ahmed Ramzy. All rights reserved.
//

import UIKit

class ContactsVC: UITableViewController {
    
    private var dataSource: UITableViewDiffableDataSource<ContactType,Contact>!
    
    private var swiftCairoContacts:[Contact] = []
    private var lintSchoolContacts:[Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationDataSource()
    }
    
    private func configurationDataSource(){
        dataSource = UITableViewDiffableDataSource<ContactType,Contact>(tableView: tableView){ (tableView, indexPath, contact) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell", for: indexPath)
            cell.textLabel?.text = contact.name
            cell.detailTextLabel?.text = contact.phone
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = section == 0 ? "Lint School" : "Swift Cairo"
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    private func createSnapShot(from contacts: [Contact], to section: ContactType) {
        var snapshot =  NSDiffableDataSourceSnapshot<ContactType,Contact>()
        snapshot.appendSections([.lintSchool,.swiftCairo])
        snapshot.appendItems(lintSchoolContacts, toSection: .lintSchool)
        snapshot.appendItems(swiftCairoContacts, toSection: .swiftCairo)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popup = storyboard.instantiateViewController(withIdentifier: "AddContactVC") as! AddContactVC
        popup.delegate = self
        present(popup, animated: true, completion: nil)
    }
    
}

extension ContactsVC: AddContactDelegate {
    func setContactData(name: String, phone: String, type: ContactType) {
        if type == .lintSchool {
            lintSchoolContacts.append(Contact(name: name, phone: phone, type: type))
            createSnapShot(from: swiftCairoContacts, to: .lintSchool)
        } else {
            swiftCairoContacts.append(Contact(name: name, phone: phone, type: type))
            createSnapShot(from: swiftCairoContacts, to: .lintSchool)
        }
    }
}
