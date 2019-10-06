# HiraganaConverter
漢字をひらがなに変換するアプリです。  
gooさんが公開しているひらがな化APIを利用しています。

![HiraganaConverter](https://user-images.githubusercontent.com/39119676/66266720-bce45e00-e863-11e9-9706-3edfbe52d3a3.jpg)


# 環境
 - macOS Mojave 10.14.5
 - Xcode 10.2.1 (10E1001)
 - Swift 5
 - iOS 12.0

# Liblary
バージョンに関しては [Podfile.lock](https://github.com/renchild8/HiraganaConverter/blob/master/Podfile.lock)をご確認ください。

 - [RxSwift](https://github.com/ReactiveX/RxSwift)
 - [RxCocoa](https://github.com/ReactiveX/RxSwift/tree/master/RxCocoa)
 - [Moya/RxSwift](https://github.com/Moya/Moya)
 - [SwiftLint](https://github.com/realm/SwiftLint)
 

 
# API
 - [goo ひらがな化API](https://labs.goo.ne.jp/api/jp/hiragana-translation/)  
[app_id](https://github.com/renchild8/HiraganaConverter/blob/bde38d36636fe441b040b9857a451a7c1ed354a6/HiraganaConverter/Model/Target.swift#L36)
は適宜取得し、変更してください。取得方法は[こちら](https://labs.goo.ne.jp/apiusage/)
