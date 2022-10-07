//
//  CountriesApp.swift
//  Countries
//
//  Created by Fatih Erdoğan on 7.10.2022.
//

import SwiftUI

@main
struct CountriesApp: App {
    @StateObject var homeViewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(homeViewModel)
        }
    }
}
