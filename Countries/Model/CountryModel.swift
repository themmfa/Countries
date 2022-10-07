//
//  CountryDetailModel.swift
//  Countries
//
//  Created by Fatih Erdoğan on 7.10.2022.
//

import Foundation

struct CountryModel {
    let id = UUID()
    let code: String
    var flagImageUri: String?
    let name: String
    let wikiDataId: String
    var isFaved: Bool = false
}
