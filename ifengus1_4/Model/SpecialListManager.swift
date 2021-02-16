//
//  Special.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//
import Foundation

//专题列表
//数据与文章公用 ArchiveListModel
//struct SpecialListModel: Codable, Identifiable, Hashable {
//    public var id: Int
//    public var title: String
//    public var image: String
//    public var description: String
//    public var fullurl: String
//    public var channel_id: Int
//    public var likes: Int
//    public var views: Int
//    //public var comments: Int
//    public var url: String
//}

struct responseSpecialList: Codable {
    let code: Int
    let msg: String
    let time: String
    let data: [ArchiveListModel]?
}

class JSONSpecialListModel: ObservableObject {
    @Published var archiveists: [ArchiveListModel] = []
    
//    func fetchSessionData(archivesCompletionHandler: @escaping ([ArchiveModel]?, NetworeError?) -> Void) {
    func fetchSessionData(cid:Int, page: Int) {
        let url = "https://ifengus.com/api/cms/getspecialarchiveslist?apitoken=hiRNzRjQ!x2x@H@X"
        
        var json = [String:Any]()
        
        json["cid"] = cid
        json["limit"] = 10
        json["page"] = page
        json["type"] = "son"
        
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
                let archiveList = try JSONDecoder().decode(responseSpecialList.self, from: jsonData)
                if archiveList.code == 1 {
                    DispatchQueue.main.async {
                        self.archiveists += archiveList.data!
                    }
                } else {
//                    archivesCompletionHandler(nil, .unknown)
                    print("fetch data error\(archiveList.msg)")
                }
            } catch {
//                archivesCompletionHandler(nil, .requestFailed)
                print("Json data error\(error.localizedDescription)")
            }
        }).resume()
    }
}




//class ContentSpecialManager :ObservableObject  {
//
//    //建立一个集合
// var specialLists = [SpecialLists]()
//
//    func getSpecialContent(from SpecialID:Int) {
//        let url = URL(string: "https://www.ifengus.com/api/cms/getspecialarchiveslist?sid=\(SpecialID)&limit=10&page=1&apitoken=hiRNzRjQ!x2x@H@X")!
//       URLSession.shared.dataTask(with: url) {(data,response,error) in
//           do {
//            if let d = data {
//                let decodedSpecialLists = try JSONDecoder().decode(isresponseSpecialList.self, from: d)
//                if (decodedSpecialLists.code == 1){
//                    DispatchQueue.main.async {
//                        self.specialLists = decodedSpecialLists.data!
//                    }
//                } else {
//                    print("data build error")
//                }
//            } else {
//               print("No Data")
//            }
//           } catch {
//               print ("Error")
//           }
//        //print(url)
//       }
//       .resume()
//
//    }
//}
