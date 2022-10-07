//
//  CountryModel.swift
//  Countries
//
//  Created by Fatih Erdoğan on 7.10.2022.
//

import Foundation

// MARK: - Country Data

struct CountryData: Codable {
    let data: [Countries]
}

// MARK: - Countries

struct Countries: Codable {
    let id = UUID()
    let code: String
    let currencyCodes: [String]
    let name, wikiDataID: String

    enum CodingKeys: String, CodingKey {
        case code, currencyCodes, name
        case wikiDataID = "wikiDataId"
    }
}
