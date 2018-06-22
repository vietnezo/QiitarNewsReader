//
//  News.swift
//  News Api App
//
//  Created by VietNezo on 2018/06/22.
//  Copyright © 2018 VietNezo. All rights reserved.
//

import Foundation

public struct News {
    var id: Int64?
    var newsId: String!
    var title: String!
    var userId: String!
    var content: String!
    var updatedAt: String!
}

public class NewsBuilder {

    private var news: News

    init() {
        self.news = News()
    }

    public func set(newsId: String) -> NewsBuilder {
        self.news.newsId = newsId
        return self
    }

    public func set(title: String) -> NewsBuilder {
        self.news.title = title
        return self
    }

    public func set(userId: String) -> NewsBuilder {
        self.news.userId = userId
        return self
    }

    public func set(content: String) -> NewsBuilder {
        self.news.content = content
        return self
    }

    public func set(updatedAt: String) -> NewsBuilder {
        self.news.updatedAt = updatedAt
        return self
    }

    public func build() -> News {
        return self.news
    }
}
