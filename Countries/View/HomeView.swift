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
        }
    }
}

struct CountriesView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(homeViewModel.countryList, id: \.id) { country in
                        NavigationLink(destination: CountryDetailView(countryDetailViewModel: CountryDetailViewModel(code: country.code))) {
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
