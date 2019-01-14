# ex1 : certbot 獨立 container
> 將 nginx 與 certbot 分別為不同的 container

- 此為一次性產生憑證與 nginx 關係
- 兩者可為不同 container, 但 nginx 需要 reload 才能使用新憑證, 故可參考 ex2 將 nginx 與 certbot 合在一起的 container

# ex2 : 在 nginx 中裝 certbot
> 使用 certbot-auto-process.sh

1. 啟動 docker-compose
    - 設定 domain & email
2. 產生憑證 : `certbot certonly --no-eff-email -m $EMAIL --agree-tos --webroot -w $PUBLIC_PATH -d $DOMAIN`
    - 檢查憑證到期日
    - 若要求自動化 ... 可在每次 container 啟動的 entrypoint 時執行, 並同時設定 crontab
    - 執行更新 nginx 的 ssl : `sh update-nginx-ssl.sh`
3. 設定 crontab : 
    - `0 */12 * * * certbot renew --cert-name $DOMAIN --deploy-hook "sh /usr/local/src/update-nginx-ssl.sh"`
        - 一天執行兩次的檢查
        - 若設定長時間的 renew, 當系統崩潰重啟時, cron 的日期也會重新計算
    - 確定執行 cron 在背景 : `service cron status`

# 查看憑證日期
`openssl x509 -noout -dates -in {your-crt or your-pem}`



