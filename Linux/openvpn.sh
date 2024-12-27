#
# OpenVPN Login Template Script
# Date: 12/27/2024

# Connect VPN
tmux new-session -s vpn \; send-keys "sudo openvpn --config /home/userName/openvpn/vpn_profile_name.ovpn --auth-user-pass /home/userName/openvpn/login_credentials.txt" C-m
