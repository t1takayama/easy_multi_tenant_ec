# Easy Multi Tenant EC

マルチテナントECの簡易的実装。

## Description

システム管理者、テナント、テナントオーナー、カスタマーで構成され、ショッピングやテナントの管理機能を持つ。

## Development

起動
```
docker compose up
docker exec easy_multi_tenant_ec-app-1 bin/rails db:create db:migrate [db:seed #ダミーデータ登録]
```

URL
```
http://tenant1.localhost:3000 # tenant1
http://tenant2.localhost:3000 # tenant2
http://localhost:3000/admin # admin
http://localhost:3000/owner # owner
```

テスト
```
docker exec easy_multi_tenant_ec-app-1 bundle exec rspec spec
```
