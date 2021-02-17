//
//  PublicImagesManager.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import Foundation

//获取Config文件中的常量
func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: "")
 }
