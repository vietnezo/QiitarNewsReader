//
//  FavoritesViewController.swift
//  News Api App
//
//  Created by VietNezo on 2018/06/20.
//  Copyright © 2018 VietNezo. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favoritesTableView: UITableView!

    private var favoritesList = [News]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set title for page
        title = Constants.FAVORITES_PAGE_TITLE

        // Get favorite news list
        getFavoritesList()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(getFavoritesList),
            name: Constants.NOTIFICATION_UPDATE_FAVORITES_VIEW,
            object: nil
        )
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let news = favoritesList[indexPath.row]
        cell.textLabel?.text = news.title
        cell.detailTextLabel?.text = news.userId

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsDetailView = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        newsDetailView.setNews(news: favoritesList[indexPath.row])
        newsDetailView.setIsSavedNews(isSavedNews: true)
        self.navigationController?.pushViewController(newsDetailView, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            _ = NewsDAO.sharedInstance.delete(item: favoritesList[indexPath.row])
            favoritesList.remove(at: indexPath.row)
            favoritesTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    @objc private func getFavoritesList() {
        favoritesList = NewsDAO.sharedInstance.getAll()
        favoritesTableView.reloadData()
    }

}

