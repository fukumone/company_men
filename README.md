# Company Men
勤怠管理アプリケーション

## How to use

### docker版

build

```
$ docker-compose build
```

db create

```
$ docker-compose run web rake db:create
```

db migrate

```
$ docker-compose run web rake db:migrate
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
