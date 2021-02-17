//
//  TopAdsManager.swift
//  ifengus1_4
//
//  Created by Winda Wei on 2/16/21.
//

import SwiftUI
import CoreData

//建立一个广告集合

struct TopAds: Codable, Identifiable, Hashable{
    var id: Int
    var title: String
    var image: String
    var url: String
}

struct responsTopadsData: Codable {
    let code: Int
    let msg: String
    let time: String
    let data: [TopAds]?
}
  

class TopAdsManager: ObservableObject {
    @Published var topAds : [TopAds] = []
    
    // saving jSON to Core Data...
    func saveData(context: NSManagedObjectContext){
        topAds.forEach{ (data) in
            let entity = Topadsinfo(context: context)
            entity.id = Int16(data.id)
            entity.title = data.title
            entity.image = data.image
            entity.url = data.url
//            print(data.image)
        }
        
        // saving all pending data at once...
        do{
            try context.save()
            print("success")
        }
        catch{
            print(error.localizedDescription)
        }
    }

    //Fetch Json 数据
    func fetchTopAdsData(context: NSManagedObjectContext){
        let url = "https://ifengus.com/api/cms/getblocklist?apitoken=hiRNzRjQ!x2x@H@X"
        let request = URLRequest(url: URL(string: url)!)
//        request.addValue("swiftui2.0", forHTTPHeaderField: "field")
//        let session = URLSession(configuration: .default)
        URLSession.shared.dataTask(with: request) { (data, res, _) in
            guard let jsonData = data else{return}
            
            // checking for any internal api error..
            let response = res as! HTTPURLResponse
            
            // checking by status code...
            if response.statusCode == 404 {
                print("error API Error")
                return
            }
            
            // fetching JSON Data...
            do {
                let archives = try JSONDecoder().decode(responsTopadsData.self, from: jsonData)
                if archives.code == 1 {
                    DispatchQueue.main.async {
                    self.topAds = archives.data!
                    self.saveData(context: context)
                    }
                }else {
                    print("fetch data error\(archives.msg)")
                }
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
        .resume()
        
    }
}

