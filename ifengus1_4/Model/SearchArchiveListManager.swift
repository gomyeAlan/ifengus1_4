//
//  SearchArchiveListManager.swift
//  ifengus1_4
//
//  Created by Winda Wei on 2/16/21.
//
// 搜索列表数据管理

import Foundation

struct SearchArchiveListModel: Codable, Identifiable,  Hashable {
    var id: Int
    var title: String
    var image: String
    var description: String
    var channel_id: Int
    var dislikes: Int
    var likes: Int
    var tags: String
    var createtime: Date
    var views: Int
    var url: String
    var fullurl: String
    var likeratio: Int
    var create_date: String
}

//无限加载扩展
extension RandomAccessCollection where Self.Element: Identifiable {
    public func isLastSearch<SearchArchiveModel: Identifiable>(_ search: SearchArchiveModel) -> Bool {
            guard !isEmpty else {
                return false
            }
            
            guard let searchIndex = lastIndex(where: { AnyHashable($0.id) == AnyHashable(search.id) }) else {
                return false
            }
            
            let distance = self.distance(from: searchIndex, to: endIndex)
            return distance == 1
        }
}
