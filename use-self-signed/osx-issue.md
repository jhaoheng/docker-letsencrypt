# `Error Loading extension section v3_ca`

- `sudo vi /etc/ssl/openssl.cnf`
- 在最下方新增

```
[ v3_ca ]
basicConstraints = critical,CA:TRUE
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer:always
```

- 重新執行