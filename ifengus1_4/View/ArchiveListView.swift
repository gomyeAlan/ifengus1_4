//
//  ArchiveListView.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI

struct ArchiveListView: View {

    @StateObject var  jamArchive = JSONArchivesModel()
    @State private var archivepage: Int = 1
    
    var channelID: Int
    
    var body: some View {
        ScrollView {
            VStack {

                if jamArchive.archiveists.isEmpty {
                            ProgressView()
                                    .onAppear(perform: {
                                        jamArchive.fetchSessionData(cid: self.channelID, page: self.archivepage)
                                    })
                            } else {
                                ForEach(jamArchive.archiveists, id: \.self){ archive in
                                    ArchiveListBlock(archive: archive)
                                        .onAppear{
                                            if self.jamArchive.archiveists.isLastArchive(archive) {
                                                self.archivepage += 1
                                                jamArchive.fetchSessionData(cid: self.channelID, page: self.archivepage)
                                            }
                                        }
                                    //display fetched JSON data...
                                    }
                                }
                }
                }
    }
}

//struct ArchiveListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchiveListView()
//    }
//}
