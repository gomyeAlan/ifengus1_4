//
//  ArchiveView.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI

struct ArchiveDetailView: View {
    @Binding var cid: Int
    @State var arm: ArchiveModel?
    var body: some View {
        if arm != nil {
            VStack
            {
                Text("\(self.arm!.title)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                HStack{
                    Spacer()
                    Image(systemName: "eye")
                    Text("260")
                    Spacer()
                    Image(systemName: "message.circle")
                    Text("20")
                    Spacer()
                    Image(systemName: "hand.thumbsup")
                    Text("60")
                    Spacer()
                }
                .font(.system(size: 8))
                .foregroundColor(.gray)
                .frame(width: 200, height: 25, alignment: .leading)
                
                HStack{
                    Text("\(self.arm!.content)")
                }
                Spacer()
                VStack{
                    Text("Other ArchivesList")
                }
                Spacer()
            }
        } else {
            ProgressView()
                .onAppear{
                    fetchArchiveData(cid: self.cid, archivesCompletionHandler: { archivemodel, Error in
                        DispatchQueue.main.async {
                            self.arm = archivemodel
                        }
                    })
                }
        }
    }
}

//struct ArchiveView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchiveDetailView()
//    }
//}
