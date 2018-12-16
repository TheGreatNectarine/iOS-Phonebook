//
//  PhonebooTableViewController.swift
//  Phonebook
//
//  Created by Nick Marhal on 5/16/18.
//  Copyright © 2018 Nikandr Marhal. All rights reserved.
//

import UIKit

class PhonebookTableViewCell: UITableViewCell {
    var contact: Contact? {
        didSet {
            self.contactNameLabel.text = contact?.name
        }
    }
    @IBOutlet weak var contactNameLabel: UILabel!
}

class PhonebookTableViewController: UITableViewController {

    var resultsController = UITableViewController()
    var searchController = UISearchController(searchResultsController: nil)
    var filteredContacts: [Contact]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: .zero)

        prepareSearchProps()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return self.filteredContacts.count
        } else {
            return ContactStorage.contacts.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! PhonebookTableViewCell
        if isFiltering() {
            cell.contact = self.filteredContacts[indexPath.row]
        } else {
            cell.contact = ContactStorage.contacts[indexPath.row]
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return !isFiltering()
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            ContactStorage.remove(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            tableView.reloadData()
        }
        return [deleteAction]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contactDetails" {
            let destination = segue.destination as! ContactViewController
            destination.contact = isFiltering()
                ? self.filteredContacts[tableView.indexPathForSelectedRow!.row]
                : ContactStorage.contact(at: tableView.indexPathForSelectedRow!)
        }
    }
}

extension PhonebookTableViewController: UISearchResultsUpdating {

    func prepareSearchProps() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Contacts"
        navigationItem.searchController = self.searchController
        definesPresentationContext = true

        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
    }

    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    func numbersContainSubstringOf(_ part: String, source: [String]) -> Bool {
        for el in source {
            if el.contains(part) {
                return true
            }
        }
        return false
    }

    func updateSearchResults(for searchController: UISearchController) {
        self.filteredContacts = ContactStorage.contacts.filter { (contact: Contact) -> Bool in
            guard let text = self.searchController.searchBar.text?.lowercased() else { return false }
            return contact.name.lowercased().contains(text) || numbersContainSubstringOf(text, source: contact.phoneNumbers)
        }
        self.tableView.reloadData()
    }
}
