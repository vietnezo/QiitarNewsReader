//
//  DataAccessObject.swift
//  News Api App
//
//  Created by VietNezo on 2018/06/22.
//  Copyright © 2018 VietNezo. All rights reserved.
//

import Foundation
import SQLite

class DataAccessObject {

    static let sharedInstance = DataAccessObject()

    public let dbConnection: Connection!

    private init() {
        var path = "QiitaNews.sqlite3"

        if let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            path = dir.appending("/QiitaNews.sqlite3")
        }

        do {
            dbConnection = try Connection(path)
        } catch _ {
            dbConnection = nil
        }
    }

    public func createTables() {
        try? NewsDAO.sharedInstance.createTable()
    }
}
