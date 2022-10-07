//
//  DataController.swift
//  Countries
//
//  Created by Fatih Erdoğan on 7.10.2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CountryDatabase")

    init() {
        container.loadPersistentStores(completionHandler: { _, error in

            if let error = error {
                print("CoreData failed to load: \(error.localizedDescription)")
            }

        })
    }
}
