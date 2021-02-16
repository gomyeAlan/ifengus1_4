//
//  PublicTopAdsBlock.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI

struct PublicTopAdsBlock: View {
    @Environment (\.managedObjectContext) var moc
    // Fetching Data From Core Data...
    @FetchRequest(entity: Topadsinfo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Topadsinfo.title, ascending: true)] ) var results : FetchedResults<Topadsinfo>
    

  var body: some View {
    TabView {
        if results.isEmpty {
            Text("Data")
        } else {
            Text("Has Data")
        }
        Button("click me clean data"){
            
        }
    }
    .frame(width: UIScreen.main.bounds.width-32, height: 300)
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    .padding(.bottom, 24)
  }

}

struct PublicTopAdsBlock_Previews: PreviewProvider {
    static var previews: some View {
        PublicTopAdsBlock()
    }
}
