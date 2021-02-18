//
//  UserCenterView.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI
import SDWebImageSwiftUI //下载网络图片第三方组建


struct UserCenterView: View {
        // @Binding var selected:Int
     @ObservedObject var loginmanager: UserLoginManager = UserLoginManager()

    
     @State var username = ""
     @State var password = ""
     @State var returnmsg = ""
     @Environment(\.managedObjectContext) private var usercontainer
     
     // Fetching Data.....
     @FetchRequest(
         sortDescriptors: [NSSortDescriptor(keyPath: \Userinfo.username, ascending: true)],
         animation: .default)
     private var userlist: FetchedResults<Userinfo>
     
    
    var body: some View {
        VStack{
            //已经登录-------
            if !userlist.isEmpty {
                if !isexprise(expiretime: (userlist.first?.expiretime)!) {
                    Form {
                        Section {
                            NavigationLink(
                                destination: UserCenterView(),
                                label: {
                                    HStack {
                                        WebImage(url: URL(string: String(infoForKey("BASEURL")!) + "\(userlist.first!.avatar!)")) // 加载网络图片
                                            .placeholder{ Color.gray }
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                            .clipped()
                                            .font(.system(size: 25))
                                        VStack (alignment: .leading, spacing: 5) {
                                            Text("\(userlist.first!.username!)")
                                                .font(.system(size: 25))
                                        }
                                    }
                                })
                        }
                    }
                    Button(action: {
                        self.cleanUser()
                    }, label: {
                        Text("安全退出").frame(width: 300, height: 22, alignment: .center)
                            .padding().background(Color.blue).foregroundColor(.white)
                            .cornerRadius(15)
                    })
//                    Text("logindate:\(userlist.first!.logindate!)")
//                    Text("token:\(userlist.first!.token!)")
//                    Text("exprietime:\(userlist.first!.expiretime!)")
//                    Text("username:\(userlist.first!.username!)")
//                    Text("avatar:\(userlist.first!.avatar!)")
                } else {
                    Button("您登录已超时，请重新登录") {
                        self.cleanUser()
                    }
                }
                
                //已经登录 完成-------
            } else {
                Form {
                    Section {
                        NavigationLink(
                            destination: UserCenterView(),
                            label: {
                                HStack {
                                    Image(systemName: "person.crop.circle.fill")
                                        .font(.system(size: 50))
                                        .padding(.horizontal, 5)
                                    VStack (alignment: .leading, spacing: 5) {
                                        Text("您还没有登录")
                                            .font(.system(size: 25))
                                    }
                                }
                            })
                    }
                    Section {
                        HStack{
                            Image(systemName: "person").foregroundColor(.gray).padding()
                            TextField("请输入用户名，长度为 3-10", text: $username).keyboardType(.namePhonePad)
                        }.foregroundColor(.gray)
                        HStack{
                            Image(systemName: "lock").foregroundColor(.gray).padding()
                            SecureField("请输入密码，长度为 6-12", text: $password).keyboardType(.namePhonePad)
                        }.foregroundColor(.gray)
                    }
                }
                   
//                        Button("Login") {
//                            self.loginVaild(username: username, password: password)
//                        }
                Button(action: {
                    self.loginVaild(username: username, password: password)
                }, label: {
                    Text("登录").frame(width: 300, height: 22, alignment: .center)
                        .padding().background(Color.blue).foregroundColor(.white)
                        .cornerRadius(15)
                })
                .disabled(username.isEmpty || password.isEmpty)
                Spacer()
                Text(self.returnmsg)
                    .disabled(self.returnmsg.isEmpty)
            }
        }
//        Button("Test function") {
//            print(isexprise(expiretime: (userlist.first?.expiretime)!))
//            self.cleanUser()
//            print("test function")
//            print(String(infoForKey("BASEURL")!) + infoForKey("UserLoginUrl")!)
//        }
    }
    
    
    
    //登录认证函数
    func loginVaild(username: String, password: String) {
//        let urlStr = String(infoForKey("BASEURL")!) + infoForKey("UserLoginUrl")! + "?account=\(username.trimmingCharacters(in: .whitespaces))&password=\(password.trimmingCharacters(in: .whitespaces))"
//        let request = URLRequest(url: URL(string: urlStr)!)
        let url = String(infoForKey("BASEURL")!) + infoForKey("UserLoginUrl")! + "?apitoken=\(infoForKey("APITOKEN")!)"
        var json = [String:Any]()

        json["account"] = username.trimmingCharacters(in: .whitespaces)
        json["password"] = password.trimmingCharacters(in: .whitespaces)

        let postdata = try! JSONSerialization.data(withJSONObject: json, options: [])

        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = postdata
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // checking for any internal api error...
            let response = response as! HTTPURLResponse
            // checking by status code...
            
            if response.statusCode == 404{
                print("error API Error")
            }
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
            guard let data = data else {
                fatalError("Error: parse data error")
            }
            do {
                let  deresponse = try JSONDecoder().decode(responseUserLogin.self, from: data)
                DispatchQueue.main.async {
                    self.returnmsg = deresponse.msg
                    if deresponse.code == 1 {
                        let user = Userinfo(context: self.usercontainer)
                        user.username = deresponse.data!.username
                        user.islogin = true
                        user.logindate = Date()
                        user.expiretime = deresponse.data!.expiretime
                        user.token = deresponse.data!.token
                        user.avatar = deresponse.data!.avatar
                        do {
                            try self.usercontainer.save()
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                }
                print(deresponse.msg)
                debugPrint(deresponse.code)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    //清空Core Data Userinfo数据
    func cleanUser(){
        for user in self.userlist {
            self.usercontainer.delete(user)
        }
        do {
            try self.usercontainer.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func isexprise(expiretime: Date) -> Bool {
        if expiretime.compare(Date()) == .orderedAscending {
            return true
        } else {
            return false
        }
    }
}

