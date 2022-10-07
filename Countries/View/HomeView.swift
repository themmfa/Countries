//
//  HomeView.swift
//  Countries
//
//  Created by Fatih Erdoğan on 7.10.2022.
//

import SwiftUI

struct HomeView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.gray
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }

    var body: some View {
        TabView {
            CountriesView()
                .tabItem {
                    Label {
                        Text("Home")
                    } icon: {
                        Image(systemName: "house.fill")
                    }
                }
            SavedCountriesView()
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

struct SavedCountriesView: View {
    var body: some View {
        VStack {}
    }
}

struct CountriesView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(homeViewModel.countryList, id: \.id) { country in
                        NavigationLink(destination: CountryDetailView(countryModel: country)) {
                            CountryBarView(country: country)
                        }
                    }
                }
            }
            .navigationTitle("Countries")
        }
        .onAppear {
            homeViewModel.getCountries()
        }
    }
}

struct CountryBarView: View {
    @State var country: CountryModel

    var body: some View {
        HStack {
            Text(country.name)
                .foregroundColor(.white)
            Spacer()
            Button(action: {
                country.isFaved = !country.isFaved
            }) {
                Image(systemName: "star.fill")
                    .foregroundColor(country.isFaved ? .black : .white)
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
