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
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor(Color.black)
    }

    var body: some View {
        TabView {
            CountriesView(homeViewModel: homeViewModel)
                .tabItem {
                    Label {
                        Text("Home")
                    } icon: {
                        Image(systemName: "house.fill")
                    }
                }
                .onAppear {
                    homeViewModel.getCountries()
                }

            SavedCountriesView(homeViewModel: homeViewModel)
                .tabItem {
                    Label {
                        Text("Saved")
                    } icon: {
                        Image(systemName: "heart.fill")
                    }
                }
        }
        .accentColor(.black)
    }
}

/// The view which shows country list

struct CountriesView: View {
    @ObservedObject var homeViewModel: HomeViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(homeViewModel.countryList, id: \.id) { country in
                        NavigationLink(destination: CountryDetailView(countryModel: country, homeViewModel: homeViewModel)) {
                            CountryBarView(country: country, homeViewModel: homeViewModel)
                        }
                    }
                }
            }
            .navigationTitle("Countries")
        }
    }
}

/// The view for saved countries tab

struct SavedCountriesView: View {
    @ObservedObject var homeViewModel: HomeViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(homeViewModel.countryList, id: \.id) { country in
                        if country.isFaved {
                            NavigationLink(destination: CountryDetailView(countryModel: country, homeViewModel: homeViewModel)) {
                                CountryBarView(country: country, homeViewModel: homeViewModel)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("Saved Countries")
    }
}

/// The view which represents country bar

struct CountryBarView: View {
    var country: CountryModel
    @ObservedObject var homeViewModel: HomeViewModel

    func getIndex() -> Int {
        let index = homeViewModel.countryList.firstIndex(where: { $0.id == country.id })!
        return index
    }

    var body: some View {
        HStack {
            Text(country.name)
                .foregroundColor(.white).font(.system(.title))
            Spacer()
            Button(action: {
                let countryIndex = getIndex()
                homeViewModel.countryList[countryIndex].isFaved = !homeViewModel.countryList[countryIndex].isFaved

            }) {
                Image(systemName: "star.fill")
                    .foregroundColor(homeViewModel.countryList[getIndex()].isFaved ? .black : .gray)
                    .scaledToFit()
            }
        }
        .padding()

        .background(Color.teal)
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
