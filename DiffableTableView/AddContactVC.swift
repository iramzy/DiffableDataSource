//
//  AddContactVC.swift
//  DiffableDataSource
//
//  Created by Ahmed Ramzy on 4/15/20.
//  Copyright © 2020 Ahmed Ramzy. All rights reserved.
//

import UIKit

protocol AddContactDelegate {
    func setContactData(name: String, phone: String, type: ContactType)
}

class AddContactVC: UIViewController {
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var phoneTextField: UITextField!
    
    @IBOutlet var typeSegmantControl: UISegmentedControl!
    
    private var selectedType:ContactType?
    var delegate: AddContactDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
    }
    
    @IBAction func contactType(_ sender: UISegmentedControl) {
        switch typeSegmantControl.selectedSegmentIndex {
        case 0:
            selectedType = .lintSchool
        case 1:
            selectedType = .swiftCairo
        default:
            break
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        guard let name = nameTextField.text else {return}
        guard let phone = phoneTextField.text else {return}
        let type = selectedType ?? ContactType.lintSchool
        delegate?.setContactData(name: name, phone: phone, type: type)
        dismiss(animated: true, completion: nil)
    }
}
