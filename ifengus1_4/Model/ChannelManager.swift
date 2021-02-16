//
//  ChannelManager.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//
//栏目数据管理

import Foundation

// 栏目数据字段
struct ChannelModel: Codable, Identifiable,  Hashable {
    var id: Int
    var name: String
    var url: String
    var parent_id: Int
}

// 栏目
struct responseChannel: Codable {
    let code: Int
    let msg: String
    let time: String
    let data: [ChannelModel]?
}

class ChannelManager :ObservableObject  {
    
    //建立一个集合
    @Published var channelModel = [ChannelModel]()
//    var indices: Int = 0
    
    init(){
        getChannelName(pid:0)
    }
    
    func getChannelName(pid:Int) {
        let url = URL(string: "https://ifengus.com/api/cms/getsontree?pid=0&type=channel&apitoken=hiRNzRjQ!x2x@H@X")!
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                if let d = data {
                    let decodedLists = try JSONDecoder().decode(responseChannel.self, from: d)
                    if (decodedLists.code == 1){
                        DispatchQueue.main.async {
                            self.channelModel = decodedLists.data!
                        }
                    } else {
                        print("data build error")
                    }
                }else {
                    print("No Data")
                }
            } catch {
                print ("Error")
            }
        }.resume()
   }
}
