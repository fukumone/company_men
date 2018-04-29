# Company Men
勤怠管理アプリケーション

## How to use

### docker版

build

```
$ docker-compose build
```

### ローカル版

サーバー起動

```
$ bundle exec foreman start
```

db作成、dbのmigrate

```
$ bundle exec rake db:create && rake db:migrate
```

testデータの挿入

```
$ bundle exec rake db:seed
```
