//
//  ArchiveListBlock.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI

struct ArchiveListBlock: View {
    @StateObject private var imageLoader = CoverImageLoader()
    @State var archive: ArchiveListModel
    
    var body: some View {

          VStack(alignment: .leading){
              HStack(alignment: .top) {

          if imageLoader.image != nil {
              
              NavigationLink(destination: ArchiveDetailView(cid:self.$archive.id)){
                           
              Image(uiImage: imageLoader.image!)
                  .resizable()
                  .scaledToFill()
                  .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.5)
                  .cornerRadius(5)
                  .aspectRatio(contentMode: .fit)
                  .clipped()
                  .shadow(color: Color.black, radius: 10, x: 0, y: 0)
              }
              
          } else {
              RoundedRectangle(cornerRadius: 5)
                  .foregroundColor(.secondary)
                  .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.5)
                  .shadow(color: Color.black, radius: 20, x: 0, y: 0)
          }
      }
          .onAppear {
          imageLoader.load(archive.image)
       }

          VStack(alignment: .leading) {
           
              NavigationLink(destination: ArchiveDetailView(cid:self.$archive.id), label:{
                  Text("\(archive.title)")
                           })
              .font(.system(size: 20))
              
              
              HStack {
                  Spacer()
                  Image(systemName: "eye")
                      .foregroundColor(.white)
                      .imageScale(.small)
                  Text("\(archive.views)")
                      .foregroundColor(.white)
                  Image(systemName: "hand.thumbsup")
                      .foregroundColor(.white)
                      .imageScale(.small)
                  Text("\(archive.likes)")
                      .foregroundColor(.white)

              }
              Spacer()
           }
   
          .padding(.leading, 25)
          .foregroundColor(.white)
   
      }
       .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.width * 0.75)
       .background(Color(UIColor.systemGray2))
       .clipShape(RoundedRectangle(cornerRadius: 20))
       .padding(.vertical, 8)

    }
}

//struct ArchiveListBlock_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchiveListBlock()
//    }
//}
