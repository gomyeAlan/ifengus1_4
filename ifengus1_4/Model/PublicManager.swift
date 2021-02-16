//
//  PublicImagesManager.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import Foundation
import UIKit

//网路图片加载
class CoverImageLoader: ObservableObject {
    @Published var image: UIImage? = nil

    func load(_ imgName: String) {
        URLSession.shared.dataTask(with: URL(string: imgName)!) { data, _, _ in
            if let d = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: d) ?? UIImage(named: "")
                }
            }
        }
        .resume()
    }
    
}


//获取Config文件中的常量
func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: "")
 }
