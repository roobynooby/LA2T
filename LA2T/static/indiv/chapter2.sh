#!/bin/bash
# Check if chrony is installed
chrony_installed=$(rpm -q chrony)
title="2.1.1 Ensure time synchronization is in use (Automated)"
if [[ -z "$chrony_installed" ]]; then
  result="Passed"
  additional_output="chrony is not installed."
else
  chrony_version=$(rpm -q chrony --qf="%{version}")
  result="Failed"
  additional_output="chrony is installed. chrony version: $chrony_version"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



# Check if chrony is configured 
title="2.1.2 Ensure chrony is configured (Automated)"

chrony_status=$(grep -Prs -- '^\h*(server|pool)\h+[^#\n\r]+' /etc/chrony.conf /etc/chrony.d/)

if [[ -z "$chrony_status" ]]; then
  result="Failed"
    additional_output="chrony is not configured"
else
  result="Passed"
  additional_output="chrony is configured. $chrony_status "
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"







# Check if chrony is not run as the root user is configured 

title="2.1.3 Ensure chrony is not run as the root user (Automated)"
chrony_status=$( grep -Psi -- '^\h*OPTIONS=\"?\h+-u\h+root\b' /etc/sysconfig/chronyd )

if [[ -z "$chrony_status" ]]; then
  result="Passed"
  additional_output="chrony is not configured to run as the root user"
else
  result="Failed"
  additional_output="chrony is configured to run as root user. $chrony_status "
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


# Check if any autofs services are installed

title="2.2.1 Ensure autofs services are not in use (Automated)"
autofs_services=$( rpm -q autofs | grep ' installed')

if [[ -z "$autofs_services" ]]; then
   result="Passed"
  additional_output="autofs services are not installed."
else
  result="Failed"
  additional_output="autofs services are installed."
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if avahi package are installed
title="2.2.2 Ensure avahi daemon services are not in use (Automated)"
avahi_installed=$( rpm -q avahi )

if [[ -z "$ avahi_installed" ]]; then
   result="Passed"
  additional_output="avahi is not installed."
else
  avahi_version=$( rpm -q avahi --qf="%{version}")
  result="Failed"
  additional_output="avahi is installed. avahi_version: $avahi_version"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if dhcp-server is installed
title="2.2.3 Ensure dhcp server services are not in use (Automated)"
if rpm -q dhcp-server &> /dev/null; then
   
dhcp_version=$(rpm -q dhcp-server --qf="%{version}")
   result="Failed"
    additional_output="dhcp-server is installed. dhcp_version: $dhcp_version"
else
  result="Passed"
   additional_output="Package dhcp-server is not installed."
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if dns-server is installed
title="2.2.4 Ensure dns server services are not in use (Automated)"

if rpm -q bind &> /dev/null; then
dns_version=$(rpm -q rpm -q bind --qf="%{version}")
   result="Failed"
    additional_output="dns-server is installed. dns_version: $dns_version"
else
   result="Passed"
    additional_output="Package bind is not installed."
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if dnsmasq services is in use
title="2.2.5 Ensure dnsmasq services are not in use (Automated)"

# Check if dnsmasq services is in use
if rpm -q dnsmasq &> /dev/null; then
dnsmasq_version=$( rpm -q dnsmasq --qf="%{version}")
result="Failed"
    additional_output="dnsmasq-service is in use. dnsmasq_version: $dnsmasq_version"
else
      result="Passed"
    additional_output=" dnsmasq service is not in use."
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if samba file server services are in use
title="2.2.6 Ensure samba file server services are not in use (Automated)"
if rpm -q samba &> /dev/null; then
samba_version=$( rpm -q samba --qf="%{version}")
   result="Failed"
    additional_output="samba file server services are in use. samba_version: $ samba_version"
else
    result="Passed"
    additional_output="samba file server services are not in use"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if ftp server services are in use
title="2.2.7 Ensure ftp server services are not in use (Automated)"

if rpm -q vsftpd &> /dev/null; then
vsftpd_version=$( rpm -q vsftpd --qf="%{version}")
   result="Failed"
    additional_output="ftp server services are in use. vsftpd_version: $ vsftpd_version"
else
     result="Passed"
    additional_output="ftp server services services are not in use"
fi 

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if message access server services are in use
title="2.2.8 Ensure message access server services are not in use (Automated)"
if rpm -q dovecot cyrus-imapd &> /dev/null; then
message_version=$( rpm -q dovecot cyrus-imapd ="%{version}")
   result="Failed"
    additional_output="package dovecot is installed.package cyrus-imapd is installed. message_version: $ message_version"
else
    result="Passed"
additional_output="package dovecot is not installed. Package cyrus-imapd is not installed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


# Check if network file system services are in use
title="2.2.9 Ensure network file system services are not in use (Automated)"

if rpm -q nfs-utils &> /dev/null; then
  networkfilesystem_version=$(rpm -q nfs-utils --qf '%{version}')
  result="Passed"
  additional_output="Package nfs-utils is installed. Network filesystem version: $networkfilesystem_version"
else
  result="Failed"
  additional_output="Package nfs-utils is not installed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

	
# Check if nis server services are in use
title="2.2.10 Ensure nis server services are not in use (Automated)"
if rpm -q ypserv &> /dev/null; then
ypserv_version=$( rpm -q ypserv ="%{version}")
    result="Failed"
    additional_output="package ypserv is installed. ypserv_version: $ypserv_version"
else
     result="Passed"
    additional_output="package ypserv is not installed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if print server services are in use
title="2.2.11 Ensure print server services are not in use (Automated)"

cups_status=$(rpm -q cups &> /dev/null)

if [[ $cups_status = *"is not installed"* ]]; then
     result="Passed"
    additional_output="CUPS print server is not installed."
else
cups_version=$(rpm -q cups --queryformat '%{version}')  # Removed quotes around %{version}
   result="Failed"
    additional_output="CUPS print server is installed. cups_version: $cups_version"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if rpcbind services are in use
title="2.2.12 Ensure rpcbind services are not in use (Automated)"
rpbind_status=$( rpm -q rpcbind &> /dev/null)

if [[ $rpbind_status = *"is not installed"* ]]; then
    result="Passed"
    additional_output="package rpbind is not installed."
else
rpbind_version=$( rpm -q rpcbind --queryformat '%{version}')  # Removed quotes around %{version}
   result="Failed"
    additional_output="package rpbind is installed. rpbind_version: $rpbind_version"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"






# Check if rsyncdaemon services are in use
title="2.2.13 Ensure rsync services are not in use (Automated)"

# Check package installation status
rsync_status=$(rpm -q rsync-daemon &> /dev/null || echo -n "not_found")

if [[ $rsync_status = "not_found" ]]; then
   result="Passed"
  additional_output="package sync-daemon is not installed."

else
  # Package found, get version (if exists)
  rsync_version=$(rpm -q rsync-daemon --queryformat '%{version}' || echo -n "NA")
    result="Failed"
  additional_output="package rsync-daemon is installed. Version: $rsync_version"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




# Check if snmp services are in use
title="2.2.14 Ensure snmp services are not in use (Automated)"

# Check package installation status
snmp_status=$(rpm -q net-snmp &> /dev/null || echo -n "not_found")

if [[ $snmp_status = "not_found" ]]; then
  result="Passed"
  additional_output="package snmp is not installed."
else
  # Package found, get version (if exists)
  snmp_version=$(rpm -q net-snmp  --queryformat '%{version}' || echo -n "NA")
  result="Failed"
  additional_output="package snmp is installed. Version: $snmp_version"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"






# Check if telnet-server services are in use
title="2.2.15 Ensure telnet server services are not in use (Automated)"
# Check package installation status
telnet_status=$(rpm -q telnet-server &> /dev/null || echo -n "not_found")

if [[ $telnet_status = "not_found" ]]; then
  result="Passed"
  additional_output="package telnet server is not installed."
else
  # Package found, get version (if exists)
  telnet_version=$(rpm -q telnet-server --queryformat '%{version}' || echo -n "NA")
   result="Failed"
  additional_output="package telnet server is installed. Version: $telnet_version"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


# Check if tftp server services are in use
title="2.2.16 Ensure tftp server services are not in use (Automated)"
# Check package installation status
tftp_status=$(rpm -q tftp-server &> /dev/null || echo -n "not_found")

if [[ $tftp_status = "not_found" ]];then
   result="Passed"
  additional_output="package tftp-server is not installed."
else
  # Package found, get version (if exists)
  tftp_version=$(rpm -q tftp-server --queryformat '%{version}' || echo -n "NA")
   result="Failed"
  additional_output="package tftp-server is installed. Version: $tftp_version"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if web proxy server services are in use
title="2.2.17 Ensure web proxy server services are not in use (Automated)"
# Check package installation status
squid_status=$(rpm -q squid &> /dev/null || echo -n "not_found")

if [[ $squid_status = "not_found" ]]; then
  result="Passed"
  additional_output="package squid is not installed."
else
  # Package found, get version (if exists)
  squid_version=$(rpm -q squid --queryformat '%{version}' || echo -n "NA")
   result="Failed"
  additional_output="package squid is installed. Version: $squid_version"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if web server services are in use
title="2.2.18 Ensure web server services are not in use (Automated)"
# Check package installation status
httpdnginx_status=$(rpm -q httpd nginx &> /dev/null || echo -n "not_found")

if [[ $httpdnginx_status = "not_found" ]]; then
  result="Passed"
  additional_output="package httpd nginx is not installed.Package nginx is not installed."
else
  # Package found, get version (if exists)
  httpd_version=$(rpm -q httpd --queryformat '%{version}' || echo -n "NA")
  nginx_version=$(rpm -q nginx --queryformat '%{version}' || echo -n "NA")
   result="Failed"
  additional_output="package httpd is installed. Version: $httpd_version.Package nginx is installed. Version: $nginx_version"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if 2.2.19 Ensure xinetd services are in use
title="2.2.19 Ensure xinetd services are not in use (Automated)"
# Check package installation status
xinetd_status=$(rpm -q xinetd  &> /dev/null || echo -n "not_found")

if [[ $xinetd_status = "not_found" ]]; then
  result="Passed"
  additional_output="package xinetd is not installed."
else
  # Package found, get version (if exists)
  xinetd_version=$(rpm -q xinetd --queryformat '%{version}' || echo -n "NA")
   result="Failed"
  additional_output="package xinetd is installed. Version: $xinetd_version"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check package installation status
title="2.2.20 Ensure X window server services are not in use (Automated)"
xwindow_status=$(rpm -q xorg-x11-server-common &> /dev/null || echo -n "not installed ")

if [[ $xwindow_status = "not installed " ]]; then
  result="Passed"
    additional_output="package xorg-x11-server-common is not installed."
else
  # Package found, get version (if exists) and handle potential errors
  xwindow_version=$( rpm -q xorg-x11-server-common --qf="%{version}")
  result="Failed"
    additional_output="package xorg-x11-server-common is installed. Version: $xwindow_version"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



# Check if mail  transfer agents are configured for local-only mode, did not put into the excel
title="2.2.21 Ensure mail transfer agents are configured for local-only mode (Automated)"

non_loopback_addresses=$(ss -plntu |
  grep -P -- ':(25|465|587)\b' |
  grep -Pv -- '\h+(127\.0\.0\.1|\[?::1\]?):(25|465|587)\b')

if [[ -z "$non_loopback_addresses" ]]; then
  result="Passed"
  additional_output="MTA is not listening on any non-loopback address (127.0.0.1 or ::1)."
else
  result="Failed"
  additional_output="MTA is listening on non-loopback addresses:$non_loopback_addresses. Recommendations: Review MTA configuration to ensure it's set to local-only mode. Consider using firewall rules to restrict access to MTA ports."
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# # Check if only approved services are listening on a network interface (Manual) did not put into the excel
# check_plntu=$(ss -plntu)
# echo "22.2.22 Ensure only approved services are listening on a network interface (Manual)"
# #check services
# echo "Review the following services, check if they are required"
# echo "$check_plntu "


# Check if web proxy server services are in use
title="2.3.1 Ensure ftp client is not installed (Automated)"
# Check package installation status
ftp_status=$(rpm -q ftp &> /dev/null || echo -n "not_found")

if [[ $ftp_status = "not_found" ]]; then
  result="Passed"
  additional_output="package ftp is not installed."
else
  # Package found, get version (if exists)
  ftp_version=$( rpm -q ftp  --qf="%{version}")
   result="Failed"
  additional_output="package ftp is installed. Version: $ftp_version"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


# Check if web proxy server services are in use
title="2.3.2 Ensure ldap client is not installed (Automated)"
# Check package installation status
ldap_status=$(rpm -q openldap-clients &> /dev/null || echo -n "not_found")

if [[ $ldap_status = "not_found" ]]; then
  result="Passed"
    additional_output="package openldap-clients is not installed."
else
  # Package found, get version (if exists)
  ldap_version=$( rpm -q openldap-clients --qf="%{version}")
   result="Failed"
    additional_output="package openldap-clients is installed. Version: $ldap_version"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




# Check if nis client is in use
title="2.3.3 Ensure nis client is not installed (Automated)"
# Check package installation status
ypbind_status=$(rpm -q ypbind  &> /dev/null || echo -n "not_found")

if [[ $ypbind_status = "not_found" ]]; then
  result="Passed"
  additional_output="package ypbind is not installed."
else
  # Package found, get version (if exists)
  ypbind_version=$( rpm -q ypbind --qf="%{version}")
   result="Failed"
  additional_output="package ypbind-clients is installed. Version: $ypbind_version"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"





# Check if telnet client is in use
title="2.3.4 Ensure telnet client is not installed (Automated)"
# Check package installation status
telnet_status=$(rpm -q telnet &> /dev/null || echo -n "not_found")

if [[ $telnet_status = "not_found" ]]; then
  result="Passed"
  additional_output="package telnet is not installed."
else
  # Package found, get version (if exists)
  telnet_version=$( rpm -q telnet --qf="%{version}")
   result="Failed"
  additional_output="package telnet is installed. Version: $telnet_version"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


# Check if telnet client is in use
title="2.3.5 Ensure tftp client is not installed (Automated)"
# Check package installation status
tftp_status=$(rpm -q tftp &> /dev/null || echo -n "not_found")

if [[ $tftp_status = "not_found" ]]; then
  result="Passed"
  additional_output="package tftp is not installed."
else
  # Package found, get version (if exists)
  tftp_version=$( rpm -q tftp --qf="%{version}")
   result="Failed"
  additional_output="package tftp is installed. Version: $tftp_version"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"
