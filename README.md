# HiraganaConverter
漢字をひらがなに変換するアプリです。  
gooさんが公開しているひらがな化APIを利用しています。

![HiraganaConverter](https://user-images.githubusercontent.com/39119676/66271718-60516500-e89c-11e9-92ee-cd04afb9bb8a.jpeg)

# 環境
 - macOS Mojave 10.14.5
 - Xcode 10.2.1 (10E1001)
 - Swift 5
 - iOS 12.0

# Library
バージョンに関しては [Podfile.lock](https://github.com/renchild8/HiraganaConverter/blob/master/Podfile.lock)をご確認ください。

 - [RxSwift](https://github.com/ReactiveX/RxSwift)
 - [RxCocoa](https://github.com/ReactiveX/RxSwift/tree/master/RxCocoa)
 - [Moya/RxSwift](https://github.com/Moya/Moya)
 - [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD)
 - [SwiftLint](https://github.com/realm/SwiftLint)
 
# API
 - [goo ひらがな化API](https://labs.goo.ne.jp/api/jp/hiragana-translation/)  
[app_id](https://github.com/renchild8/HiraganaConverter/blob/f3558d2898cb3066529b78538b83b289048537bb/HiraganaConverter/Model/Const.swift#L4)
は適宜取得し、変更してください。取得方法は[こちら](https://labs.goo.ne.jp/apiusage/)
