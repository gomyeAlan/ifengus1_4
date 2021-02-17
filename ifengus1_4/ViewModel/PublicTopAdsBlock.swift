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
    @State var topAds : TopAds

    
    var body: some View {



                        //NavigationLink(destination: ArchiveDetailView(cid: $topAd.id)) {
                        NavigationLink(destination: AppMainView()) {
                                HStack(alignment: .top) {
                                    VStack(alignment: .leading) {
                                WebImage(url: URL(string: topAds.image)) // 加载网络图片
                                    .placeholder{ Color.gray }
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.width * 0.5)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                 Text(topAds.title)
                                    .font(.title3)
                                
                                }
                                
                            }
                            .frame(width: UIScreen.main.bounds.width, height: 300)
                        }

    }
}
