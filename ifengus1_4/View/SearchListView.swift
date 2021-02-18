//
//  SearchListView.swift
//  ifengus1_4
//
//  Created by Winda Wei on 2/16/21.
//

import SwiftUI
import SDWebImageSwiftUI //下载网络图片第三方组建，安装路径：https://github.com/SDWebImage/SDWebImageSwiftUI.git

struct SearchListView: View {

//    @StateObject var searcharchive : SearchArchiveManager
    
    var body: some View {

          VStack(alignment: .leading){
              HStack(alignment: .top) {

//                WebImage(url: URL(string: archive.image)) // 加载网络图片
//                    .placeholder{ Color.gray }
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.5)
//                    .clipped()
//                    .shadow(color: Color.black, radius: 10, x: 0, y: 0)
                
              }

          VStack(alignment: .leading) {
           
//              NavigationLink(destination: ArchiveDetailView(cid:self.$archive.id), label:{
//                  Text("\(archive.title)")
//                           })
//              .font(.system(size: 20))
              
              
              HStack {
                  Spacer()
                  Image(systemName: "eye")
                      .foregroundColor(.white)
                      .imageScale(.small)
//                  Text("\(archive.views)")
//                      .foregroundColor(.white)
//                  Image(systemName: "hand.thumbsup")
//                      .foregroundColor(.white)
//                      .imageScale(.small)
//                  Text("\(archive.likes)")
//                      .foregroundColor(.white)

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
