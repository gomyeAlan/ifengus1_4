//
//  ContentView.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI

struct AppMainView: View {
    @State var isAccountViewPresented = false
    @State var text: String = ""
    var body: some View {

        NavigationView{
            VStack {
            PublicSearchBar(text: $text)
            TabView {
                TodayView()
                    .tabItem {
                        Image(systemName: "note")
                        Text("New")
                    }
                MenuView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Menu")

                    }
                 
            }
        }.navigationViewStyle(StackNavigationViewStyle())
         .navigationBarItems(trailing: PublicAccountButton(isAccountViewPresented: $isAccountViewPresented))
      }
    }
    }
