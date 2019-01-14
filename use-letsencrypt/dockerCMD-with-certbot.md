# [standalone] 使用 80,443 ports, 產生憑證
## Run with Docker
https://certbot.eff.org/docs/install.html#running-with-docker

## 產生憑證
```
docker run -it --rm --name certbot \
            -v "/etc/letsencrypt:/etc/letsencrypt" \
            -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
            -p 80:80 -p 443:443 \
            certbot/certbot certonly --standalone -d {DOMAIN}
```

## Renew
```
docker run -it --rm --name certbot -v "/etc/letsencrypt:/etc/letsencrypt" -p 80:80 -p 443:443 certbot/certbot renew
```


# [certonly] 使用既有服務的 80, 443 ports
## 流程
1. 啟動佔用 80,443 ports 的應用程式服務
2. 執行產生憑證
3. 更新 nginx.conf : 新增 ssl 設定
4. 執行 `nginx -s reload`

## 啟動 nginx, 並佔用 80,443 ports
1. `docker run -d -p 80:80 -p 443:443 -v $(pwd)/html:/usr/share/nginx/html nginx:1.15.5`

## 申請憑證
2. `docker run --rm -v $(pwd)/letsencrypt:/etc/letsencrypt -v $(pwd)/html:/html -it certbot/certbot certonly --agree-tos --webroot -w /html -d {DOMAIN}`

## renew
3. `docker run -it --rm -v "$(pwd)/letsencrypt:/etc/letsencrypt" -v $(pwd)/html:/html certbot/certbot --webroot -w /html renew`