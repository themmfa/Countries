//
//  CountryDetailData.swift
//  Countries
//
//  Created by Fatih Erdoğan on 7.10.2022.
//

import Foundation

struct CDetail: Decodable {
    let data: CountryDetail
}

// MARK: - DataClass

struct CountryDetail: Decodable {
    let code: String
    let flagImageUri: String
    let name: String
    let wikiDataId: String
}
