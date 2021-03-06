//
//  NewsDetailViewController.swift
//  News Api App
//
//  Created by VietNezo on 2018/06/20.
//  Copyright © 2018 VietNezo. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!

    private var news: News!
    private var isSavedNews: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setRightBarButton()

        setNewsDetail()
    }

    public func setNews(news: News) {
        self.news = news
    }

    public func setIsSavedNews(isSavedNews: Bool) {
        self.isSavedNews = isSavedNews
    }

    private func setNewsDetail() {
        titleTextView?.text = news.title

        let padding: CGFloat = 30;
        let screenWidth = UIScreen.main.bounds.width - padding;
        let newsContentWithStyle: String = (news.content + "<style>img{width:\(screenWidth)px}</style>")
        contentTextView?.attributedText = newsContentWithStyle.htmlToAttributedString
    }

    private func setRightBarButton() {
        if isSavedNews {
            return
        }

        let rightButtonItem = UIBarButtonItem(
            title: Constants.FAVORITES_BUTTON_TEXT,
            style: .plain,
            target: self,
            action: #selector(saveFavoriteNews(sender:))
        )

        navigationItem.rightBarButtonItem = rightButtonItem
    }

    @objc func saveFavoriteNews(sender: UIBarButtonItem) {
        var hasError: Bool = false

        hasError = NewsDAO.sharedInstance.insert(item: self.news)
        view.showToast(message: Constants.ADDED_TO_FAVORITES)

        guard hasError else {
            return
        }

        NotificationCenter.default.post(name: Constants.NOTIFICATION_UPDATE_FAVORITES_VIEW, object: nil)
    }
}

