server {
    listen 80;
    server_name my-site.example.com;

    location / {
        return 301 https://$host$request_uri;
    }
}

server {
    listen 443 ssl;
    server_name my-site.example.com;

    ssl_certificate /etc/nginx/ssl/my-site.example.com.crt;
    ssl_certificate_key /etc/nginx/ssl/my-site.example.com.key;

    location / {
        proxy_pass http://127.0.0.1:5000; #перенаправка
        proxy_set_header Host $host; #оригинальный домен
        proxy_set_header X-Real-IP $remote_addr; #айпишка клиента
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; #маршрут айпишек proxy
        proxy_set_header X-Forwarded-Proto $scheme; #http or https
    }
}
