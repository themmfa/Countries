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
    }
}

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
        }.navigationTitle("Saved Countries")
    }
}

struct CountryBarView: View {
    @State var country: CountryModel
    @ObservedObject var homeViewModel: HomeViewModel
    @State var countryIndex: Int = 0

    var body: some View {
        HStack {
            Text(country.name)
                .foregroundColor(.white)
            Spacer()
            Button(action: {
                if let index = homeViewModel.countryList.firstIndex(where: { $0.id == country.id }) {
                    homeViewModel.countryList[index].isFaved = !homeViewModel.countryList[index].isFaved
                    countryIndex = index
                }
            }) {
                Image(systemName: "star.fill")
                    .foregroundColor(homeViewModel.countryList[countryIndex].isFaved ? .black : .white)
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
