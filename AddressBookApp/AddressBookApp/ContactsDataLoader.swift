//
//  AddressCell.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 14..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
//

import Foundation
import Contacts
import UIKit

class ContactsDataLoader {
    var contactsData =  [ContactData]()
    private static var contactsDataLoader = ContactsDataLoader()
    private init() {
        let store = MGCContactStore()
        store.checkContactsAccess({
            granted in
            // 주소록 접근 권한 허용시
            if granted {
                store.fetchContacts({
                    contacts in
                    for info in contacts {
                        let name = info.familyName + info.givenName
                        var email = ""
                        var phone = ""
                        guard var image = UIImagePNGRepresentation(UIImage(named: "profile")!) else {
                            return
                        }
                        if let thumbnailImage = info.thumbnailImageData {
                            image = thumbnailImage
                        }
                        if let phoneNumber = info.phoneNumbers.first?.value.stringValue {
                            phone = phoneNumber
                        }
                        if let emailAddress = info.emailAddresses.first?.value as String? {
                            email = emailAddress
                        }
                        self.contactsData.append(ContactData.init(image: image, name: name, phoneNumber: phone, email: email))
                    }
                    NotificationCenter.default.post(name: Notification.Name.DidUpdateAddressTable, object: self)
                })
            }
            // 접근 권한 비허용 시
            else {
                // alert Notification
                NotificationCenter.default.post(name: Notification.Name.DidAlertAccessDenied, object: self)
            }
        })
    }
    
    func makeContactsData(indexPath: IndexPath) -> ContactData {
        return contactsData[indexPath.row]
    }
    
    func countOfContacts() -> Int {
        return contactsData.count
    }

    static func sharedInstance() -> ContactsDataLoader {
        return contactsDataLoader
    }
    
}

extension Notification.Name {
    static let DidUpdateAddressTable = Notification.Name("updateAddressTable")
    static let DidAlertAccessDenied = Notification.Name("accessDenied")
}
