//
//  SpecialListView.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI

struct SpecialListView: View {
    
    var SpecialID: Int
    @StateObject var  jamSpecial = JSONSpecialListModel()
    @State private var archivepage: Int = 1
    
        var body: some View {
            ScrollView {
                VStack {

                    if jamSpecial.archiveists.isEmpty {
                                ProgressView()
                                        .onAppear(perform: {
                                            jamSpecial.fetchSessionData(cid: self.SpecialID, page: self.archivepage)
                                        })
                                } else {
                                    ForEach(jamSpecial.archiveists, id: \.self){ archive in
                                        ArchiveListBlock(archive: archive)
                                            .onAppear{
                                                if self.jamSpecial.archiveists.isLastArchive(archive) {
                                                    self.archivepage += 1
                                                    jamSpecial.fetchSessionData(cid: self.SpecialID, page: self.archivepage)
                                                }
                                            }
                                        //display fetched JSON data...
                                        }
                                }
                        }
                }
        }
}

//struct SpecialListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpecialListView()
//    }
//}
