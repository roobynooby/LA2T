#!/bin/bash
# 5.1.1.1 Ensure rsyslog is installed
title="5.1.1.1 Ensure rsyslog is installed"
if rpm -q rsyslog; then
    additional_output="rsyslog is installed"
    result="Passed"
else
    additional_output="rsyslog is not installed"
    result="Failed"
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


# 5.1.1.2 Ensure rsyslog service is enabled
title="5.1.1.2 Ensure rsyslog service is enabled"
if systemctl is-enabled rsyslog | grep -q 'enabled'; then
    additional_output="rsyslog service is enabled"
    result="Passed"
else
    additional_output="rsyslog service is not enabled"
    result="Failed"
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

# 5.1.1.3 Ensure journald is configured to send logs to rsyslog
title="5.1.1.3 Ensure journald is configured to send logs to rsyslog"
l_output=""
l_output2=""
a_parlist=("ForwardToSyslog=yes")
l_systemd_config_file="/etc/systemd/journald.conf"

# Function to check config file parameters
config_file_parameter_chk() {
    unset A_out
    declare -A A_out

    # Check config file(s) setting
    while read -r l_out; do
        if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
                l_file="${l_out//# /}"
            else
                l_systemd_parameter="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
                [ "${l_systemd_parameter^^}" = "${l_systemd_parameter_name^^}" ] && A_out+=(["$l_systemd_parameter"]="$l_file")
            fi
        fi
    done < <(/usr/bin/systemd-analyze cat-config "$l_systemd_config_file" | grep -Pio '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')

    if (( ${#A_out[@]} > 0 )); then
        # Assess output from files and generate output
        while IFS="=" read -r l_systemd_file_parameter_name l_systemd_file_parameter_value; do
            l_systemd_file_parameter_name="${l_systemd_file_parameter_name// /}"
            l_systemd_file_parameter_value="${l_systemd_file_parameter_value// /}"

            if [ "${l_systemd_file_parameter_value^^}" = "${l_systemd_parameter_value^^}" ]; then
                l_output="$l_output\n - \"$l_systemd_parameter_name\" is correctly set to \"$l_systemd_file_parameter_value\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
                l_output2="$l_output2\n - \"$l_systemd_parameter_name\" is incorrectly set to \"$l_systemd_file_parameter_value\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_systemd_parameter_value\"\n"
            fi
        done < <(grep -Pio -- "^\h*$l_systemd_parameter_name\h*=\h*\H+" "${A_out[@]}")
    else
        l_output2="$l_output2\n - \"$l_systemd_parameter_name\" is not set in an included file\n ** Note: \"$l_systemd_parameter_name\" May be set in a file that's ignored by load procedure **\n"
    fi
}

while IFS="=" read -r l_systemd_parameter_name l_systemd_parameter_value; do
    # Assess and check parameters
    l_systemd_parameter_name="${l_systemd_parameter_name// /}"
    l_systemd_parameter_value="${l_systemd_parameter_value// /}"
    config_file_parameter_chk
done < <(printf '%s\n' "${a_parlist[@]}")

if [ -z "$l_output2" ]; then
    additional_output="Journaled is configured to send logs to rsyslog"
    result="Passed"
else
    additional_output="Journaled is not configured to send logs to rsyslog"
    result="Failed"
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


# 5.1.1.4 Ensure rsyslog default file permissions are configured
title="5.1.1.4 Ensure rsyslog default file permissions are configured"
if grep -Ps '^\h*\$FileCreateMode\h+0[0,2,4,6][0,2,4]0\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf | grep -q "$FileCreateMode 0640"; then
    additional_output="rsyslog default file permissions are configured"
    result="Passed"
else
    additional_output="rsyslog default file permissions are not configured"
    result="Failed"
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

# 5.1.1.5 Ensure logging is configured
title="5.1.1.5 Ensure logging is configured"

# Check if logging is configured in /etc/rsyslog.conf and /etc/rsyslog.d/*.conf
if grep -qE '^\s*\*.\*' /etc/rsyslog.conf /etc/rsyslog.d/*.conf; then
    logging_configured=true
else
    logging_configured=false
fi

# Verify log files in /var/log/

# Check if log files exist in /var/log/
if [ "$(ls -A /var/log/)" ]; then
    log_files_exist=true
else
    log_files_exist=false
fi

# Display PASS or FAIL based on the checks
if [ "$logging_configured" = true ] && [ "$log_files_exist" = true ]; then
    additional_output="Logging files is properly configured"
    result="Passed"
else
    additional_output="Logging files is not configured"
    result="Failed"
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

# 5.1.1.6 Ensure rsyslog is configured to send logs to a remote log host
title="5.1.1.6 Ensure rsyslog is configured to send logs to a remote log host"
if grep -E '^\s*([^#]+\s+)?action\(([^#]+\s+)?\btarget=\"?[^#"]+\"?\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf | grep -q 'action(type="omfwd" target="loghost.example.com" port="514" protocol="tcp"'; then
    additional_output="rsyslog is configured to send logs to a remote log host"
    result="Passed"
else
    additional_output="rsyslog is not configured to send logs to a remote log host"
    result="Failed"
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
# 5.1.1.7 Ensure rsyslog is not configured to receive logs from a remote client
title="5.1.1.7 Ensure rsyslog is not configured to receive logs from a remote client"
if grep -Ps -- '^\h*module\(load="imtcp"\)' /etc/rsyslog.conf /etc/rsyslog.d/*.conf | grep -q '^\h*input\(type="imtcp" port="514"\)'; then
    additional_output="rsyslog is configured to receive logs from a remote client"
    result="Passed"
else
    additional_output="rsyslog is not configured to receive logs from a remote client"
    result="Failed"
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
# 5.1.2.1.1 Ensure systemd-journal-remote is installed
title="5.1.2.1.1 Ensure systemd-journal-remote is installed"
if rpm -q systemd-journal-remote; then
    additional_output="systemd-journal-remote is installed"
    result="Passed"
else
    additional_output="systemd-journal-remote is not installed"
    result="Failed"
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

# 5.1.2.1.2 Ensure systemd-journal-remote is configured
title="5.1.2.1.2 Ensure systemd-journal-remote is configured"
if grep -P "^ *URL=|^ *ServerKeyFile=|^ *ServerCertificateFile=|^ *TrustedCertificateFile=" /etc/systemd/journal-upload.conf | grep -qE '=.*'; then
    systemd_journal_remote_configured=true
else
    systemd_journal_remote_configured=false
fi

# Display PASS or FAIL based on the checks
if [ "$systemd_journal_remote_configured" = true ]; then
    additional_output="systemd-journal-remote is properly configured"
    result="Passed"
else
    additional_output="systemd-journal-remote is not configured"
    result="Failed"
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

# 5.1.2.1.3 Ensure systemd-journal-remote is enabled
title="5.1.2.1.3 Ensure systemd-journal-remote is enabled"
if systemctl is-enabled systemd-journal-upload.service | grep -q 'enabled'; then
    additional_output="systemd-journal-remote is enabled"
    result="Passed"
else
    additional_output="systemd-journal-remote is not enabled"
    result="Failed"
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


# 5.1.2.1.4 Ensure journald is not configured to receive logs from a remote client
title="5.1.2.1.4 Ensure journald is not configured to receive logs from a remote client"
if systemctl is-enabled systemd-journal-remote.socket | grep -q 'masked'; then
    additional_output="journald is not configured to receive logs from a remote client"
    result="Passed"
else
    additional_output="journald is configured to receive logs from a remote client"
    result="Failed"
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


# 5.1.2.2 Ensure journald service is enabled
title="5.1.2.2 Ensure journald service is enabled"
if systemctl is-enabled systemd-journald.service | grep -q 'static'; then
    additional_output="journald service is enabled"
    result="Passed"
else
    additional_output="journald service is not enabled"
    result="Failed"
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


# 5.1.2.3 Ensure journald is configured to compress large log files
title="5.1.2.3 Ensure journald is configured to compress large log files"
if grep ^\s*Compress /etc/systemd/journald.conf | grep -q 'Compress=yes'; then
    additional_output="journald is configured to compress large log files"
    result="Passed"
else
    additional_output="journald is not configured to compress large log files"
    result="Failed"
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


# 5.1.2.4 Ensure journald is configured to write logfiles to persistent disk
title="5.1.2.4 Ensure journald is configured to write logfiles to persistent disk"
if grep ^\s*Storage /etc/systemd/journald.conf | grep -q 'Storage=persistent'; then
    additional_output="journald is configured to write logfiles to persistent disk"
    result="Passed"
else
    additional_output="journald is not configured to write logfiles to persistent disk"
    result="Failed"
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

# 5.1.2.5 Ensure journald is not configured to send logs to rsyslog
title="5.1.2.5 Ensure journald is not configured to send logs to rsyslog"
if grep ^\s*ForwardToSyslog /etc/systemd/journald.conf | grep -q 'ForwardToSyslog'; then
    additional_output="journald is configured to send logs to rsyslog"
    result="Passed"
else
    additional_output="journald is not configured to send logs to rsyslog"
    result="Failed"
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

# 5.1.2.6 Ensure journald log rotation is configured per site policy
title="5.1.2.6 Ensure journald log rotation is configured per site policy"

if grep -E '^SystemMaxUse=|^SystemKeepFree=|^RuntimeMaxUse=|^RuntimeKeepFree=|^MaxFileSec=' /etc/systemd/journald.conf | grep -qE '=[0-9]+'; then
    
    log_rotation_configured=true
else
    
    log_rotation_configured=false
fi

# Display PASS or FAIL based on the checks
if [ "$log_rotation_configured" = true ]; then
    additional_output="journald log rotation is configured per site policy"
    result="Passed"
else
    additional_output="journald log rotation is not configured per site policy"
    result="Failed"
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


# 5.1.3 Ensure logrotate is configured
title="5.1.3 Ensure logrotate is configured"
if grep -E '^[[:space:]]*rotate[[:space:]]*|^size[[:space:]]*|^create[[:space:]]*|^compress[[:space:]]*' /etc/logrotate.conf /etc/logrotate.d/* | grep -qE '[0-9]+'; then

    logrotate_configured=true
else

    logrotate_configured=false
fi

# Display PASS or FAIL based on the checks
if [ "$logrotate_configured" = true ]; then
    additional_output="logrotate is properly configured"
    result="Passed"
else
    additional_output="logrotate is not properly configured"
    result="Failed"
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

# 5.1.4 Ensure all logfiles have appropriate access configured
title="5.1.4 Ensure all logfiles have appropriate access configured"

{ 
  l_output2=""
  l_uidmin="$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"
  
  file_test_chk() {
    l_op2=""
    if [ $(( $l_mode & $perm_mask )) -gt 0 ]; then
      l_op2="$l_op2\n - Mode: \"$l_mode\" should be \"$maxperm\" or more restrictive"
    fi
    
    if [[ ! "$l_user" =~ $l_auser ]]; then
      l_op2="$l_op2\n - Owned by: \"$l_user\" and should be owned by \"${l_auser//|/ or }\""
    fi
    
    if [[ ! "$l_group" =~ $l_agroup ]]; then
      l_op2="$l_op2\n - Group owned by: \"$l_group\" and should be group owned by \"${l_agroup//|/ or }\""
    fi
    
    [ -n "$l_op2" ] && l_output2="$l_output2\n - File: \"$l_fname\" is:$l_op2\n"
  }

  unset a_file && a_file=() # clear and initialize array

  # Loop to create an array with stat of files that could possibly fail one of the audits
  while IFS= read -r -d $'\0' l_file; do
    [ -e "$l_file" ] && a_file+=("$(stat -Lc '%n^%#a^%U^%u^%G^%g' "$l_file")")
  done < <(find -L /var/log -type f \( -perm /0137 -o ! -user root -o ! -group root \) -print0)

  while IFS="^" read -r l_fname l_mode l_user l_uid l_group l_gid; do
    l_bname="$(basename "$l_fname")"
    case "$l_bname" in
      lastlog | lastlog.* | wtmp | wtmp.* | wtmp-* | btmp | btmp.* | btmp-* | README)
        perm_mask='0113'
        maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
        l_auser="root"
        l_agroup="(root|utmp)"
        file_test_chk
        ;;
      secure | auth.log | syslog | messages)
        perm_mask='0137'
        maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
        l_auser="(root|syslog)"
        l_agroup="(root|adm)"
        file_test_chk
        ;;
      SSSD | sssd)
        perm_mask='0117'
        maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
        l_auser="(root|SSSD)"
        l_agroup="(root|SSSD)"
        file_test_chk
        ;;
      gdm | gdm3)
        perm_mask='0117'
        maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
        l_auser="root"
        l_agroup="(root|gdm|gdm3)"
        file_test_chk
        ;;
      *.journal | *.journal~)
        perm_mask='0137'
        maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
        l_auser="root"
        l_agroup="(root|systemd-journal)"
        file_test_chk
        ;;
      *)
        perm_mask='0137'
        maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
        l_auser="(root|syslog)"
        l_agroup="(root|adm)"

        if [ "$l_uid" -lt "$l_uidmin" ] && [ -z "$(awk -v grp="$l_group" -F: '$1==grp {print $4}' /etc/group)" ]; then
          if [[ ! "$l_user" =~ $l_auser ]]; then
            l_auser="(root|syslog|$l_user)"
          fi
          
          if [[ ! "$l_group" =~ $l_agroup ]]; then
            l_tst=""
            while l_out3="" read -r l_duid; do
              [ "$l_duid" -ge "$l_uidmin" ] && l_tst=failed
            done <<< "$(awk -F: '$4=='"$l_gid"' {print $3}' /etc/passwd)"

            [ "$l_tst" != "failed" ] && l_agroup="(root|adm|$l_group)"
          fi
        fi
        file_test_chk
        ;;
    esac
  done <<< "$(printf '%s\n' "${a_file[@]}")"
  unset a_file # Clear array

  # If all files passed, then we pass
  if [ -z "$l_output2" ]; then
    additional_output="All files in var/log/ have appropriate permissions and ownership"
    result="Passed"
  else
    additional_output="All files in var/log/ doesn't have appropriate permissions and ownership"
    result="Failed"
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
}


# 5.2.1.1 Ensure audit is installed
title="5.2.1.1 Ensure audit is installed"
if rpm -q audit | grep -q "audit"; then
  additional_output="Audit package is installed"
  result="Passed"
else
  additional_output="Audit package is not installed"
  result="Failed"
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

# 5.2.1.2 Ensure auditing for processes that start prior to auditd is enabled
title="5.2.1.2 Ensure auditing for processes that start prior to auditd is enabled"
if grubby --info=ALL | grep -Po '\baudit=1\b'; then
  additional_output="Audit parameter is set to 1"
  result="Passed"
else
  additional_output="Audit parameter is not set to 1"
  result="Failed"
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

# 5.2.1.3 Ensure audit_backlog_limit is sufficient
title="5.2.1.3 Ensure audit_backlog_limit is sufficient"
if grubby --info=ALL | grep -Po "\baudit_backlog_limit=\d+\b" | grep -q "audit_backlog_limit=[0-9]\+"; then
  additional_output="Audit backlog limit is set"
  result="Passed"
else
  additional_output="Audit backlog limit is not set or is invalid"
  result="Failed"
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

# 5.2.1.4 Ensure auditd service is enabled
title="5.2.1.4 Ensure auditd service is enabled"
if systemctl is-enabled auditd | grep -q "enabled"; then
  additional_output="Auditd service is enabled"
  result="Passed"
else
  additional_output="Auditd service is not enabled"
  result="Failed"
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

# 5.2.2.1 Ensure audit log storage size is configured
title="5.2.2.1 Ensure audit log storage size is configured"
if grep -w "^\s*max_log_file\s*=" /etc/audit/auditd.conf | grep -q "max_log_file = [0-9]\+"; then
  additional_output="Audit log storage size is configured"
  result="Passed"
else
  additional_output="Audit log storage size is not configured"
  result="Failed"
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

# 5.2.2.2 Ensure audit logs are not automatically deleted
title="5.2.2.2 Ensure audit logs are not automatically deleted"
if grep max_log_file_action /etc/audit/auditd.conf | grep -q "max_log_file_action = keep_logs"; then
  additional_output="Audit logs are set to keep_logs"
  result="Passed"
else
  additional_output="Audit logs are not set to keep_logs"
  result="Failed"
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

# 5.2.2.3 Ensure system is disabled when audit logs are full
title="5.2.2.3 Ensure system is disabled when audit logs are full"
if grep -P -- '^\h*disk_full_action\h*=\h*(halt|single)\b' /etc/audit/auditd.conf | grep -q "disk_full_action = [halt|single]"; then
  if grep -P -- '^\h*disk_error_action\h*=\h*(syslog|single|halt)\b' /etc/audit/auditd.conf | grep -q "disk_error_action = [syslog|single|halt]"; then
    additional_output="Disk full action is set to halt or single & Disk error action is set to syslog, single, or halt"
    result="Passed"
  else
    additional_output="Disk error action is not set to syslog single or halt"
    result="Failed"
  fi
else
  additional_output="Disk full action is not set to halt or single"
  result="Failed"
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

# 5.2.2.4 Ensure system warns when audit logs are low on space
title="5.2.2.4 Ensure system warns when audit logs are low on space"

if grep -P -- '^\h*space_left_action\h*=\h*(email|exec|single|halt)\b' /etc/audit/auditd.conf | grep -q "space_left_action = [email|exec|single|halt]"; then
  if grep -P -- '^\h*admin_space_left_action\h*=\h*(single|halt)\b' /etc/audit/auditd.conf | grep -q "admin_space_left_action = [single|halt]"; then  
    additional_output="Space left action is set to email, exec, single, or halt & Admin space left action is set to single or halt"
    result="Passed"
  else
    additional_output="Admin space left action is not set to single or halt"
    result="Failed"
  fi
else
  additional_output="Space left action is not set to email exec single or halt"
  result="Failed"
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

# Check system architecture
ARCH=$(uname -m)

# 5.2.3.1 Ensure changes to system administration scope (sudoers) is collected
title="5.2.3.1 Ensure changes to system administration scope (sudoers) is collected"
if [ "$ARCH" == "x86_64" ]; then
    output=$(awk '/^ *-w/ && /\/etc\/sudoers/ && / +-p *wa/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)
    expected_output="-w /etc/sudoers -p wa -k scope -w /etc/sudoers.d -p wa -k scope"
    if [ "$output" == "$expected_output" ]; then
        output=$(auditctl -l | awk '/^ *-w/ && /\/etc\/sudoers/ && / +-p *wa/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)')
        expected_output="-w /etc/sudoers -p wa -k scope -w /etc/sudoers.d -p wa -k scope"
        if [ "$output" == "$expected_output" ]; then
          additional_output="on-disk rules and loaded rules for sudoers are collected"
          result="Passed"
        else
          additional_output="loaded rules for sudoers isn't collected"
          result="Failed"
        fi
    else
        additional_output="on-disk rules for sudoers isn't collected"
        result="Failed"
    fi
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

# 5.2.3.2 Ensure actions as another user are always logged
title="5.2.3.2 Ensure actions as another user are always logged"
if [ "$ARCH" == "x86_64" ]; then
    output=$(awk '/^ *-a *always,exit/ && / -F *arch=b64/ && (/ -F *auid!=unset/ || / -F *auid!=-1/ || / -F *auid!=4294967295/) && (/ -C *euid!=uid/ || / -C *uid!=euid/) && / -S *execve/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)
    expected_output="-a always,exit -F arch=b64 -C euid!=uid -F auid!=unset -S execve -k user_emulation"
    if [ "$output" == "$expected_output" ]; then
        output=$(auditctl -l | awk '/^ *-a *always,exit/ && / -F *arch=b64/ && (/ -F *auid!=unset/ || / -F *auid!=-1/ || / -F *auid!=4294967295/) && (/ -C *euid!=uid/ || / -C *uid!=euid/) && / -S *execve/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)')
        expected_output="-a always,exit -F arch=b64 -S execve -C uid!=euid -F auid!=-1 -F key=user_emulation"
        if [ "$output" == "$expected_output" ]; then
          additional_output="on-disk rules and loaded rules for as another user are always logged"
          result="Passed"
        else
          additional_output="loaded rules for as another user isn't always logged"
          result="Failed"
        fi
    else
        additional_output="on-disk rules for as another user isn't always logged"
        result="Failed"
    fi   
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

# 5.2.3.3 Ensure events that modify the sudo log file are collected
title="5.2.3.3 Ensure events that modify the sudo log file are collected"
if [ "$ARCH" == "x86_64" ]; then
    SUDO_LOG_FILE_ESCAPED=$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,? .*//' -e 's/\"//g' -e 's|/|\\\/|g')
    if [ -n "$SUDO_LOG_FILE_ESCAPED" ]; then
        output=$(awk "/^ *-w/ && /\"$SUDO_LOG_FILE_ESCAPED\"/ && / +-p *wa/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules)
        expected_output="-w /var/log/sudo.log -p wa -k sudo_log_file"
        if [ "$output" == "$expected_output" ]; then
            output=$(auditctl -l | awk "/^ *-w/ && /\"$SUDO_LOG_FILE_ESCAPED\"/ && / +-p *wa/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)")
            expected_output="-w /var/log/sudo.log -p wa -k sudo_log_file"
            if [ "$output" == "$expected_output" ]; then
              additional_output="on-disk rules and loaded rules for sudo log file modifications are collected"
              result="Passed"
            else
              additional_output="loaded rules for sudo log file modifications isn't collected"
              result="Failed"
            fi
        else
            additional_output="on-disk rules for sudo log file modifications isn't collected"
            result="Failed"
        fi
    else
        additional_output="Variable 'SUDO_LOG_FILE_ESCAPED' is unset"
        result="Failed"
    fi
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

# 5.2.3.4 Ensure events that modify date and time information are collected
title="5.2.3.4 Ensure events that modify date and time information are collected"
if [ "$ARCH" == "x86_64" ]; then
    output=$(awk '/^ *-a *always,exit/ && / -F *arch=b64/ && / -S/ && (/adjtimex/ || /settimeofday/ || /clock_settime/ ) && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules; awk '/^ *-w/ && /\/etc\/localtime/ && / +-p *wa/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)

    expected_output="-a always,exit -F arch=b64 -S adjtimex,settimeofday,clock_settime -k time-change -w /etc/localtime -p wa -k time-change"
    if [ "$output" == "$expected_output" ]; then
        output=$(auditctl -l | awk '/^ *-a *always,exit/ && / -F *arch=b64/ && / -S/ && (/adjtimex/ || /settimeofday/ || /clock_settime/ ) && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)' auditctl -l | awk '/^ *-w/ && /\/etc\/localtime/ && / +-p *wa/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)')
        expected_output="-a always,exit -F arch=b64 -S adjtimex,settimeofday,clock_settime -F key=time-change -w /etc/localtime -p wa -k time-change"
        if [ "$output" == "$expected_output" ]; then
          additional_output="on-disk rules and loaded rules for modify date and time information are collected"
          result="Passed"
        else
          additional_output="loaded rules for modify date and time information isn't collected"
          result="Failed"
        fi
    else
        additional_output="on-disk rules for modify date and time information isn't collected"
        result="Failed"
    fi
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

# 5.2.3.5 Ensure events that modify the system's network environment are collected
title="5.2.3.5 Ensure events that modify the system's network environment are collected"
if [ "$ARCH" == "x86_64" ]; then
    output=$(awk '/^ *-a *always,exit/ && / -F *arch=b64/ && / -S/ && (/sethostname/ || /setdomainname/) && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules; awk '/^ *-w/ && (/\/etc\/issue/ || /\/etc\/issue.net/ || /\/etc\/hosts/ || /\/etc\/sysconfig\/network/) && / +-p *wa/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)


    expected_output="-a always,exit -F arch=b64 -S sethostname,setdomainname -k system-locale -w /etc/issue -p wa -k system-locale -w /etc/issue.net -p wa -k system-locale -w /etc/hosts -p wa -k system-locale -w /etc/sysconfig/network -p wa -k system-locale -w /etc/sysconfig/network-scripts/ -p wa -k system-locale"
    if [ "$output" == "$expected_output" ]; then
        output=$(auditctl -l | awk '/^ *-a *always,exit/ && / -F *arch=b64/ && / -S/ && (/sethostname/ || /setdomainname/) && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)' auditctl -l | awk '/^ *-w/ && (/\/etc\/issue/ || /\/etc\/issue.net/ || /\/etc\/hosts/ || /\/etc\/sysconfig\/network/) && / +-p *wa/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)')
        expected_output="-a always,exit -F arch=b64 -S sethostname,setdomainname -F key=system-locale -w /etc/issue -p wa -k system-locale -w /etc/issue.net -p wa -k system-locale -w /etc/hosts -p wa -k system-locale -w /etc/sysconfig/network -p wa -k system-locale -w /etc/sysconfig/network-scripts/ -p wa -k system-locale"
        if [ "$output" == "$expected_output" ]; then
           additional_output="on-disk rules and loaded rules for network environment modifications are collected"
        else
           additional_output="loaded rules for network environment modifications isn't collected"
        fi
    else
        additional_output="on-disk rules for network environment modifications isn't collected"
    fi
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

title="5.2.3.6 Ensure use of privileged commands are collected"
if [ "$ARCH" == "x86_64" ]; then
    on_disk_output=$(for PARTITION in $(findmnt -n -l -k -it $(awk '/nodev/ { print $2 }' /proc/filesystems | paste -sd,) | grep -Pv "noexec|nosuid" | awk '{print $1}'); do for PRIVILEGED in $(find "${PARTITION}" -xdev -perm /6000 -type f); do grep -qr "${PRIVILEGED}" /etc/audit/rules.d && printf "OK: '${PRIVILEGED}' found in auditing rules.\n" || printf "Warning: '${PRIVILEGED}' not found in on-disk configuration.\n"; done; done)
    
    expected_on_disk_output="OK"  # Modify this based on your expected result

    if [ "$on_disk_output" == "$expected_on_disk_output" ]; then
        loaded_output=$(RUNNING=$(auditctl -l) [ -n "${RUNNING}" ] && for PARTITION in $(findmnt -n -l -k -it $(awk '/nodev/ { print $2 }' /proc/filesystems | paste -sd,) | grep -Pv "noexec|nosuid" | awk '{print $1}'); do for PRIVILEGED in $(find "${PARTITION}" -xdev -perm /6000 -type f); do printf -- "${RUNNING}" | grep -q "${PRIVILEGED}" && printf "OK: '${PRIVILEGED}' found in auditing rules.\n" || printf "Warning: '${PRIVILEGED}' not found in running configuration.\n"; done; done || printf "ERROR: Variable 'RUNNING' is unset.")

        expected_loaded_output="OK"  # Modify this based on your expected result

        if [ "$loaded_output" == "$expected_loaded_output" ]; then
            additional_output="on-disk rules and loaded rules for privileged commands are collected"
            result="Passed"
        else
            additional_output="loaded rules for privileged commands isn't collected"
            result="Failed"
        fi
    else
        additional_output="on-disk rules for privileged commands isn't collected"
        result="Failed"
    fi
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

title="5.2.3.7 Ensure unsuccessful file access attempts are collected"

UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)

if [ -n "${UID_MIN}" ]; then
    on_disk_output=$(awk "/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&(/ -F *exit=-EACCES/||/ -F *exit=-EPERM/) &&/ -S/ &&/creat/ &&/open/ &&/truncate/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n")


    expected_on_disk_output="-a always,exit -F arch=b64 -S creat,open,openat,truncate,ftruncate -F exit=-EACCES -F auid>=${UID_MIN} -F auid!=unset -k access 
-a always,exit -F arch=b64 -S creat,open,openat,truncate,ftruncate -F exit=-EPERM -F auid>=${UID_MIN} -F auid!=unset -k access"

    if [ "$on_disk_output" == "$expected_on_disk_output" ]; then
        loaded_output=$(auditctl -l | awk "/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&(/ -F *exit=-EACCES/||/ -F *exit=-EPERM/) &&/ -S/ &&/creat/ &&/open/ &&/truncate/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" || printf "ERROR: Variable 'UID_MIN' is unset.\n")

        expected_loaded_output="-a always,exit -F arch=b64 -S open,truncate,ftruncate,creat,openat -F exit=-EACCES -F auid>=${UID_MIN} -F auid!=-1 -F key=access 
-a always,exit -F arch=b64 -S open,truncate,ftruncate,creat,openat -F exit=-EPERM -F auid>=${UID_MIN} -F auid!=-1 -F key=access"

        if [ "$loaded_output" == "$expected_loaded_output" ]; then
            additional_output="on-disk rules and loaded rules for unsuccessful file access attempts are collected"
            result="Passed"
        else
            additional_output="loaded rules for unsuccessful file access attempts aren't collected"
            result="Failed"
        fi
    else
        additional_output="on-disk rules for unsuccessful file access attempts aren't collected"
        result="Failed"
    fi
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

title="5.2.3.8 Ensure events that modify user/group information are collected"

on_disk_output=$(awk '/^ *-w/ &&(/\/etc\/group/ ||/\/etc\/passwd/ ||/\/etc\/gshadow/ ||/\/etc\/shadow/ ||/\/etc\/security\/opasswd/) &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules || printf "ERROR: On-disk rules check failed.\n")

expected_on_disk_output="-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity"

if [ "$on_disk_output" == "$expected_on_disk_output" ]; then
    loaded_output=$(auditctl -l | awk '/^ *-w/ &&(/\/etc\/group/ ||/\/etc\/passwd/ ||/\/etc\/gshadow/ ||/\/etc\/shadow/ ||/\/etc\/security\/opasswd/) &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' || printf "ERROR: Loaded rules check failed.\n")

    expected_loaded_output="-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity"

    if [ "$loaded_output" == "$expected_loaded_output" ]; then
        additional_output="On-disk and loaded rules for events that modify user/group information are collected"
        result="Passed"
    else
        additional_output="Loaded rules for events that modify user/group information aren't collected"
        result="Failed"
    fi
else
    additional_output="On-disk rules for events that modify user/group information aren't collected"
    result="Failed"
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

title="5.2.3.9 Ensure discretionary access control permission modification events are collected"

UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)

if [ -n "${UID_MIN}" ]; then
    on_disk_output=$(awk "/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -S/ &&/ -F *auid>=${UID_MIN}/ &&(/chmod/||/fchmod/||/fchmodat/ ||/chown/||/fchown/||/fchownat/||/lchown/ ||/setxattr/||/lsetxattr/||/fsetxattr/ ||/removexattr/||/lremovexattr/||/fremovexattr/) &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n")

    expected_on_disk_output="-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=${UID_MIN} -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=${UID_MIN} -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=${UID_MIN} -F auid!=unset -F key=perm_mod"

    if [ "$on_disk_output" == "$expected_on_disk_output" ]; then
        loaded_output=$(auditctl -l | awk "/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -S/ &&/ -F *auid>=${UID_MIN}/ &&(/chmod/||/fchmod/||/fchmodat/ ||/chown/||/fchown/||/fchownat/||/lchown/ ||/setxattr/||/lsetxattr/||/fsetxattr/ ||/removexattr/||/lremovexattr/||/fremovexattr/) &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" || printf "ERROR: Variable 'UID_MIN' is unset.\n")

        expected_loaded_output="-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=${UID_MIN} -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=${UID_MIN} -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=${UID_MIN} -F auid!=-1 -F key=perm_mod"

        if [ "$loaded_output" == "$expected_loaded_output" ]; then
            additional_output="On-disk and loaded rules for discretionary access control permission modification events are collected"
            result="Passed"
        else
            additional_output="Loaded rules for discretionary access control permission modification events aren't collected"
            result="Failed"
        fi
    else
        additional_output="On-disk rules for discretionary access control permission modification events aren't collected"
        result="Failed"
    fi
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


title="5.2.3.10 Ensure successful file system mounts are collected"

UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)

if [ -n "${UID_MIN}" ]; then
    on_disk_output=$(awk "/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -S/ &&/ -F *auid>=${UID_MIN}/ &&/ -S/ &&/mount/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n")


    expected_on_disk_output="-a always,exit -F arch=b64 -S mount -F auid>=${UID_MIN} -F auid!=unset -k mounts"

    if [ "$on_disk_output" == "$expected_on_disk_output" ]; then
        loaded_output=$(auditctl -l | awk "/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -S/ &&/ -F *auid>=${UID_MIN}/ &&/ -S/ &&/mount/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" || printf "ERROR: Variable 'UID_MIN' is unset.\n")

        expected_loaded_output="-a always,exit -F arch=b64 -S mount -F auid>=${UID_MIN} -F auid!=-1 -F key=mounts"

        if [ "$loaded_output" == "$expected_loaded_output" ]; then
            additional_output="on-disk rules and loaded rules for successful file system mounts are collected"
            result="Passed"
        else
            additional_output="loaded rules for successful file system mounts aren't collected"
            result="Failed"
        fi
    else
        additional_output="on-disk rules for successful file system mounts aren't collected"
        result="Failed"
    fi
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

title="5.2.3.11 Ensure session initiation information is collected"

on_disk_output=$(awk '/^ *-w/ &&(/\/var\/run\/utmp/ || /\/var\/log\/wtmp/ || /\/var\/log\/btmp/) &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)


expected_on_disk_output="-w /var/run/utmp -p wa -k session 
-w /var/log/wtmp -p wa -k session 
-w /var/log/btmp -p wa -k session"

if [ "$on_disk_output" == "$expected_on_disk_output" ]; then
    loaded_output=$(auditctl -l | awk '/^ *-w/ &&(/\/var\/run\/utmp/ || /\/var\/log\/wtmp/ || /\/var\/log\/btmp/) &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/')')'

    expected_loaded_output="-w /var/run/utmp -p wa -k session 
-w /var/log/wtmp -p wa -k session 
-w /var/log/btmp -p wa -k session"

    if [ "$loaded_output" == "$expected_loaded_output" ]; then
        additional_output="on-disk rules and loaded rules for session initiation information are collected"
        result="Passed"
    else
        additional_output="loaded rules for session initiation information aren't collected"
        result="Failed"
    fi
else
    additional_output="on-disk rules for session initiation information aren't collected"
    result="Failed"
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

title="5.2.3.12 Ensure login and logout events are collected"

on_disk_output=$(awk '/^ *-w/ &&(/\/var\/log\/lastlog/ || /\/var\/run\/faillock/) &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)

expected_on_disk_output="-w /var/log/lastlog -p wa -k logins 
-w /var/run/faillock -p wa -k logins"

if [ "$on_disk_output" == "$expected_on_disk_output" ]; then
    loaded_output=$(auditctl -l | awk '/^ *-w/ &&(/\/var\/log\/lastlog/ || /\/var\/run\/faillock/) &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')

    expected_loaded_output="-w /var/log/lastlog -p wa -k logins 
-w /var/run/faillock -p wa -k logins"

    if [ "$loaded_output" == "$expected_loaded_output" ]; then
        additional_output="on-disk rules and loaded rules for login and logout events are collected"
        result="Passed"
    else
        additional_output="loaded rules for login and logout events aren't collected"
        result="Failed"
    fi
else
    additional_output="on-disk rules for login and logout events aren't collected"
    result="Failed"
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

title="5.2.3.13 Ensure file deletion events by users are collected"

UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)

if [ -n "${UID_MIN}" ]; then
    on_disk_output=$({ awk "/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -S/ &&(/unlink/||/rename/||/unlinkat/||/renameat/) &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n"; })

    expected_on_disk_output="-a always,exit -F arch=b64 -S unlink,unlinkat,rename,renameat -F auid>=${UID_MIN} -F auid!=unset -k delete"

    if [ "$on_disk_output" == "$expected_on_disk_output" ]; then
        loaded_output=$({ auditctl -l | awk "/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -S/ &&(/unlink/||/rename/||/unlinkat/||/renameat/) &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" || printf "ERROR: Variable 'UID_MIN' is unset.\n"; })

        expected_loaded_output="-a always,exit -F arch=b64 -S rename,unlink,unlinkat,renameat -F auid>=${UID_MIN} -F auid!=-1 -F key=delete"

        if [ "$loaded_output" == "$expected_loaded_output" ]; then
            additional_output="on-disk rules and loaded rules for file deletion events by users are collected"
            result="Passed"
        else
            additional_output="loaded rules for file deletion events by users aren't collected"
            result="Failed"
        fi
    else
        additional_output="on-disk rules for file deletion events by users aren't collected"
        result="Failed"
    fi
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

title="5.2.3.14 Ensure events that modify the system's Mandatory Access Controls are collected"

on_disk_output=$(awk '/^ *-w/ &&(/\/etc\/selinux/ ||/\/usr\/share\/selinux/) &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)

expected_on_disk_output="-w /etc/selinux -p wa -k MAC-policy 
-w /usr/share/selinux -p wa -k MAC-policy"

if [ "$on_disk_output" == "$expected_on_disk_output" ]; then
    loaded_output=$(auditctl -l | awk '/^ *-w/ &&(/\/etc\/selinux/ ||/\/usr\/share\/selinux/) &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')

    expected_loaded_output="-w /etc/selinux -p wa -k MAC-policy 
-w /usr/share/selinux -p wa -k MAC-policy"

    if [ "$loaded_output" == "$expected_loaded_output" ]; then
        additional_output="on-disk rules and loaded rules for events modifying MAC are collected"
        result="Passed"
    else
        additional_output="loaded rules for events modifying MAC aren't collected"
        result="Failed"
    fi
else
    additional_output="on-disk rules for events modifying MAC aren't collected"
    result="Failed"
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

title="5.2.3.15 Ensure successful and unsuccessful attempts to use the chcon command are recorded"

UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)

if [ -n "${UID_MIN}" ]; then
    on_disk_output=$(awk "/^ *-a *always,exit/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -F *perm=x/ &&/ -F *path=\/usr\/bin\/chcon/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n")

    expected_on_disk_output="-a always,exit -F path=/usr/bin/chcon -F perm=x -F auid>=${UID_MIN} -F auid!=unset -k perm_chng"

    if [ "$on_disk_output" == "$expected_on_disk_output" ]; then
        loaded_output=$(auditctl -l | awk "/^ *-a *always,exit/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -F *perm=x/ &&/ -F *path=\/usr\/bin\/chcon/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" || printf "ERROR: Variable 'UID_MIN' is unset.\n")

        expected_loaded_output="-a always,exit -S all -F path=/usr/bin/chcon -F perm=x -F auid>=${UID_MIN} -F auid!=-1 -F key=perm_chng"

        if [ "$loaded_output" == "$expected_loaded_output" ]; then
            additional_output="On-disk and loaded rules for attempts to use the chcon command are recorded"
            result="Passed"
        else
            additional_output="Loaded rules for attempts to use the chcon command aren't recorded"
            result="Failed"
        fi
    else
        additional_output="On-disk rules for attempts to use the chcon command aren't recorded"
        result="Failed"
    fi
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

title="5.2.3.16 Ensure successful and unsuccessful attempts to use the setfacl command are recorded"

UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)

if [ -n "${UID_MIN}" ]; then
    on_disk_output=$(awk "/^ *-a *always,exit/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -F *perm=x/ &&/ -F *path=\/usr\/bin\/setfacl/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n")

    expected_on_disk_output="-a always,exit -F path=/usr/bin/setfacl -F perm=x -F auid>=${UID_MIN} -F auid!=unset -k perm_chng"

    if [ "$on_disk_output" == "$expected_on_disk_output" ]; then
        loaded_output=$(auditctl -l | awk "/^ *-a *always,exit/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -F *perm=x/ &&/ -F *path=\/usr\/bin\/setfacl/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" || printf "ERROR: Variable 'UID_MIN' is unset.\n")

        expected_loaded_output="-a always,exit -S all -F path=/usr/bin/setfacl -F perm=x -F auid>=${UID_MIN} -F auid!=-1 -F key=perm_chng"

        if [ "$loaded_output" == "$expected_loaded_output" ]; then
            additional_output="On-disk and loaded rules for attempts to use the setfacl command are recorded"
            result="Passed"
        else
            additional_output="Loaded rules for attempts to use the setfacl command aren't recorded"
            result="Failed"
        fi
    else
        additional_output="On-disk rules for attempts to use the setfacl command aren't recorded"
        result="Failed"
    fi
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


title="5.2.3.17 Ensure successful and unsuccessful attempts to use the chacl command are recorded"

UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)

if [ -n "${UID_MIN}" ]; then
    on_disk_output=$(awk "/^ *-a *always,exit/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -F *perm=x/ &&/ -F *path=\/usr\/bin\/chacl/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n")

    expected_on_disk_output="-a always,exit -F path=/usr/bin/chacl -F perm=x -F auid>=${UID_MIN} -F auid!=unset -k perm_chng"

    if [ "$on_disk_output" == "$expected_on_disk_output" ]; then
        loaded_output=$(auditctl -l | awk "/^ *-a *always,exit/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -F *perm=x/ &&/ -F *path=\/usr\/bin\/chacl/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" || printf "ERROR: Variable 'UID_MIN' is unset.\n")

        expected_loaded_output="-a always,exit -S all -F path=/usr/bin/chacl -F perm=x -F auid>=${UID_MIN} -F auid!=-1 -F key=perm_chng"

        if [ "$loaded_output" == "$expected_loaded_output" ]; then
            additional_output="On-disk and loaded rules for attempts to use the chacl command are recorded"
            result="Passed"
        else
            additional_output="Loaded rules for attempts to use the chacl command aren't recorded"
            result="Failed"
        fi
    else
        additional_output="On-disk rules for attempts to use the chacl command aren't recorded"
        result="Failed"
    fi
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

title="5.2.3.18 Ensure successful and unsuccessful attempts to use the usermod command are recorded"

UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)

if [ -n "${UID_MIN}" ]; then
    on_disk_output=$( auditctl -l | awk "/^ *-a *always,exit/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -F *perm=x/ &&/ -F *path=\/usr\/sbin\/usermod/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" || printf "ERROR: Variable 'UID_MIN' is unset." )


    expected_on_disk_output="-a always,exit -F path=/usr/sbin/usermod -F perm=x -F auid>=${UID_MIN} -F auid!=unset -k usermod"

    if [ "$on_disk_output" == "$expected_on_disk_output" ]; then
        loaded_output=$( auditctl -l | awk "/^ *-a *always,exit/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -F *perm=x/ &&/ -F *path=\/usr\/sbin\/usermod/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" || printf "ERROR: Variable 'UID_MIN' is unset." )

        expected_loaded_output="-a always,exit -S all -F path=/usr/sbin/usermod -F perm=x -F auid>=${UID_MIN} -F auid!=-1 -F key=usermod"

        if [ "$loaded_output" == "$expected_loaded_output" ]; then
            additional_output="on-disk rules and loaded rules for usermod command attempts are collected"
            result="Passed"
        else
            additional_output="loaded rules for usermod command attempts aren't collected"
            result="Failed"
        fi
    else
        additional_output="on-disk rules for usermod command attempts aren't collected"
        result="Failed"
    fi
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

title="5.2.3.19 Ensure kernel module loading unloading and modification is collected"

# Check on-disk rules
on_disk_output=$(awk '/^ -a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F auid!=unset/||/ -F auid!=-1/||/ -F auid!=4294967295/) &&/ -S/ &&(/init_module/ ||/finit_module/ ||/delete_module/ ||/create_module/ ||/query_module/) &&(/ key= *[!-~] $/||/ -k *[!-~] $/)' /etc/audit/rules.d/.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n")

# Check on-disk rules related to kmod
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
kmod_on_disk_output=$( [ -n "${UID_MIN}" ] && awk "/^ -a *always,exit/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -F *perm=x/ &&/ -F *path=\/usr\/bin\/kmod/ &&(/ key= *[!-~] $/||/ -k *[!-~] $/)" /etc/audit/rules.d/.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n")

expected_on_disk_output="-a always,exit -F arch=b64 -S init_module,finit_module,delete_module,create_module,query_module -F auid>=1000 -F auid!=unset -k kernel_modules 
-a always,exit -F path=/usr/bin/kmod -F perm=x -F auid>=1000 -F auid!=unset -k kernel_modules"

if [ "$on_disk_output" == "$expected_on_disk_output" ] && [ "$kmod_on_disk_output" == "$expected_on_disk_output" ]; then
    # Check loaded rules
    loaded_output=$(auditctl -l | awk '/^ -a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F auid!=unset/||/ -F auid!=-1/||/ -F auid!=4294967295/) &&/ -S/ &&(/init_module/ ||/finit_module/ ||/delete_module/ ||/create_module/ ||/query_module/) &&(/ key= *[!-~] $/||/ -k *[!-~] *$/)' || printf "ERROR: Variable 'UID_MIN' is unset.\n")

    # Check loaded rules related to kmod
    kmod_loaded_output=$( [ -n "${UID_MIN}" ] && auditctl -l | awk "/^ -a *always,exit/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -F *perm=x/ &&/ -F *path=\/usr\/bin\/kmod/ &&(/ key= *[!-~] $/||/ -k *[!-~] *$/)" || printf "ERROR: Variable 'UID_MIN' is unset.\n")

    expected_loaded_output="-a always,exit -F arch=b64 -S init_module,finit_module,delete_module,create_module,query_module -F auid>=1000 -F auid!=-1 -F key=kernel_modules 
-a always,exit -S all -F path=/usr/bin/kmod -F perm=x -F auid>=1000 -F auid!=-1 -F key=kernel_modules"

    if [ "$loaded_output" == "$expected_loaded_output" ] && [ "$kmod_loaded_output" == "$expected_loaded_output" ]; then
        additional_output="On-disk and loaded rules for kernel module loading unloading and modification are collected"
        result="Passed"
    else
        additional_output="Loaded rules for kernel module loading unloading and modification aren't collected"
        result="Failed"
    fi
else
    additional_output="On-disk rules for kernel module loading unloading and modification aren't collected"
    result="Failed"
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


# 5.2.3.20 Ensure the audit configuration is immutable
title="5.2.3.20 Ensure the audit configuration is immutable"

immutable_output=$(grep -Ph -- '^\h*-e\h+2\b' /etc/audit/rules.d/*.rules | tail -1)

expected_immutable_output="-e 2"

if [ "$immutable_output" == "$expected_immutable_output" ]; then
    additional_output="audit configuration is immutable"
    result="Passed"
else
    additional_output="audit configuration is not immutable"
    result="Failed"
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

# 5.2.3.21 Ensure the running and on disk configuration is the same
title="5.2.3.21 Ensure the running and on disk configuration is the same"

check_output=$(augenrules --check)

if [[ "$check_output" == "No change" ]]; then
    additional_output="running and on-disk audit configurations are the same"
    result="Passed"
else
    additional_output="running and on-disk audit configurations are different"
    result="Failed"
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

# 5.2.4.1 Ensure the audit log directory is 0750 or more restrictive
title="5.2.4.1 Ensure the audit log directory is 0750 or more restrictive"
log_directory=$(dirname $(awk -F"=" '/^\s*log_file\s*=\s*/ {print $2}' /etc/audit/auditd.conf))
log_directory_mode=$(stat -Lc "%a" "$log_directory")
if [[ "$log_directory_mode" =~ ^(0?[0-5][0-7]0)$ ]]; then
    additional_output="the audit log directory is 0750 or more restrictive"
    result="Passed"
else
    additional_output="the audit log directory isn't 0750 or more restrictive"
    result="Failed"
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

# 5.2.4.2 Ensure audit log files are mode 0640 or less permissive
title="5.2.4.2 Ensure audit log files are mode 0640 or less permissive"
log_files=$(find "$log_directory" -type f \( ! -perm 600 -a ! -perm 0400 -a ! -perm 0200 -a ! -perm 0000 -a ! -perm 0640 -a ! -perm 0440 -a ! -perm 0040 \) -exec stat -Lc "%n %#a" {} +)
if [ -z "$log_files" ]; then
    additional_output="audit log files are mode 0640 or less permissive"
    result="Passed"
else
    additional_output="audit log files aren't mode 0640 or less permissive"
    result="Failed"
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

# 5.2.4.3 Ensure only authorized users own audit log files
title="5.2.4.3 Ensure only authorized users own audit log files"
owned_by_root=$(find "$log_directory" -type f ! -user root -exec stat -Lc "%n %U" {} +)
if [ -z "$owned_by_root" ]; then
    additional_output="only authorized users own audit log files"
    result="Passed"
else
    additional_output="unauthorized users own audit log files"
    result="Failed"
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

# 5.2.4.4 Ensure only authorized groups are assigned ownership of audit log files
title="5.2.4.4 Ensure only authorized groups are assigned ownership of audit log files"
log_group=$(grep -Piw -- '^\h*log_group\h*=\h*(adm|root)\b' /etc/audit/auditd.conf)
if [ -n "$log_group" ]; then
    group_check=$(stat -c "%n %G" "$log_directory"/* | grep -Pv '^\h*\H+\h+(adm|root)\b')
    if [ -z "$group_check" ]; then
        additional_output="only authorized groups are assigned ownership of audit log files"
        result="Passed"
    else
        additional_output="unauthorized groups are assigned ownership of audit log files"
        result="Failed"
    fi
else
    additional_output="unauthorized groups are assigned ownership of audit log files"
    result="Failed"
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

# 5.2.4.5 Ensure audit configuration files are 640 or more restrictive
title="5.2.4.5 Ensure audit configuration files are 640 or more restrictive"
config_files_mode=$(find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) -exec stat -Lc "%n %a" {} + | grep -Pv -- '^\h*\H+\h*([0,2,4,6][0,4]0)\h*$')
if [ -z "$config_files_mode" ]; then
    additional_output="audit configuration files are 640 or more restrictive"
    result="Passed"
else
    additional_output="audit configuration files aren't 640 or more restrictive"
    result="Failed"
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

# 5.2.4.6 Ensure audit configuration files are owned by root
title="5.2.4.6 Ensure audit configuration files are owned by root"
config_files_owned_by_root=$(find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root)
if [ -z "$config_files_owned_by_root" ]; then
    additional_output="audit configuration files are owned by root"
    result="Passed"
else
    additional_output="audit configuration files aren't owned by root"
    result="Failed"
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

# 5.2.4.7 Ensure audit configuration files belong to group root
title="5.2.4.7 Ensure audit configuration files belong to group root"
config_files_group_root=$(find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -group root)
if [ -z "$config_files_group_root" ]; then
    additional_output="audit configuration files belong to group root"
    result="Passed"
else
    additional_output="audit configuration files doesn't belong to group root"
    result="Failed"
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

# 5.2.4.8 Ensure audit tools are 755 or more restrictive
title="5.2.4.8 Ensure audit tools are 755 or more restrictive"
audit_tools_mode=$(stat -c "%n %a" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | grep -Pv -- '^\h*\H+\h+([0-7][0,1,4,5][0,1,4,5])\h*$')
if [ -z "$audit_tools_mode" ]; then
    additional_output="audit tools are 755 or more restrictive"
    result="Passed"
else
    additional_output="audit tools aren't 755 or more restrictive"
    result="Failed"
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

# 5.2.4.9 Ensure audit tools are owned by root
title="5.2.4.9 Ensure audit tools are owned by root"
audit_tools_owned_by_root=$(stat -c "%n %U" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | grep -Pv -- '^\h*\H+\h+root\h*$')
if [ -z "$audit_tools_owned_by_root" ]; then
    additional_output="audit tools are owned by root"
    result="Passed"
else
    additional_output="audit tools aren't owned by root"
    result="Failed"
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

# 5.2.4.10 Ensure audit tools belong to group root
title="5.2.4.10 Ensure audit tools belong to group root"
audit_tools_group_root=$(stat -c "%n %a %U %G" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | grep -Pv -- '^\h*\H+\h+([0-7][0,1,4,5][0,1,4,5])\h+root\h+root\h*$')
if [ -z "$audit_tools_group_root" ]; then
    additional_output="audit tools belong to group root"
    result="Passed"
else
    additional_output="audit tools doesn't belong to group root"
    result="Failed"
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

# 5.3.1 Ensure AIDE is installed
title="5.3.1 Ensure AIDE is installed"
aide_installed=$(rpm -q aide)
expected_aide_version="aide-<version>"

if [ "$aide_installed" == "$expected_aide_version" ]; then
    additional_output="AIDE is installed"
    result="Passed"
else
    additional_output="AIDE isn't installed"
    result="Failed"
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

# 5.3.2 Ensure filesystem integrity is regularly checked
title="5.3.2 Ensure filesystem integrity is regularly checked"
cron_job_check=$(grep -Ers '^([^#]+\s+)?(\/usr\/s?bin\/|^\s*)aide(\.wrapper)?\s(--?\S+\s)*(--(check|update)|\$AIDEARGS)\b' /etc/cron.* /etc/crontab /var/spool/cron/)

if [ -n "$cron_job_check" ]; then
    additional_output="filesystem integrity is regularly checked"
    result="Passed"
else
    additional_output="filesystem integrity isn't regularly checked"
    result="Failed"
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
# 5.3.3 Ensure cryptographic mechanisms are used to protect the integrity of audit tools
title="5.3.3 Ensure cryptographic mechanisms are used to protect the integrity of audit tools"
aide_config=$(grep -Ps -- '(\/sbin\/(audit|au)\H*\b)' /etc/aide.conf.d/*.conf /etc/aide.conf)

expected_aide_config="/sbin/auditctl p+i+n+u+g+s+b+acl+xattrs+sha512 
/sbin/auditd p+i+n+u+g+s+b+acl+xattrs+sha512 
/sbin/ausearch p+i+n+u+g+s+b+acl+xattrs+sha512 
/sbin/aureport p+i+n+u+g+s+b+acl+xattrs+sha512 
/sbin/autrace p+i+n+u+g+s+b+acl+xattrs+sha512 
/sbin/augenrules p+i+n+u+g+s+b+acl+xattrs+sha512"

if [ "$aide_config" == "$expected_aide_config" ]; then
    additional_output="cryptographic mechanisms are used to protect the integrity of audit tools"
    result="Passed"
else
    additional_output="cryptographic mechanisms aren't used to protect the integrity of audit toolsv"
    result="Failed"
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
