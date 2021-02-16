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
        VStack {
            

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
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }

            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarItems(trailing: PublicAccountButton(isAccountViewPresented: $isAccountViewPresented))
            }
        }
        }
      
      }
    }

struct AppMainView_Previews: PreviewProvider {
    static var previews: some View {
        AppMainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
