//
//  ArchiveManager.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

// 文章内容数据管理

import Foundation

struct ArchiveModel: Codable, Identifiable,  Hashable {
    var id: Int
    var user_id: Int
    var channel_id: Int
    var model_id: Int
    var special_id: Int
    var title: String
    var style: String
    var flag: String
    var image: String
    var keywords: String
    var description: String
    var tags: String
    var weigh: Int
    var views: Int
    var comments: Int
    var likes: Int
    var dislikes: Int
    var diyname: String
    var createtime: Date
//    var updatetime: Date
    var publishtime: Date
//    var deletetime: Date
    var memo: String
    var status: String
    var content: String
    var author: String
//    var price: Double
    var channel: ChannelModel
}


struct responseArchive: Codable {
    let code: Int
    let msg: String
    let time: String
    let data: ArchiveModel
}

//class JSONArchiveModel: ObservableObject {
    
    //fetch single archive
     func fetchArchiveData(cid: Int, archivesCompletionHandler: @escaping (ArchiveModel?, Error?) -> Void) {
        let url = "https://ifengus.com/api/cms/getArchive?apitoken=hiRNzRjQ!x2x@H@X"
        var json = [String:Any]()
        
        json["aid"] = cid
        
        let postdata = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = postdata
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, res, error in
            guard let jsonData = data else {return}
            
            // checking for any internal api error...
            let response = res as! HTTPURLResponse
            // checking by status code...
            
            if response.statusCode == 404{
                print("error API Error")
            }
            
            //fetching JSON Data....
            do {
                let archives = try JSONDecoder().decode(responseArchive.self, from: jsonData)
                if archives.code == 1 {
                    DispatchQueue.main.async {
//                        self.archive = archive.data
                        archivesCompletionHandler(archives.data, nil)
                    }
                } else {
    //                    archivesCompletionHandler(nil, .unknown)
                    print("fetch data error\(archives.msg)")
                }
            } catch {
    //                archivesCompletionHandler(nil, .requestFailed)
                print("Json data error\(error.localizedDescription)")
            }
        }).resume()
    }
//}
