//
//  SpecialListBlock.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI

struct SpecialListBlock: View {
    @StateObject var specialManager = SpecialManager()
      
    var body: some View {
        List(specialManager.specialModel){ special in
          HStack() {
              Image(systemName: "dot.circle.and.cursorarrow")
                  .frame(width: 24, height: 24)
                  .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
              VStack(alignment: .leading) {
                  NavigationLink(destination:SpecialListView(SpecialID: special.id)){
                      Text("\(special.title)")
                          .font(.system(size: 16))
                  }
              }
          }
      }
      .padding(20)
    }
  }

struct SpecialListBlock_Previews: PreviewProvider {
    static var previews: some View {
        SpecialListBlock()
    }
}
