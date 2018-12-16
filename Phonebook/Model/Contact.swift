//
//  Contact.swift
//  Phonebook
//
//  Created by Nick Marhal on 5/15/18.
//  Copyright © 2018 Nikandr Marhal. All rights reserved.
//

import Foundation

class Contact: Codable {

    var name: String
    var phoneNumbers: [String]

    init(_ name: String, _ numbers: [String]) {
        self.name = name
        self.phoneNumbers = numbers
    }

    func add(phoneNumber: String) {
        self.phoneNumbers.append(phoneNumber)
    }

    func add(phoneNumbers: [String]) {
        for n in phoneNumbers {
            add(phoneNumber: n)
        }
    }

    func remove(phoneNumber: String) {
        if self.phoneNumbers.contains(phoneNumber) {
            self.phoneNumbers.remove(at: self.phoneNumbers.index(of: phoneNumber)!)
        }
    }

    func renameContactWith(newName: String) {
        self.name = newName
    }
}

extension Contact: CustomStringConvertible {

    public var description: String {
        return "Contact {\n\(self.name),\n\(self.phoneNumbers)\n}"
    }

}

extension Contact: Comparable {
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name < rhs.name
    }

    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name == rhs.name
    }
}
