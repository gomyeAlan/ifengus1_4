//
//  ChanneListlBlock.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI

struct ChanneListlBlock: View {
  @ObservedObject var channelmanager = ChannelManager()
    
  var body: some View {

    List(channelmanager.channelModel) {channel in
            Divider()
     
            HStack {
                Image(systemName: "dot.circle.and.cursorarrow")
                    .frame(width: 24, height: 24)
                    .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                VStack(alignment: .leading) {
                    NavigationLink(destination:ArchiveListView( channelID: channel.id )){
                        Text("\(channel.name)")
                            .font(.system(size: 16))
                    }

                }
                // 目录ID循环结束
            }
        }
        .padding(20)
  }
}


struct ChanneListlBlock_Previews: PreviewProvider {
    static var previews: some View {
        ChanneListlBlock()
    }
}
