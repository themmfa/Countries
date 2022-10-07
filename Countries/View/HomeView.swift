//
//  HomeView.swift
//  Countries
//
//  Created by Fatih Erdoğan on 7.10.2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel()

    init() {
        UITabBar.appearance().backgroundColor = UIColor.gray
    }

    var body: some View {
        TabView {
            CountriesView(countries: homeViewModel.countryList, onAppear: homeViewModel.getCountries)
                .tabItem {
                    Label {
                        Text("Home")
                    } icon: {
                        Image(systemName: "house.fill")
                    }
                }

            VStack {
                ForEach(homeViewModel.countryList, id: \.id) { country in
                    CountryBarView(country: country)
                }
            }
            .tabItem {
                Label {
                    Text("Saved")
                        .foregroundColor(.white)
                } icon: {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct CountriesView: View {
    var countries: [Countries]
    var onAppear: () -> Void
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(countries, id: \.id) { country in
                        NavigationLink(destination: Text(country.name)) {
                            CountryBarView(country: country)
                        }
                    }
                }
            }
            .navigationTitle("Countries")
        }
        .onAppear {
            onAppear()
        }
    }
}

struct CountryBarView: View {
    var country: Countries

    var body: some View {
        HStack {
            Text(country.name)
                .foregroundColor(.white)
            Spacer()
            Button(action: {}) {
                Image(systemName: "star.fill")
                    .foregroundColor(.white)
                    .scaledToFit()
            }
        }
        .padding()

        .background(.gray)
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.black, lineWidth: 2)
        }
        .padding(.horizontal, 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
