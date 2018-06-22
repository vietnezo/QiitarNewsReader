import Foundation

struct Constants {
    static let NEWS_URL = "https://qiita.com/api/v2/items"

    static let NEWS_PAGE_TITLE = "記事一覧"
    static let FAVORITES_PAGE_TITLE = "気になる記事"
    static let FAVORITES_BUTTON_TEXT = "気になる"
    static let ADDED_TO_FAVORITES = "気になる記事に\n追加しました"
    static let NETWORK_ERROR = "通信エラーが発生しました"

    static let NOTIFICATION_UPDATE_FAVORITES_VIEW = Notification.Name("NOTIFICATION_UPDATE_FAVORITES_VIEW")
}
