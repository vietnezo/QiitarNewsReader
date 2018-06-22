//
//  NewsListViewController.swift
//  News Api App
//
//  Created by VietNezo on 2018/06/20.
//  Copyright © 2018 VietNezo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var newsTableView: UITableView!

    private var newsList = [News]()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set title for page
        title = Constants.NEWS_PAGE_TITLE

        // Show loader view and get news list
        view.showLoaderView()
        getNewsList()

        // Add refresh control to news list table view
        refreshControl.addTarget(self, action: #selector(getNewsList), for: .valueChanged)
        newsTableView.backgroundView = refreshControl
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let news = newsList[indexPath.row]
        cell.textLabel?.text = news.title
        cell.detailTextLabel?.text = "by: \(news.userId!)     updated at: \(news.updatedAt.dropLast(15))"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsDetailView = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        newsDetailView.setNews(news: newsList[indexPath.row])
        self.navigationController?.pushViewController(newsDetailView, animated: true)
    }

    @objc private func getNewsList() {

        guard NetworkManager.hasConnectedToNetwork() else {
            view.showToast(message: Constants.NETWORK_ERROR)
            return
        }

        Alamofire.request(Constants.NEWS_URL).responseJSON { response in
            guard let resultValues = response.result.value else {
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }

                return
            }

            self.newsList = self.makeNewsListFromResponseData(from: resultValues)
            self.newsTableView.reloadData()

            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            } else {
                self.view.hideLoaderView()
            }
        }
    }

    private func makeNewsListFromResponseData(from: Any) -> [News] {

        var newsList = [News]()
        let newsListJson = JSON(from)

        newsListJson.forEach { (_, json) in
            let news = NewsBuilder()
                .set(newsId: json["id"].string!)
                .set(title: json["title"].string!)
                .set(userId: json["user"]["id"].string!)
                .set(content: json["rendered_body"].string!)
                .set(updatedAt: json["updated_at"].string!)
                .build()

            newsList.append(news)
        }
        
        return newsList
    }
}
