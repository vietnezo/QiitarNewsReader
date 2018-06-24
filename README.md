## MAC環境の設定手順

### CocoaPodsをインストール

```
$ sudo gem install cocoapods
```

### Gitをインストール

下記のURLへアクセス

https://git-scm.com/downloads

dmgファイルをダウンロードし、インストールする
<br><br><br>


## QiitarNewsReaderプロジェクトの実行方法

### GitHubよりリポジトリをclone

```
$ git clone https://github.com/vietnezo/QiitarNewsReader.git
$ cd QiitarNewsReader
```

### Podのライブラリをインストール

```
$ pod install
```

### XcodeでQiitaNews.xcworkspaceを開いて、実行する
<br><br>

## QiitarNewsReaderのアプリについて

・メイン画面でMost ViewedとFavoritesの２つタブがある。

　　・Most ViewedタブでQiitarサーバーから取得した記事を表示する　

　　・Favoritesタブで気になる記事を表示する。

　　　端末に保存されたので、インターネットがないと、アプリを再起動してもその記事が見える。

・Most Viewedタブに下へスライドすると、記事一覧が更新される。

・Most Viewedタブで各記事をタップすると、記事詳細ページへ移動する。

・記事詳細ページで気になるボタンがあり。このボタンを押すと、気になる記事に追加されて、

　Favoritesタブで見える。
