#!/bin/sh
# Put "username\npassword\n" in /etc/openvpn/login first

sudo sed -i 's:auth-user-pass:auth-user-pass /etc/openvpn/login:g' /etc/openvpn/*.conf
