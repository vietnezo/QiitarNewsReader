//
//  NewsDAO.swift
//  News Api App
//
//  Created by VietNezo on 2018/06/22.
//  Copyright © 2018 VietNezo. All rights reserved.
//

import Foundation
import SQLite

class NewsDAO {

    static let sharedInstance = NewsDAO()

    private let dbConnection: Connection!
    private let table     = Table("news")
    private let id        = Expression<Int64>("id")
    private let newsId    = Expression<String>("news_id")
    private let userId    = Expression<String>("user_id")
    private let title     = Expression<String>("title")
    private let content   = Expression<String>("content")

    typealias T = News

    private init() {
        dbConnection = DataAccessObject.sharedInstance.dbConnection
    }

    public func createTable() throws {
        guard dbConnection != nil else {
            return
        }

        try dbConnection.run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(newsId)
            t.column(userId)
            t.column(title)
            t.column(content)
        })
    }

    public func insert(item: T) -> Bool {
        guard dbConnection != nil else {
            return false
        }

        let insert = table.insert(newsId <- item.newsId, userId <- item.userId, title <- item.title, content <- item.content)
        if let rowId = try? dbConnection.run(insert) {
            return rowId > 0 ? true : false
        }
        return false
    }

    public func delete(item: T) -> Bool {
        guard dbConnection != nil else {
            return false
        }

        let query = table.filter(id == item.id!)
        if let tmp = try? dbConnection.run(query.delete()) {
            return tmp > 0 ? true : false
        }
        return false
    }

    public func getAll() -> [T] {
        var results = [T]()
        guard dbConnection != nil else {
            return results
        }

        let items = try! dbConnection.prepare(table.order(id.desc))
        for item in items {
            results.append(
                News(id: item[id], newsId: item[newsId], title: item[title], userId: item[userId], content: item[content])
            )
        }

        return results
    }
}

