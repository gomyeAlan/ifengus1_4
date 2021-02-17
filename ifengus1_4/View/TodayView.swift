//
//  TodayView.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI

struct TodayView: View {
    @StateObject var  jam = JSONArchivesModel()
    @State private var archivepage: Int = 1
    
    var body: some View {
        ScrollView {
            //setupCurrentDate(by: 0)
            
            VStack {
                VStack {
                    PublicTopAdsBlock() //头部广告轮播
                    if jam.archiveists.isEmpty {
                        ProgressView()
                            .onAppear(perform: {
                                jam.fetchSessionData(cid: 2, page: self.archivepage)
                            })
                    } else {
                        //列表
                        ForEach(jam.archiveists, id: \.self){ archive in
                            ArchiveListBlock(archive: archive)
                                .onAppear{
                                    if self.jam.archiveists.isLastArchive(archive) {
                                        self.archivepage += 1
                                        jam.fetchSessionData(cid: 2, page: self.archivepage)
                                    }
                                }
                                //display fetched JSON data...
                        }
                    }
                }
            }
            
        }.onAppear{
            print("scrollview======")
        }
        .navigationBarTitle("Today")
    }
}

