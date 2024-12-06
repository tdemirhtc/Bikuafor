//
//  ContentView.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
// UserDefaults.standard.string(forKey: "LoginToken") == nil || UserDefaults.standard.string(forKey: "LoginToken") == ""

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @State private var isLoggedIn: Bool = UserDefaults.standard.string(forKey: "LoginToken") != nil && UserDefaults.standard.string(forKey: "LoginToken") != ""
    var body: some View {
        NavigationView {
            if isLoggedIn  {
                SalonListView(isLoggedIn: $isLoggedIn)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}


   

    






