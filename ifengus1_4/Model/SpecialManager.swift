//
//  SpecialManager.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

// 专题数据管理

import Foundation

// 专题
struct SpecialModel: Codable, Identifiable, Hashable {
    var id: Int
    var title: String
    var image: String
    var banner: String
    var status: String
    var diyname: String?
    var description: String?
    var intro: String?
}

// 专题

struct responseSpecial: Codable {
    let code: Int
    let msg: String
    let time: String
    let data: [SpecialModel]?
}

class SpecialManager: ObservableObject  {
    
    //建立一个集合
    @Published var specialModel = [SpecialModel]()

//    var indices: Int = 0
    
    init(){
        getSpecialslName(pid:0)
    }
    
    func getSpecialslName(pid:Int) {
        let url = URL(string: "https://ifengus.com/api/cms/getspeciallist?apitoken=hiRNzRjQ!x2x@H@X")!
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                if let d = data {
                    let specialList = try JSONDecoder().decode(responseSpecial.self, from: d)
                    if (specialList.code == 1){
                        DispatchQueue.main.async {
                            self.specialModel = specialList.data!
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

