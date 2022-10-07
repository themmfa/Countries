//
//  HomeViewModel.swift
//  Countries
//
//  Created by Fatih Erdoğan on 7.10.2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var countryList: [CountryModel] = []

    func getCountryDetail(_ code: String) {
        let headers = [
            "X-RapidAPI-Key": apiKey,
            "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
        ]

        var request = URLRequest(url: URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/\(code)")!,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)

        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, _, error in

            if error != nil {
                print(error)
            } else {
                do {
                    if let safeData = data {
                        print(safeData.base64EncodedString())
                        let decodedData = try JSONDecoder().decode(CDetail.self, from: safeData)
                        print(decodedData)

                        for index in self!.countryList.indices {
                            if self!.countryList[index].code.contains(code) {
                                DispatchQueue.main.async {
                                    print(decodedData.data.flagImageUri)
                                    self!.countryList[index].flagImageUri = decodedData.data.flagImageUri
                                }
                            }
                        }
                    }
                } catch {
                    print(error)
                }
            }

        })
        dataTask.resume()
    }

    func getCountries() {
        let headers = [
            "X-RapidAPI-Key": apiKey,
            "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
        ]

        var request = URLRequest(url: URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10")!,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)

        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, _, error in

            if error != nil {
                print(error)
            } else {
                do {
                    if let safeData = data {
                        let decodedData = try JSONDecoder().decode(CountryListData.self, from: safeData)
                        for country in decodedData.data {
                            let countryDetail = CountryModel(code: country.code, flagImageUri: nil, name: country.name, wikiDataId: country.wikiDataID)
                            DispatchQueue.main.async {
                                self?.countryList.append(countryDetail)
                            }
                        }
                    }
                } catch {
                    print(error)
                }
            }

        })
        dataTask.resume()
    }
}
