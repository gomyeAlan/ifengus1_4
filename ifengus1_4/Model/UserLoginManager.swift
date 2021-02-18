//
//  UserLoginManager.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI

//用户数据
struct UserData:Codable {
    let id: Int
    let username: String
    let nickname: String
    let mobile: String
    let avatar: String
    let score: Int
    let token: String
    let user_id: Int
    let createtime: Int
    let expiretime: Date
    let expires_in: Int
}

struct responseUserLogin: Codable {
    let code: Int
    let msg: String
    let time: String
    let data: UserData?
}

class UserLoginManager: ObservableObject {
    @Published var userInput: String = "" {
        didSet {
            //8位以上输入限制
            if userInput.trimmingCharacters(in: .whitespaces).count > 8 {
                self.userInput = oldValue
            }
        }
    }
    
    @Published var message: String = "message"
    init() {
        
    }
}
