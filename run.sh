cat <<EOF > /etc/xray/config.json
{
	"inbounds":[{
		"port":$PORT,
		"listen":"0.0.0.0",
		"protocol":"vless",
		"settings":{
			"clients":[{
				"id":"$UUID"
			}],
			"decryption":"none"
		},
			"streamSettings": {
			"network": "tcp",
			"httpSettings": {
				"path": "$WSPATH"
			},
			"tcpSettings": {
				"header": {
					"type": "http",
					"response": {
						"version": "1.1",
						"status": "200",
						"reason": "OK",
						"headers": {
							"Content-Type": ["application/octet-stream", "application/x-msdownload", "text/html", "application/x-shockwave-flash"],
							"Transfer-Encoding": ["chunked"],
							"Connection": ["keep-alive"],
							"Pragma": "no-cache"
						}
					}
				}
			}
		}
	}],
	"outbounds":[{
		"protocol":"freedom"
	}]
}
EOF
/usr/bin/xray run --config=/etc/xray/config.json
