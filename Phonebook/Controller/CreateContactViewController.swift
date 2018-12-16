//
//  CreateContactViewController.swift
//  Phonebook
//
//  Created by Nick Marhal on 5/19/18.
//  Copyright © 2018 Nikandr Marhal. All rights reserved.
//

import UIKit

class CreateContactViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField1: UITextField!
    @IBOutlet weak var phoneNumberTextField2: UITextField!
    @IBOutlet weak var phoneNumberTextField3: UITextField!

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let name = nameTextField.text!
        let numbers = getActualNumbers([phoneNumberTextField1.text!, phoneNumberTextField2.text!, phoneNumberTextField3.text!])
        if name.count > 0 && atLeastOneFilledIn(numbers) {
            ContactStorage.add(contact: Contact(name, numbers))
            self.navigationController?.popViewController(animated: true)
        } else {
            showAlert(withTitle: "Error", message: "Not enough data provided to create contact.")
        }
    }

    private func getActualNumbers(_ rawNumbers: [String]) -> [String] {
        return rawNumbers.filter { Int($0) != nil }
    }

    private func atLeastOneFilledIn(_ sequence: [String]) -> Bool {
        var filledCounter = 0
        for el in sequence {
            if el.count != 0 {
                filledCounter += 1
            }
        }
        return filledCounter > 0
    }

    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
