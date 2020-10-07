# DupSendBlocker

## これはなに？
メールやSMSの2重送信を防ぐgemです。バッチ処理の2重起動や、マニュアル操作ミスなどによって、ユーザに2重で同じメールが送られてしまうことを防ぐ目的で使用します。

## インストール方法
Gemfileに参照先を追加
```
gem 'dup_send_blocker', git: "https://#{auth}@git.pepabo.com/hosting/dup_send_blocker"
```

インストール
```
bundle install
```

migrationファイルのコピーと実行
```
bundle exec rake dup_send_blocker:install:migrations
bundle exec rake db:migrate
```

## 使い方
```
# labelは3つまで指定できます
# 同じlabelの組み合わせで送信しようとした場合は
# 送信がブロックされます。
labels = [
  "info",
  "2020-10-07",
  "U-1233"
]
begin
  DupSendBlocker.perform!(labels) do
    # ここに送信処理を書く
  end
rescue DupSendBlocker::BlockError
  # 同じlabelの組み合わせで送信済だった場合の処理
end
```

