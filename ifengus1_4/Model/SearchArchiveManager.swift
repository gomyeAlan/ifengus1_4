//
//  SearchArchiveManager.swift
//  ifengus1_4
//
//  Created by Winda Wei on 2/16/21.
//

// 搜索详细内容数据管理

import Foundation

struct SearchArchiveModel: Codable, Identifiable,  Hashable {
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
}

struct responseSearch: Codable {
    let code: Int
    let msg: String
    let time: String
    let data: SearchArchiveModel
}


class SearchArchiveManager: ObservableObject{
    @Published var isSearch = false
    
}

//fetch single archive
 func fetchSearchData(key: String, searchCompletionHandler: @escaping (SearchArchiveModel?, Error?) -> Void) {
    let url = "\(String(infoForKey("BASEURL")!))api/cms/searchlist?search=\(key)&apitoken=\(String(infoForKey("APITOKEN")!))"
    var json = [String:Any]()
    
    json["search"] = key
    
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
            let searchs = try JSONDecoder().decode(responseSearch.self, from: jsonData)
            if searchs.code == 1 {
                DispatchQueue.main.async {
//                        self.archive = archive.data
                    searchCompletionHandler(searchs.data, nil)
                }
            } else {
//                    archivesCompletionHandler(nil, .unknown)
                print("fetch data error\(searchs.msg)")
            }
        } catch {
//                archivesCompletionHandler(nil, .requestFailed)
            print("Json data error\(error.localizedDescription)")
        }
    }).resume()
}
