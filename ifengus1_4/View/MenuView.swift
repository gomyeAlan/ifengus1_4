//
//  MenuView.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI

struct MenuView: View {
    @State var index = 0
    @Namespace var name
    
    var body: some View {
        VStack{
            HStack(spacing: 0){
                Button(action: {
                    withAnimation(.spring()){
                        index = 0
                    }
                }) {
                    VStack{
                        Text("栏目分类")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 0 ? .black : .gray)
                        ZStack{
                            // slide animation....
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame( height: 4)
                            if index == 0{
                                Capsule()
                                    .fill(Color(.gray))//"Color"
                                    .frame( height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
                Button(action: {
                    withAnimation(.spring()){
                        index = 1
                    }
                }) {
                    VStack{
                        Text("热点专题")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 1 ? .black : .gray)
                        ZStack{
                            // slide animation....
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame( height: 4)
                            if index == 1{
                                Capsule()
                                    .fill(Color(.gray))//"Color"
                                    .frame( height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                              }
                          }
                      }
                  }
              }
            // Changing Views Based On Index...
            if index == 0 {
                ChanneListlBlock()
            } else {
                SpecialListBlock()
            }
            Spacer()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
