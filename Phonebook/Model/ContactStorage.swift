//
//  ContactStorage.swift
//  Phonebook
//
//  Created by Nick Marhal on 5/16/18.
//  Copyright © 2018 Nikandr Marhal. All rights reserved.
//

import Foundation

class ContactStorage {

    static var contacts: [Contact] = [Contact("Kendrick", ["0994473728", "0932284756"]),
        Contact("Yanny", ["0982236567", "0957654376"]),
        Contact("Laurel", ["0503875967", "0734450098", "0508353845"]),
        Contact("Louis", ["0668849295", "0987748243", "0734856900"]),
        Contact("Kanye", ["0994569078"]),
        Contact("Virgil", ["0950718344", "0989945067"])]

    static var count: Int {
        get {
            return ContactStorage.contacts.count
        }
    }

    static func add(contact: Contact) {
        if let ind = getIndex(of: contact) {
            ContactStorage.contacts[ind].add(phoneNumbers: contact.phoneNumbers)
        } else {
            ContactStorage.contacts.append(contact)
        }
    }

    static func getIndex(of contact: Contact) -> Int? {
        for i in 0..<ContactStorage.contacts.count {
            if ContactStorage.contacts[i] == contact {
                return i
            }
        }
        return nil
    }

    static func remove(at indexPath: IndexPath) {
        ContactStorage.contacts.remove(at: indexPath.row)
    }

    static func remove(at indexPath: Int) {
        ContactStorage.contacts.remove(at: indexPath)
    }

    static func remove(contact: Contact) {
        if let ind = getIndex(of: contact) {
            ContactStorage.remove(at: ind)
        }
    }

    static func contact(at indexPath: IndexPath) -> Contact {
        return ContactStorage.contacts[indexPath.row]
    }

    static func contact(at index: Int) -> Contact {
        return ContactStorage.contacts[index]
    }
}
