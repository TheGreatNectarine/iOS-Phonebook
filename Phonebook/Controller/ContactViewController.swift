//
//  ContactViewController.swift
//  Phonebook
//
//  Created by Nick Marhal on 5/20/18.
//  Copyright © 2018 Nikandr Marhal. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    var number: String? {
        didSet {
            self.numberLabel.text = number
        }
    }
    @IBOutlet weak var numberLabel: UILabel!
}

class ContactViewController: UIViewController {

    var contact: Contact!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numbersTable: UITableView!

    @IBAction func deleteContact(_ sender: UIButton) {
        ContactStorage.remove(contact: self.contact)
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.numbersTable.delegate = self
        self.numbersTable.dataSource = self

        self.nameLabel.text = self.contact.name
        self.numbersTable.tableFooterView = UIView(frame: .zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ContactViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contact.phoneNumbers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "numberCell", for: indexPath) as! ContactTableViewCell
        cell.number = self.contact.phoneNumbers[indexPath.row]
        return cell
    }
}
