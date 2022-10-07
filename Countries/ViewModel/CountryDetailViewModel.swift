//
//  CountryDetailViewModel.swift
//  Countries
//
//  Created by Fatih Erdoğan on 7.10.2022.
//

import Foundation

class CountryDetailViewModel: ObservableObject {
    @Published var countryDetail: CountryDetailModel?
    var code: String

    init(code: String) {
        self.code = code
    }

    func getCountryDetail() {
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

                        DispatchQueue.main.async {
                            self?.countryDetail = CountryDetailModel(code: decodedData.data.code, flagImageUri: decodedData.data.flagImageUri, name: decodedData.data.name, wikiDataId: decodedData.data.wikiDataId)
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
