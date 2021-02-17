//
//  PublicTopAdsBlock.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI
import CoreData
import SDWebImageSwiftUI //下载网络图片第三方组建


struct PublicTopAdsBlock: View {
    @StateObject var topadsModel = TopAdsManager()
//    @StateObject private var imageLoaderTopAds = CoverImageLoader()
    @Environment (\.managedObjectContext) var moc
    // Fetching Data From Core Data...
    @FetchRequest(entity: Topadsinfo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Topadsinfo.title, ascending: true)] ) var results : FetchedResults<Topadsinfo>
    var body: some View {
        TabView {
        
                if results.isEmpty {
                    if topadsModel.topAds.isEmpty {
                        ProgressView()
                            .onAppear(perform: {
                                topadsModel.fetchTopAdsData(context: moc)
                            })
                    } else {
                        ForEach(topadsModel.topAds){ topAd in
                  
                            VStack(alignment: .leading) {
                                
                                WebImage(url: URL(string: topAd.image)) // 加载网络图片
                                    .placeholder{ Color.gray }
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.width * 0.5)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 20))

                                Text(topAd.title)
                                    .font(.title3)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }else {
                    ForEach(results) { topAd in
                        
                        VStack(alignment: .leading) {
                            
                            WebImage(url: URL(string: topAd.image!)) // 加载网络图片
                                .placeholder{ Color.gray }
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.width * 0.5)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 20))

//                            Text("UPDATE")
//                                .bold()
//                                .foregroundColor(.blue)
//                                .font(.footnote)
                            Text(topAd.title!)
//                                .font(.title3)
//                            Text("Description")
//                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                }
                }
            
        .frame(width: UIScreen.main.bounds.width - 32, height: 300)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .padding(.bottom, 24)
    }
}
