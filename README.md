# Company Men
勤怠管理アプリケーション

## How to use

### docker版

サーバー起動

```
$ docker-compose -f docker-compose.development.yml up
# open http://localhost
```

build

```
$ docker-compose -f docker-compose.development.yml build
```

db create

```
$ docker-compose -f docker-compose.development.yml run --rm web bundle exec rake db:create
```

db migrate

```
$ docker-compose -f docker-compose.development.yml run --rm web bundle exec rake db:migrate
```

testデータの挿入

```
$ docker-compose -f docker-compose.development.yml run --rm web bundle exec rake db:seed
```

# 本番運用

```
$ docker-compose -f docker-compose.production.yml up -d
```

### ローカル版

サーバー起動

```
$ SLACK_HOOK_URL=xxxxx bundle exec foreman start
```

db作成、dbのmigrate

```
$ bundle exec rake db:create && rake db:migrate
```

testデータの挿入

```
$ bundle exec rake db:seed
```
