//
//  HomeViewModel.swift
//  Countries
//
//  Created by Fatih Erdoğan on 7.10.2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var countryList: [Countries] = []

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
                        let decodedData = try JSONDecoder().decode(CountryData.self, from: safeData)
                        DispatchQueue.main.async {
                            self?.countryList = decodedData.data
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
