//
//  PublicTopAdsBlock.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI
import CoreData

struct PublicTopAdsBlock: View {
    @StateObject var topadsModel = TopAdsManager()
//    @StateObject private var imageLoaderTopAds = CoverImageLoader()
    @Environment (\.managedObjectContext) var moc
    // Fetching Data From Core Data...
    @FetchRequest(entity: Topadsinfo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Topadsinfo.title, ascending: true)] ) var results : FetchedResults<Topadsinfo>
    var body: some View {
        TabView {
            VStack{
                if results.isEmpty {
                    if topadsModel.topAds.isEmpty {
                        ProgressView()
                            .onAppear(perform: {
                                topadsModel.fetchTopAdsData(context: moc)
                            })
                    } else {
                        List(topadsModel.topAds) { topAd in
                            Text("\(topAd.title)")
                            Text("\(topAd.image)")
                        }
                    }
                } else {
                    List(results) { topAd in
                        Text("\(topAd.title!)")
                        Text("\(topAd.image!)")
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width-32, height: 300)
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .padding(.bottom, 24)
    }
}


//ForEach(topadsModel.topAds){ topAd in
//    VStack {
//        Divider()
//        VStack(alignment: .leading) {
//            if imageLoaderTopAds.image != nil {
//                Image(uiImage: imageLoaderTopAds.image!)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: UIScreen.main.bounds.width-32, height: UIScreen.main.bounds.width * 0.5)
//                    .aspectRatio(contentMode: .fit)
//                    .cornerRadius(5)
//                    .clipped()
//            } else {
//                RoundedRectangle(cornerRadius: 12, style: .continuous)
//                    .foregroundColor(.secondary)
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.5)
//            }
//            Text("UPDATE")
//                .bold()
//                .foregroundColor(.blue)
//                .font(.footnote)
//            Text(topAd.title)
//                .font(.title3)
//            Text("Description")
//                .foregroundColor(.secondary)
//        }
//        .frame(maxWidth: .infinity, alignment: .leading)
//    }
//    .onAppear {
//        imageLoaderTopAds.load(topAd.image)
//    }
//}.padding(.horizontal)
