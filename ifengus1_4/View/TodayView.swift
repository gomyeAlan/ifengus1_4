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
    
    @StateObject var topadsModel = TopAdsManager()
//    @StateObject private var imageLoaderTopAds = CoverImageLoader()
    @Environment (\.managedObjectContext) var moc
    // Fetching Data From Core Data...
    @FetchRequest(entity: Topadsinfo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Topadsinfo.title, ascending: true)] ) var results : FetchedResults<Topadsinfo>
    
    
    var body: some View {
        ScrollView {

            //setupCurrentDate(by: 0)
            VStack(alignment: .leading) {
                Text("Hot")
                    .font(.headline)
                    .padding(.leading, 15)
                    .padding(.top, 5)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        if topadsModel.topAds.isEmpty {
                            ProgressView()
                                .onAppear(perform: {
                                    topadsModel.fetchTopAdsData(context: moc)
                                })
                        } else {
                            ForEach(topadsModel.topAds){ topAd in
                                PublicTopAdsBlock(topAds:topAd) //头部广告轮播
                            }
                        }
                    }
                }
                                    
                                
                VStack(alignment: .leading) {
                    Text("New")
                        .font(.headline)
                        .padding(.leading, 15)
                        .padding(.top, 5)
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
            }.padding(16)
        }
    }
}

