#!/bin/bash

title="4.1.1.1 - Ensure cron daemon is enabled and running"

systemctl is-enabled crond.service &> /dev/null
if [[ $? -eq 0 ]]; then
    result="Passed"
     additional_output="Cron daemon is enabled and running"
else
    result="Failed"
     additional_output="Cron daemon is not enabled and running"
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



# 4.1.1.2 - Ensure permissions on /etc/crontab are configured
title="4.1.1.2 - Ensure permissions on /etc/crontab are configured"

# Get permissions and ownership of /etc/crontab
perms=$(stat -c "%a" /etc/crontab)
owner=$(stat -c "%U" /etc/crontab)
group=$(stat -c "%G" /etc/crontab)

# Expected values (modify as needed)
expected_perms="600"  # Permissions should be 600
expected_owner="root" # Owner should be root
expected_group="root" # Group should be root

# Initialize result and additional_output variables
result="Passed"
additional_output=""

# Check permissions
if [ "$perms" != "$expected_perms" ]; then
    result="Failed"
    additional_output="/etc/crontab permissions are not set to $expected_perms ($perms)"
fi

# Check owner
if [ "$owner" != "$expected_owner" ]; then
    result="Failed"
    additional_output="$additional_output, /etc/crontab owner is not root ($owner)"
fi

# Check group
if [ "$group" != "$expected_group" ]; then
    result="Failed"
    additional_output="$additional_output, /etc/crontab group is not root ($group)"
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



# 4.1.1.3 - Ensure permissions on /etc/cron.hourly are configured
title="4.1.1.3 - Ensure permissions on /etc/cron.hourly are configured"

# Get permissions and ownership of /etc/cron.hourly
perms=$(stat -c "%a" /etc/cron.hourly)
owner=$(stat -c "%U" /etc/cron.hourly)
group=$(stat -c "%G" /etc/cron.hourly)

# Expected values (modify as needed)
expected_perms="700"  # Permissions should be 700
expected_owner="root" # Owner should be root
expected_group="root" # Group should be root

# Initialize result and additional_output variables
result="Passed"
additional_output=""

# Check permissions
if [ "$perms" != "$expected_perms" ]; then
    result="Failed"
    additional_output="/etc/cron.hourly permissions are not set to $expected_perms ($perms)"
fi

# Check owner
if [ "$owner" != "$expected_owner" ]; then
    result="Failed"
    additional_output="$additional_output, /etc/cron.hourly owner is not root ($owner)"
fi

# Check group
if [ "$group" != "$expected_group" ]; then
    result="Failed"
    additional_output="$additional_output, /etc/cron.hourly group is not root ($group)"
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


# 4.1.1.4 - Ensure permissions on /etc/cron.daily are configured
title="4.1.1.4 - Ensure permissions on /etc/cron.daily are configured"

# Get permissions and ownership of /etc/cron.daily
perms=$(stat -c "%a" /etc/cron.daily)
owner=$(stat -c "%U" /etc/cron.daily)
group=$(stat -c "%G" /etc/cron.daily)

# Expected values (modify as needed)
expected_perms="700"  # Permissions should be 700
expected_owner="root" # Owner should be root
expected_group="root" # Group should be root

# Initialize result and additional_output variables
result="Passed"
additional_output=""

# Check permissions
if [ "$perms" != "$expected_perms" ]; then
    result="Failed"
    additional_output="/etc/cron.daily permissions are not set to $expected_perms ($perms)"
fi

# Check owner
if [ "$owner" != "$expected_owner" ]; then
    result="Failed"
    additional_output="$additional_output, /etc/cron.daily owner is not root ($owner)"
fi

# Check group
if [ "$group" != "$expected_group" ]; then
    result="Failed"
    additional_output="$additional_output, /etc/cron.daily group is not root ($group)"
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





# 4.1.1.5 - Ensure permissions on /etc/cron.weekly are configured
title="4.1.1.5 - Ensure permissions on /etc/cron.weekly are configured"

# Get permissions and ownership of /etc/cron.weekly
perms=$(stat -c "%a" /etc/cron.weekly)
owner=$(stat -c "%U" /etc/cron.weekly)
group=$(stat -c "%G" /etc/cron.weekly)

# Expected values (modify as needed)
expected_perms="700"  # Permissions should be 700
expected_owner="root" # Owner should be root
expected_group="root" # Group should be root

# Initialize result and additional_output variables
result="Passed"
additional_output=""

# Check permissions
if [ "$perms" != "$expected_perms" ]; then
    result="Failed"
    additional_output="/etc/cron.weekly permissions are not set to $expected_perms ($perms)"
fi

# Check owner
if [ "$owner" != "$expected_owner" ]; then
    result="Failed"
    additional_output="$additional_output, /etc/cron.weekly owner is not root ($owner)"
fi

# Check group
if [ "$group" != "$expected_group" ]; then
    result="Failed"
    additional_output="$additional_output, /etc/cron.weekly group is not root ($group)"
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


# 4.1.1.6 - Ensure permissions on /etc/cron.monthly are configured
title="4.1.1.6 - Ensure permissions on /etc/cron.monthly are configured"

# Get permissions and ownership of /etc/cron.monthly
perms=$(stat -c "%a" /etc/cron.monthly)
owner=$(stat -c "%U" /etc/cron.monthly)
group=$(stat -c "%G" /etc/cron.monthly)

# Expected values (modify as needed)
expected_perms="700"  # Permissions should be 700
expected_owner="root" # Owner should be root
expected_group="root" # Group should be root

# Initialize result and additional_output variables
result="Passed"
additional_output=""

# Check permissions
if [ "$perms" != "$expected_perms" ]; then
    result="Failed"
    additional_output="/etc/cron.monthly permissions are not set to $expected_perms ($perms)"
fi

# Check owner
if [ "$owner" != "$expected_owner" ]; then
    result="Failed"
    additional_output="$additional_output, /etc/cron.monthly owner is not root ($owner)"
fi

# Check group
if [ "$group" != "$expected_group" ]; then
    result="Failed"
    additional_output="$additional_output, /etc/cron.monthly group is not root ($group)"
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


# 4.1.1.7 - Ensure permissions on /etc/cron.d are configured
title="4.1.1.7 - Ensure permissions on /etc/cron.d are configured"

# Get permissions and ownership of /etc/cron.d
perms=$(stat -c "%a" /etc/cron.d)
owner=$(stat -c "%U" /etc/cron.d)
group=$(stat -c "%G" /etc/cron.d)

# Expected values (modify as needed)
expected_perms="700"  # Permissions should be 700
expected_owner="root" # Owner should be root
expected_group="root" # Group should be root

# Initialize result and additional_output variables
result="Passed"
additional_output="Permissions on /etc/cron.d are configured correctly"

# Check permissions
if [ "$perms" != "$expected_perms" ]; then
    result="Failed"
    additional_output="/etc/cron.d permissions are not set to $expected_perms ($perms)"
fi

# Check owner
if [ "$owner" != "$expected_owner" ]; then
    result="Failed"
    additional_output="$additional_output, /etc/cron.d owner is not root ($owner)"
fi

# Check group
if [ "$group" != "$expected_group" ]; then
    result="Failed"
    additional_output="$additional_output, /etc/cron.d group is not root ($group)"
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





# 4.1.1.8 - Ensure crontab is restricted to authorized users
title="4.1.1.8 - Ensure crontab is restricted to authorized users"

# Check if /etc/cron.allow exists and is not empty
if [ -s /etc/cron.allow ]; then
    result="Passed"
    additional_output="/etc/cron.allow exists and contains authorized users"
else
    result="Failed"
    additional_output="/etc/cron.allow does not exist or is empty"
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



title="4.1.2.1 Ensure at is restricted to authorized users (Automated)"

# Expected values (modify as needed)
expected_perms="640"  # Permissions should be 600
expected_owner="root" # Owner should be root
expected_group="root" # Group should be root
expected_group1="daemon" # Group should be root

expected_permsd="640"  # Permissions should be 600
expected_ownerd="root" # Owner should be root
expected_groupd="root" # Group should be root
expected_group1d="daemon" # Group should be root

# Initialize result and additional_output variables
result="Passed"
additional_output=""

if [ -e /etc/at.allow ]; then
    perms=$(stat -c "%a" /etc/at.allow)
    owner=$(stat -c "%U" /etc/at.allow)
    group=$(stat -c "%G" /etc/at.allow)
    
    # Check permissions
    if [ "$perms" != "$expected_perms" ]; then
        result="Failed"
        additional_output="/etc/at.allow permissions are not set to $expected_perms ($perms)"
    fi
    
    # Check owner
    if [ "$owner" != "$expected_owner" ]; then
        result="Failed"
        additional_output="$additional_output, /etc/at.allow owner is not root ($owner)"
    fi
    
    # Check group
    if [ "$group" != "$expected_group" ] && [ "$group" != "$expected_group1" ]; then
        result="Failed"
        additional_output="$additional_output, /etc/at.allow group is not root or daemon($group)"
    fi
else
    if [ -e /etc/at.deny ]; then
        permsd=$(stat -c "%a" /etc/at.deny)
        ownerd=$(stat -c "%U" /etc/at.deny)
        groupd=$(stat -c "%G" /etc/at.deny)

        # Check permissions
        if [ "$permsd" != "$expected_permsd" ]; then
            result="Failed"
            additional_output=" /etc/at.deny permissions are not set to $expected_perms ($perms)"
        fi

        # Check owner
        if [ "$ownerd" != "$expected_ownerd" ]; then
            result="Failed"
            additional_output="$additional_output, /etc/at.deny owner is not root ($owner)"
        fi

        # Check group
        if [ "$groupd" != "$expected_groupd" ] && [ "$groupd" != "$expected_group1d" ]; then
            result="Failed"
            additional_output="$additional_output, /etc/at.deny group is not root or daemon($group)"
        fi
    else
        result="Failed"
        additional_output="/etc/at.deny does not exist"
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

# # 4.1.1.2 - Ensure permissions on /etc/crontab are configured
# title="4.1.1.2 - Ensure permissions on /etc/crontab are configured"

# # Get permissions and ownership of /etc/crontab
# perms=$(stat -c "%a" /etc/crontab)
# owner=$(stat -c "%U" /etc/crontab)
# group=$(stat -c "%G" /etc/crontab)

# # Expected values (modify as needed)
# expected_perms="600"  # Permissions should be 600
# expected_owner="root" # Owner should be root
# expected_group="root" # Group should be root

# # Initialize result and additional_output variables
# result="Passed"
# additional_output=""

# # Check permissions
# if [ "$perms" != "$expected_perms" ]; then
#     result="Failed"
#     additional_output="/etc/crontab permissions are not set to $expected_perms ($perms)"
# fi

# # Check owner
# if [ "$owner" != "$expected_owner" ]; then
#     result="Failed"
#     additional_output="$additional_output, /etc/crontab owner is not root ($owner)"
# fi

# # Check group
# if [ "$group" != "$expected_group" ]; then
#     result="Failed"
#     additional_output="$additional_output, /etc/crontab group is not root ($group)"
# fi

# # Check if a custom CSV name is provided
# if [ -n "$1" ]; then
#     # Use the custom name if provided
#     csv_filename="$1"
# else
#     # Otherwise, use the timestamp
#     csv_filename="$timestamp"
# fi

# echo "$title,$additional_output,$result" >> "$csv_filename"


# Check group


# title="4.1.2.1 Ensure at is restricted to authorized users (Automated)"
# # Ensure at is restricted to authorized users (Automated)
# perms=$(stat -c "%a" /etc/at.allow)
# owner=$(stat -c "%U" /etc/at.allow)
# group=$(stat -c "%G" /etc/at.allow)

# # Expected values (modify as needed)
# expected_perms="640"  # Permissions should be 600
# expected_owner="root" # Owner should be root
# expected_group="root" # Group should be root
# expected_group1="daemon" # Group should be root

# permsd=$(stat -c "%a" /etc/at.deny)
# ownerd=$(stat -c "%U" /etc/at.deny)
# groupd=$(stat -c "%G" /etc/at.deny)

# expected_permsd="640"  # Permissions should be 600
# expected_ownerd="root" # Owner should be root
# expected_groupd="root" # Group should be root
# expected_group1d="daemon" # Group should be root

# # Initialize result and additional_output variables
# result="Passed"
# additional_output=""


# if [ -e /etc/at.allow ]; then
#     perms=$(stat -c "%a" /etc/at.allow)
#     owner=$(stat -c "%U" /etc/at.allow)
#     group=$(stat -c "%G" /etc/at.allow)
#     if [ "$perms" != "$expected_perms" ]; then
#     result="Failed"
#     additional_output="/etc/at.allow permissions are not set to $expected_perms ($perms)"
#     fi
#     # Check owner
#     if [ "$owner" != "$expected_owner" ]; then
#         result="Failed"
#         additional_output="$additional_output, /etc/at.allow owner is not root ($owner)"
#     fi

#     if [ "$group" != "$expected_group" ] || [ "$group" != "$expected_group1" ];then
#         result="Failed"
#         additional_output="$additional_output, /etc/at.allow group is not root or daemon($group)"
#     fi
# else
#     [ -e /etc/at.deny ]; then
#     permsd=$(stat -c "%a" /etc/at.deny)
#     ownerd=$(stat -c "%U" /etc/at.deny)
#     groupd=$(stat -c "%G" /etc/at.deny)

#     # Check permissions
#     if [ "$permsd" != "$expected_permsd" ]; then
#         result="Failed"
#         additional_output=" /etc/at.deny permissions are not set to $expected_perms ($perms)"
#     fi

#     # Check owner
#     if [ "$ownerd" != "$expected_ownerd" ]; then
#         result="Failed"
#         additional_output="$additional_output, /etc/at.deny owner is not root ($owner)"
#     fi

#     if  [ "$groupd" != "$expected_groupd" ] || [ "$groupd" != "$expected_group1d" ]; then
#         result="Failed"
#         additional_output="$additional_output, /etc/at.deny group is not root or daemon($group)"
#     fi
# # Check permissions
# if [ "$perms" != "$expected_perms" ] || [ "$permsd" != "$expected_permsd" ]; then
#     result="Failed"
#     additional_output="/etc/at.allow or /etc/at.deny permissions are not set to $expected_perms ($perms)"
# fi

# # Check owner
# if [ "$owner" != "$expected_owner" ] || [ "$ownerd" != "$expected_ownerd" ]; then
#     result="Failed"
#     additional_output="$additional_output, /etc/at.allow or /etc/at.deny owner is not root ($owner)"
# fi

# if { [ "$group" != "$expected_group" ] || [ "$group" != "$expected_group1" ]; } || { [ "$groupd" != "$expected_groupd" ] || [ "$groupd" != "$expected_group1d" ]; }; then
#     result="Failed"
#     additional_output="$additional_output, /etc/at.allow or /etc/at.deny group is not root or daemon($group)"
# fi

# # Check group
# if [ "$group" != [["$expected_group"  || "$expected_group1"]]]|| [ "$groupd" != [["$expected_groupd" ||"$expected_group1d" ]] ]; then
#     result="Failed"
#     additional_output="$additional_output, /etc/at.allow or /etc/at.deny group is not root or daemon($group)"
# fi

# # Check if a custom CSV name is provided
# if [ -n "$1" ]; then
#     # Use the custom name if provided
#     csv_filename="$1"
# else
#     # Otherwise, use the timestamp
#     csv_filename="$timestamp"
# fi

# echo "$title,$additional_output,$result" >> "$csv_filename"







title="4.2.1 - Ensure permissions on /etc/ssh/sshd_config are configured"

l_output=""
l_output2=""
a_sshdfiles=()

# Check /etc/ssh/sshd_config
[ -e "/etc/ssh/sshd_config" ] && a_sshdfiles+=("/etc/ssh/sshd_config^$(stat -Lc '%#a^%U^%G' "/etc/ssh/sshd_config")")

# Check files ending in .conf in /etc/ssh/sshd_config.d
while IFS= read -r -d $'\0' l_file; do
    [ -e "$l_file" ] && a_sshdfiles+=("$l_file^$(stat -Lc '%#a^%U^%G' "$l_file")")
done < <(find /etc/ssh/sshd_config -type f -name '*.conf' -print0)

# Check permissions and ownership
for sshd_file in "${a_sshdfiles[@]}"; do
    IFS="^" read -r l_file l_mode l_user l_group <<< "$sshd_file"
    l_out2=""

    # Check for permissions and ownership issues
    [ $(( $l_mode & 0777 )) -gt 600 ] && l_out2+=" - Incorrect mode: \"$l_mode\" should be: \"0600\" or more restrictive"
    [ "$l_user" != "root" ] && l_out2+=" - Incorrect owner: \"$l_user\" should be owned by \"root\""
    [ "$l_group" != "root" ] && l_out2+=" - Incorrect group owner: \"$l_group\" should be group owned by \"root\""

    if [ -n "$l_out2" ]; then
        l_output2+="- File: \"$l_file\":$l_out2"
    else
        l_output+="- File: \"$l_file\":Correct: mode ($l_mode), owner ($l_user), and group owner ($l_group) configured"
    fi
done

# Display audit results
if [ -z "$l_output2" ]; then
    result="Passed"
    additional_output="Permissions on /etc/ssh/sshd_config are configured correctly"
else
    result="Failed"
    additional_output="Permissions on /etc/ssh/sshd_config are not configured correctly"
    [ -n "$l_output" ] && additional_output="$additional_output Correctly set: $l_output"
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


title="4.2.2 - Ensure permissions on SSH private host key files are configured"

l_output=""
l_output2=""
l_skgn="$(grep -Po -- '^(ssh_keys|_?ssh)\b' /etc/group)" # Group designated to own OpenSSH keys
l_skgid="$(awk -F: '($1 == "'"$l_skgn"'"){print $3}' /etc/group)" # Get gid of the group
[ -n "$l_skgid" ] && l_agroup="(root|$l_skgn)" || l_agroup="root"
unset a_skarr && a_skarr=()

if [ -d /etc/ssh ]; then
    while IFS= read -r -d $'\0' l_file; do
        if grep -Pq ':\h+OpenSSH\h+private\h+key\b' <<< "$(file "$l_file")"; then
            a_skarr+=("$(stat -Lc '%n^%#a^%U^%G^%g' "$l_file")")
        fi
    done < <(find -L /etc/ssh -xdev -type f -print0)

    for ssh_key in "${a_skarr[@]}"; do
        IFS="^" read -r l_file l_mode l_owner l_group l_gid <<< "$ssh_key"
        l_out2=""
        [ "$l_gid" = "$l_skgid" ] && l_pmask="0137" || l_pmask="0177"
        l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )"

        if [ $(( $l_mode & $l_pmask )) -gt 0 ]; then
            l_out2+=" - Mode: \"$l_mode\" should be mode: \"$l_maxperm\" or more restrictive"
        fi
        [ "$l_owner" != "root" ] && l_out2+=" - Owned by: \"$l_owner\" should be owned by \"root\""
        [[ ! "$l_group" =~ $l_agroup ]] && l_out2+=" - Owned by group \"$l_group\" should be group owned by: \"${l_agroup//|/ or }\""

        if [ -n "$l_out2" ]; then
            l_output2+=" - File: \"$l_file\"$l_out2"
        else
            l_output+="- File: \"$l_file\" - Correct: mode ($l_mode), owner ($l_owner), and group owner ($l_group) configured"
        fi
    done
else
    l_output=" - OpenSSH keys not found on the system"
fi

unset a_skarr

if [ -z "$l_output2" ]; then
    result="Passed"
    additional_output="Permissions on SSH private host key files are configured correctly.(Automated)"
else
    result="Failed"
    additional_output="Permissions on SSH private host key files are wrongly configured. (Automated)"
    [ -n "$l_output" ] && additional_output="$additional_output Correctly set: $l_output"
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



title="4.2.3 - Ensure permissions on SSH public host key files are configured"

l_output=""
l_output2=""
l_skgn="$(grep -Po -- '^(ssh_keys|_?ssh)\b' /etc/group)" # Group designated to own OpenSSH public keys
l_skgid="$(awk -F: '($1 == "'"$l_skgn"'"){print $3}' /etc/group)" # Get gid of the group
[ -n "$l_skgid" ] && l_agroup="(root|$l_skgn)" || l_agroup="root"
unset a_skarr && a_skarr=()

if [ -d /etc/ssh ]; then
    while IFS= read -r -d $'\0' l_file; do
        if grep -Pq ':\h+OpenSSH\h+(\H+\h+)public\h+key\b' <<< "$(file "$l_file")"; then
            a_skarr+=("$(stat -Lc '%n^%#a^%U^%G^%g' "$l_file")")
        fi
    done < <(find -L /etc/ssh -xdev -type f -print0)

    for ssh_key in "${a_skarr[@]}"; do
        IFS="^" read -r l_file l_mode l_owner l_group l_gid <<< "$ssh_key"
        l_out2=""
        l_pmask="0133"
        l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )"

        if [ $(( $l_mode & $l_pmask )) -gt 0 ]; then
            l_out2+=" - Mode: \"$l_mode\" should be mode: \"$l_maxperm\" or more restrictive"
        fi
        [ "$l_owner" != "root" ] && l_out2+=" - Owned by: \"$l_owner\" should be owned by \"root\""
        [[ ! "$l_group" =~ $l_agroup ]] && l_out2+=" - Owned by group \"$l_group\" should be group owned by: \"${l_agroup//|/ or }\""

        if [ -n "$l_out2" ]; then
            l_output2+=" - File: \"$l_file\"$l_out2"
        else
            l_output+=" - File: \"$l_file\" - Correct: mode ($l_mode), owner ($l_owner), and group owner ($l_group) configured"
        fi
    done
else
    l_output=" - OpenSSH keys not found on the system"
fi

unset a_skarr

if [ -z "$l_output2" ]; then
    result="Passed"
    additional_output="permissions on SSH public host key files are configured correctly (Automated)"
else
    result="Failed"
    additional_output="permissions on SSH public host key files are configured wrongly (Automated)"
    [ -n "$l_output" ] && additional_output="$additional_output $l_output"
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






title="4.2.4 - Ensure sshd access is configured"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -Pi '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$')
file_output=$(grep -Pis '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf)

if [ "$command_output" = "$file_output" ]; then
    result="Passed"
    additional_output="Configuration matches"
else
    result="Failed"
    additional_output="Configuration mismatch"
    additional_output+="$command_output $file_output"
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






title="4.2.5 - Ensure sshd Banner is configured"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep banner)
expected_output="banner /etc/issue.net"

if [ "$command_output" = "$expected_output" ]; then
    result="Passed"
    additional_output="Configuration matches"
else
    result="Failed"
    additional_output="Configuration mismatch"
    additional_output+="$command_output $expected_output"
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

title="4.2.6 - Ensure sshd Ciphers are configured"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep ciphers)
weak_ciphers=("3des-cbc" "aes128-cbc" "aes192-cbc" "aes256-cbc" "rijndael-cbc@lysator.liu.se")

for cipher in "${weak_ciphers[@]}"; do
    if grep -q "$cipher" <<< "$command_output"; then
        result="Failed"
        additional_output="Weak cipher(s) found: $cipher"
        break
    else
        result="Passed"
        additional_output="No weak ciphers found"
    fi
done

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


title="4.2.7 - Ensure sshd ClientAliveInterval and ClientAliveCountMax are configured"

command_output_interval=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep clientaliveinterval)
command_output_countmax=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep clientalivecountmax)
grep_output_countmax=$(grep -Pis '^\h*ClientAliveCountMax\h+"?0\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf)

if [[ -n "$command_output_interval" && -n "$command_output_countmax" && -z "$grep_output_countmax" ]]; then
    result="Passed"
    additional_output="ClientAliveInterval and ClientAliveCountMax configured correctly"
else
    result="Failed"
    additional_output="Misconfigured ClientAliveInterval or ClientAliveCountMax detected"

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

title="4.2.8 - Ensure sshd DisableForwarding is enabled"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i disableforwarding)
grep_output=$(grep -Pis '^\h*DisableForwarding\h+\"?no\"?\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf)

if [[ "$command_output" == *"disableforwarding yes"* && -z "$grep_output" ]]; then
    result="Passed"
    additional_output="DisableForwarding is correctly enabled"
else
    result="Failed"
    additional_output="DisableForwarding is not correctly enabled"
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





title="4.2.9 - Ensure sshd HostbasedAuthentication is disabled"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i hostbasedauthentication)
grep_output=$(grep -Pis '^\h*HostbasedAuthentication\h+"?yes"?\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf)

if [[ "$command_output" == *"hostbasedauthentication no"* && -z "$grep_output" ]]; then
    result="Passed"
    additional_output="HostbasedAuthentication is correctly disabled"
else
    result="Failed"
    additional_output="HostbasedAuthentication is not correctly disabled"
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





title="4.2.10 - Ensure sshd IgnoreRhosts is enabled"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i ignorerhosts)
grep_output=$(grep -Pis '^\h*ignorerhosts\h+"?no"?\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf)

if [[ "$command_output" == *"ignorerhosts yes"* && -z "$grep_output" ]]; then
    result="Passed"
    additional_output="IgnoreRhosts is correctly enabled"
else
    result="Failed"
    additional_output="IgnoreRhosts is not correctly enabled"
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


title="4.2.11 - Ensure sshd KexAlgorithms is configured"

weak_algorithms=("diffie-hellman-group1-sha1" "diffie-hellman-group14-sha1" "diffie-hellman-group-exchange-sha1")
command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep kexalgorithms)
contains_weak_kex=false

for algorithm in "${weak_algorithms[@]}"; do
    if [[ "$command_output" == *"$algorithm"* ]]; then
        contains_weak_kex=true
        break
    fi
done

if [ "$contains_weak_kex" = false ]; then
    result="Passed"
    additional_output="KexAlgorithms is configured securely"
else
    result="Failed"
    additional_output="KexAlgorithms contains weak algorithms"
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



title="4.2.12 - Ensure sshd LoginGraceTime is configured"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep logingracetime)

if [[ "$command_output" =~ logingracetime\ ([1-9]|[1-5][0-9]|60) ]]; then
    result="Passed"
    additional_output="LoginGraceTime is configured within acceptable limits"
else
    result="Failed"
    additional_output="LoginGraceTime is not configured within acceptable limits"
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


title="4.2.13 - Ensure sshd LogLevel is configured"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep loglevel)

if [[ "$command_output" =~ loglevel\ (VERBOSE|INFO) ]]; then
    result="Passed"
    additional_output="LogLevel is configured as VERBOSE or INFO"
else
    result="Failed"
    additional_output="LogLevel is not configured as VERBOSE or INFO"
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

title="4.2.14 - Ensure sshd MACs are configured"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i "MACs")

weak_macs=("hmac-md5" "hmac-md5-96" "hmac-ripemd160" "hmac-sha1-96" "umac-64@openssh.com" "hmac-md5-etm@openssh.com" "hmac-md5-96-etm@openssh.com" "hmac-ripemd160-etm@openssh.com" "hmac-sha1-96-etm@openssh.com" "umac-64-etm@openssh.com")

has_weak_macs=false

for mac in "${weak_macs[@]}"; do
    if [[ "$command_output" == *"$mac"* ]]; then
        has_weak_macs=true
        break
    fi
done

if [ "$has_weak_macs" = true ]; then
    result="Failed"
    additional_output="Weak MAC algorithms found in configuration"
else
    result="Passed"
    additional_output="No weak MAC algorithms found in configuration"
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



title="4.2.15 - Ensure sshd MaxAuthTries is configured"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep maxauthtries)

max_tries=$(echo "$command_output" | awk '{print $2}')

if [[ $max_tries -le 4 ]]; then
    result="Passed"
    additional_output="MaxAuthTries is $max_tries or less"
else
    result="Failed"
    additional_output="MaxAuthTries is greater than 4"
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



title="4.2.16 - Ensure sshd MaxSessions is configured"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i maxsessions)

max_sessions=$(echo "$command_output" | awk '{print $2}')

if [[ $max_sessions -le 10 ]]; then
    result="Passed"
    additional_output="MaxSessions is $max_sessions or less"
else
    result="Failed"
    additional_output="MaxSessions is greater than 10"
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


title="4.2.17 - Ensure sshd MaxStartups is configured"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i maxstartups)

max_startups=$(echo "$command_output" | awk '{print $2}')

if [[ $max_startups == "10:30:60" ]]; then
    result="Passed"
    additional_output="MaxStartups is configured as 10:30:60"
else
    result="Failed"
    additional_output="MaxStartups is not configured as 10:30:60"
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


title="4.2.18 - Ensure sshd PermitEmptyPasswords is disabled"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permitemptypasswords)

permit_empty_passwords=$(echo "$command_output" | awk '{print $2}')

if [[ $permit_empty_passwords == "no" ]]; then
    result="Passed"
    additional_output="PermitEmptyPasswords is disabled"
else
    result="Failed"
    additional_output="PermitEmptyPasswords is not disabled"
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


title="4.2.19 - Ensure sshd PermitRootLogin is disabled"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permitrootlogin)

permit_root_login=$(echo "$command_output" | awk '{print $2}')

if [[ $permit_root_login == "no" ]]; then
    result="Passed"
    additional_output="PermitRootLogin is disabled"
else
    result="Failed"
    additional_output="PermitRootLogin is not disabled"
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



title="4.2.20 - Ensure sshd PermitUserEnvironment is disabled"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permituserenvironment)

permit_user_env=$(echo "$command_output" | awk '{print $2}')

if [[ $permit_user_env == "no" ]]; then
    result="Passed"
    additional_output="PermitUserEnvironment is disabled"
else
    result="Failed"
    additional_output="PermitUserEnvironment is not disabled"
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




title="4.2.21 - Ensure sshd UsePAM is enabled"

command_output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i usepam)

use_pam=$(echo "$command_output" | awk '{print $2}')

if [[ $use_pam == "yes" ]]; then
    result="Passed"
    additional_output="UsePAM is enabled"
else
    result="Failed"
    additional_output="UsePAM is not enabled"
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


title="4.2.22 - Ensure sshd crypto_policy is not set"

crypto_policy=$(grep -Pi '^\h*CRYPTO_POLICY\h*=' /etc/sysconfig/sshd)

if [[ -z "$crypto_policy" ]]; then
    result="Passed"
    additional_output="crypto_policy is not set"
else
    result="Failed"
    additional_output="crypto_policy is set"
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


title="4.3.1 - Ensure sudo is installed"

sudo_package=$(dnf list installed | grep -i "^sudo")

if [[ -n "$sudo_package" ]]; then
    result="Passed"
    additional_output="sudo is installed"
else
    result="Failed"
    additional_output="sudo is not installed"
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


title="4.3.2 - Ensure sudo commands use pty"

sudo_use_pty=$(grep -rPi '^\h*Defaults\h+([^#\n\r]+,)?use_pty(,\h*\h+\h*)*\h*(#.*)?$' /etc/sudoers*)

if [[ -n "$sudo_use_pty" ]]; then
    result="Passed"
    additional_output="sudo commands use pty"
else
    result="Failed"
    additional_output="sudo commands do not use pty"
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


title="4.3.3 - Ensure sudo log file exists"

sudo_log_file=$(grep -rPsi '^\h*Defaults\h+\([^#]\+,\h*\)\?logfile\h*=\h*\(\"\|\'\)\?\H\+\(\"\|\'\)\?\(,\h*\H\+\h*\)*\h*\(#\)\?.*$"" /etc/sudoers*)

if [[ -n "$sudo_log_file" ]]; then
    result="Passed"
    additional_output="sudo log file exists"
else
    result="Failed"
    additional_output="sudo log file does not exist"
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




title="4.3.4 - Ensure users must provide password for escalation"

sudo_password=$(grep -r "^[^#].*NOPASSWD" /etc/sudoers* 2>/dev/null)

if [[ -n "$sudo_password" ]]; then
    result="Failed"
    additional_output="Users are allowed to escalate without password"
else
    result="Passed"
    additional_output="Users must provide a password for escalation"
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


title="4.3.5 - Ensure re-authentication for privilege escalation is not disabled globally"

sudo_reauth=$(grep -r "^[^#].*\!authenticate" /etc/sudoers* 2>/dev/null)

if [[ -n "$sudo_reauth" ]]; then
    result="Failed"
    additional_output="Re-authentication for privilege escalation is disabled globally"
else
    result="Passed"
    additional_output="Re-authentication for privilege escalation is not disabled globally"
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


title="4.3.6 - Ensure sudo authentication timeout is configured correctly"

timeout=$(grep -roP "timestamp_timeout=\K[0-9]*" /etc/sudoers*)
sudo_default_timeout=$(sudo -V | grep "Authentication timestamp timeout:")

if [[ -z "$timeout" ]]; then
        result="Passed"
        additional_output="Sudo authentication timeout is configured correctly"
elif [[ "$sudo_default_timeout" -le 900 ]]; then
    result="Passed"
    additional_output="Sudo authentication timeout is configured correctly"
else
    result="Failed"
    additional_output="Sudo authentication timeout is greater than 15 minutes"
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



title="4.3.7 - Ensure access to the su command is restricted"

su_auth=$(grep -Pi '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su)

if [[ -n "$su_auth" ]]; then
    group_name=$(echo "$su_auth" | grep -oP 'group=\K\S+')

    if grep -q "^$group_name:" /etc/group && [ -z "$(grep "^$group_name:" /etc/group | cut -d: -f4-)" ]; then
        result="Passed"
        additional_output="Access to the su command is restricted"
    else
        result="Failed"
        additional_output="Group specified in pam_wheel.so configuration for su does not exist or contains users"
    fi
else
    result="Failed"
    additional_output="Configuration for restricting su command access not found or not as expected"
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



title="4.4.1.1 - Ensure latest version of PAM is installed"

pam_version=$(rpm -q pam)

if [[ -n "$pam_version" ]]; then
    result="Passed"
    additional_output="Latest PAM version installed: $pam_version"
else
    result="Failed"
    additional_output="PAM is not installed or version information is not available"
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



title="4.4.1.2 - Ensure latest version of authselect is installed"

authselect_version=$(rpm -q authselect)

if [[ -n "$authselect_version" ]]; then
    result="Passed"
    additional_output="Latest authselect version installed: $authselect_version"
else
    result="Failed"
    additional_output="authselect is not installed or version information is not available"
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






title="4.4.2.1 - Ensure active authselect profile includes PAM modules"

profile=$(head -1 /etc/authselect/authselect.conf)

modules=("pam_pwquality.so" "pam_pwhistory.so" "pam_faillock.so" "pam_unix.so")

found_missing=0

for module in "${modules[@]}"; do
    if ! grep -q "\b$module\b" "/etc/authselect/$profile/system-auth" || ! grep -q "\b$module\b" "/etc/authselect/$profile/password-auth"; then
        result="Failed"
        additional_output="$module is missing in the active authselect profile"
        found_missing=1
        break
    fi
done

if [[ $found_missing -eq 0 ]]; then
    result="Passed"
    additional_output="All required PAM modules found in the active authselect profile"
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





title="4.4.2.2 - Ensure pam_faillock module is enabled"

if grep -qP -- '\bpam_faillock\.so\b' /etc/pam.d/{password,system}-auth; then
    result="Passed"
    additional_output="pam_faillock module is enabled"
else
    result="Failed"
    additional_output="pam_faillock module is not enabled"
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



title="4.4.2.3 - Ensure pam_pwquality module is enabled"

if grep -qP -- '\bpam_pwquality\.so\b' /etc/pam.d/{password,system}-auth; then
    result="Passed"
    additional_output="pam_pwquality module is enabled" 
else
    result="Failed"
    additional_output="pam_pwquality module is not enabled"
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






title="4.4.2.4 - Ensure pam_pwhistory module is enabled"

if grep -qP -- '\bpam_pwhistory\.so\b' /etc/pam.d/{password,system}-auth; then
    result="Passed"
    additional_output="pam_pwhistory module is enabled"
else
    result="Failed"
    additional_output="pam_pwhistory module is not enabled" 
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


title="4.4.2.5 - Ensure pam_unix module is enabled"

if grep -qP -- '\bpam_unix\.so\b' /etc/pam.d/{password,system}-auth; then
    result="Passed"
    additional_output="pam_unix module is enabled" 
else
    result="Failed"
    additional_output="pam_unix module is not enabled"
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



title="4.4.3.1.1 - Ensure password failed attempts lockout is configured"

if grep -qPi -- '^\h*deny\h*=\h*[1-5]\b' /etc/security/faillock.conf &&
    grep -qPi -- '^\h*auth\h+(requisite|required|sufficient)\h+pam_faillock\.so\h+([^#\n\r]+\h+)?deny\h*=\h*(0|[6-9]|[1-9][0-9]+)\b' /etc/pam.d/system-auth /etc/pam.d/password-auth; then
    result="Passed"
    additional_output="All conditions for password failed attempts lockout are properly configured"
else
    result="Failed"
    additional_output="One or more conditions for password failed attempts lockout are not properly configured"
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





title="4.4.3.1.2 - Ensure password unlock time is configured"

if grep -qPi -- '^\h*unlock_time\h*=\h*(0|9[0-9][0-9]|[1-9][0-9]{3,})\b' /etc/security/faillock.conf &&
    grep -qPi -- '^\h*auth\h+(requisite|required|sufficient)\h+pam_faillock\.so\h+([^#\n\r]+\h+)?unlock_time\h*=\h*([1-9]|[1-9][0-9]|[1-8][0-9][0-9])\b' /etc/pam.d/system-auth /etc/pam.d/password-auth; then
    result="Passed"
    additional_output="All conditions for password unlock time are properly configured"
else
    result="Failed"
    additional_output="One or more conditions for password unlock time are not properly configured"
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


title="4.4.3.1.3 - Ensure password failed attempts lockout includes root account"

if grep -qPi -- '^\h*(even_deny_root|root_unlock_time\h*=\h*\d+)\b' /etc/security/faillock.conf; then
    result="Passed"
    additional_output="Root account lockout configurations exist"
else
    result="Failed"
    additional_output="Root account lockout configurations not found"
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






title="4.4.3.2.1 - Ensure password number of changed characters is configured"

pwquality_conf=$(grep -Psi -- '^\h*difok\h*=\h*([2-9]|[1-9][0-9]+)\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf)

if [[ -n "$pwquality_conf" ]]; then
    result="Passed"
    additional_output="difok is set to 2 or more in pwquality.conf"
else
    result="Failed"
    additional_output="difok is not configured or set to less than 2 in pwquality.conf"
fi

if grep -qPsi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?difok\h*=\h*([0-1])\b' /etc/pam.d/system-auth /etc/pam.d/password-auth; then
    result="Failed"
    additional_output="difok is set to 0 or 1 in pam_pwquality.so"
else
    result="Passed"
    additional_output="difok is properly configured in pam_pwquality.so"
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



title="4.4.3.2.2 - Ensure password length is configured"

pwquality_minlen=$(grep -Psi -- '^\h*minlen\h*=\h*(1[4-9]|[2-9][0-9]|[1-9][0-9]{2,})\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf)

if [[ -n "$pwquality_minlen" ]]; then
    result="Passed"
    additional_output="minlen is set to 14 or more characters in pwquality.conf"
else
    result="Failed"
    additional_output="minlen is not configured or set to less than 14 characters in pwquality.conf"
fi

if grep -qPsi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?minlen\h*=\h*([0-9]|1[0-3])\b' /etc/pam.d/system-auth /etc/pam.d/password-auth; then
    result="Failed"
    additional_output="minlen is set to 0 to 13 characters in pam_pwquality.so"
else
    result="Passed"
    additional_output="minlen is properly configured in pam_pwquality.so"
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



title="4.4.3.2.3 - Ensure password complexity is configured"

pwquality_complexity=$(grep -Psi -- '^\h*(minclass|[dulo]credit)\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf)

if [[ -n "$pwquality_complexity" ]]; then
    result="Passed"
    additional_output="Password complexity configured in pwquality.conf"
else
    result="Failed"
    additional_output="Password complexity not configured in pwquality.conf"
fi

if grep -qPsi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?(minclass=[0-3]|[dulo]credit=[^-]\d*)\b' /etc/pam.d/system-auth /etc/pam.d/password-auth; then
    result="Failed"
    additional_output="Password complexity misconfigured in pam_pwquality.so"
else
    result="Passed"
    additional_output="Password complexity properly configured in pam_pwquality.so"
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




title="4.4.3.2.4 - Ensure password same consecutive characters is configured"

pwquality_maxrepeat=$(grep -Psi -- '^\h*maxrepeat\h*=\h*[1-3]\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf)

if [[ -n "$pwquality_maxrepeat" ]]; then
    result="Passed"
    additional_output="Password same consecutive characters configured in pwquality.conf"
else
    result="Failed"
    additional_output="Password same consecutive characters not configured in pwquality.conf"
fi

if grep -qPsi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?maxrepeat\h*=\h*(0|[4-9]|[1-9][0-9]+)\b' /etc/pam.d/system-auth /etc/pam.d/password-auth; then
    result="Failed"
    additional_output="Password same consecutive characters misconfigured in pam_pwquality.so"
else
    result="Passed"
    additional_output="Password same consecutive characters properly configured in pam_pwquality.so"
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

title="4.4.3.2.5 - Ensure password maximum sequential characters is configured"

pwquality_maxsequence=$(grep -Psi -- '^\h*maxsequence\h*=\h*[1-3]\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf)

if [[ -n "$pwquality_maxsequence" ]]; then
    result="Passed"
    additional_output="Password maximum sequential characters configured in pwquality.conf"
else
    result="Failed"
    additional_output="Password maximum sequential characters not configured in pwquality.conf"
fi

if grep -qPsi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?maxsequence\h*=\h*(0|[4-9]|[1-9][0-9]+)\b' /etc/pam.d/system-auth /etc/pam.d/password-auth; then
    result="Failed"
    additional_output="Password maximum sequential characters misconfigured in pam_pwquality.so"
else
    result="Passed"
    additional_output="Password maximum sequential characters properly configured in pam_pwquality.so"
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


title="4.4.3.2.6 - Ensure password dictionary check is enabled"

pwquality_dictcheck=$(grep -Psi -- '^\h*dictcheck\h*=\h*0\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf)

if [[ -n "$pwquality_dictcheck" ]]; then
    result="Failed"
    additional_output="Password dictionary check is disabled in pwquality configuration"
else
    result="Passed"
    additional_output="Password dictionary check is enabled in pwquality configuration"
fi

if grep -qpsi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?dictcheck\h*=\h*0\b' /etc/pam.d/system-auth /etc/pam.d/password-auth; then
    result="Failed"
    additional_output="Password dictionary check is disabled in PAM configuration"
else
    result="Passed"
    additional_output="Password dictionary check is enabled in PAM configuration"
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








title="4.4.3.2.7 - Ensure password quality is enforced for the root user"

pwquality_root_enforce=$(grep -Psi -- '^\h*enforce_for_root\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf)

if [[ -z "$pwquality_root_enforce" ]]; then
    result="Failed"
    additional_output="Password quality enforcement for root user is not enabled"
else
    result="Passed"
    additional_output="Password quality enforcement for root user is enabled"
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


title="4.4.3.3.1 - Ensure password history remember is configured"

remember_pwhistory_conf=$(grep -Pi -- '^\h*remember\h*=\h*(2[4-9]|[3-9][0-9]|[1-9][0-9]{2,})\b' /etc/security/pwhistory.conf)

if [[ -z "$remember_pwhistory_conf" ]]; then
    result="Failed"
    additional_output="Password history remember is not configured correctly in /etc/security/pwhistory.conf"
else
    result="Passed"
    additional_output="Password history remember is configured correctly in /etc/security/pwhistory.conf"
fi

if grep -Pi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwhistory\.so\h+([^#\n\r]+\h+)?remember=(2[0-3]|1[0-9]|[0-9])\b' /etc/pam.d/system-auth /etc/pam.d/password-auth; then
    result="Failed"
    additional_output="Password history remember is not configured correctly in PAM modules"
else
    result="Passed"
    additional_output="Password history remember is properly configured in PAM modules"
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








title="4.4.3.3.2 - Ensure password history is enforced for the root user"

enforce_for_root=$(grep -Pi -- '^\h*enforce_for_root\b' /etc/security/pwhistory.conf)

result="Passed"
additional_output="Password history enforcement is configured correctly"

if [[ -z "$enforce_for_root" ]]; then
    result="Failed"
    additional_output="Password history enforcement for root user is not configured in /etc/security/pwhistory.conf"
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





title="4.4.3.3.3 - Ensure pam_pwhistory includes use_authtok"

password_auth=$(grep -P -- '^\h*password\h+([^#\n\r]+)\h+pam_pwhistory\.so\h+([^#\n\r]+\h+)?use_authtok\b' /etc/pam.d/password-auth)
system_auth=$(grep -P -- '^\h*password\h+([^#\n\r]+)\h+pam_pwhistory\.so\h+([^#\n\r]+\h+)?use_authtok\b' /etc/pam.d/system-auth)

result="Passed"
additional_output="pam_pwhistory includes use_authtok in password and system auth"

if [[ -z "$password_auth" || -z "$system_auth" ]]; then
    result="Failed"
    additional_output="pam_pwhistory does not include use_authtok in password or system auth"
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

title="4.4.3.4.1 - Ensure pam_unix does not include nullok"

password_auth=$(grep -P -- '^\h*(auth|account|password|session)\h+(requisite|required|sufficient)\h+pam_unix\.so\b' /etc/pam.d/password-auth | grep -Pv -- '\bnullok\b')
system_auth=$(grep -P -- '^\h*(auth|account|password|session)\h+(requisite|required|sufficient)\h+pam_unix\.so\b' /etc/pam.d/system-auth | grep -Pv -- '\bnullok\b')

result="Passed"
additional_output="pam_unix does not include nullok in password and system auth"

if [[ -z "$password_auth" || -z "$system_auth" ]]; then
    result="Failed"
    additional_output="pam_unix includes nullok in password or system auth"
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



title="4.4.3.4.2 - Ensure pam_unix does not include remember"

password_auth=$(grep -Pi '^\h*password\h+([^#\n\r]+\h+)?pam_unix\.so\b' /etc/pam.d/password-auth | grep -Pv '\bremember=\d\b')
system_auth=$(grep -Pi '^\h*password\h+([^#\n\r]+\h+)?pam_unix\.so\b' /etc/pam.d/system-auth | grep -Pv '\bremember=\d\b')

result="Passed"
additional_output="pam_unix does not include remember in password and system auth"

if [[ -z "$password_auth" || -z "$system_auth" ]]; then
    result="Failed"
    additional_output="pam_unix includes remember in password or system auth"
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


title="4.4.3.4.3 - Ensure pam_unix includes a strong password hashing algorithm"

password_auth=$(awk '/^\s*password\s+.*\s+pam_unix\.so\s.*\s+(sha512|yescrypt)\s*$/i' /etc/pam.d/password-auth)
system_auth=$(awk '/^\s*password\s+.*\s+pam_unix\.so\s.*\s+(sha512|yescrypt)\s*$/i' /etc/pam.d/system-auth)

result="Passed"
additional_output="pam_unix includes a strong password hashing algorithm in password and system auth"

if [[ -z "$password_auth" || -z "$system_auth" ]]; then
    result="Failed"
    additional_output="pam_unix does not include a strong password hashing algorithm in password or system auth"
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

title="4.4.3.4.4 - Ensure pam_unix includes use_authtok"

password_auth=$(grep -P '^\h*password\h+([^#\n\r]+)\h+pam_unix\.so\h+([^#\n\r]+\h+)?use_authtok\b' /etc/pam.d/password-auth)
system_auth=$(grep -P '^\h*password\h+([^#\n\r]+)\h+pam_unix\.so\h+([^#\n\r]+\h+)?use_authtok\b' /etc/pam.d/system-auth)

result="Passed"
additional_output="pam_unix includes use_authtok in password and system auth"

if [[ -z "$password_auth" || -z "$system_auth" ]]; then
    result="Failed"
    additional_output="pam_unix does not include use_authtok in password or system auth"
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



title="4.5.1.1 - Ensure strong password hashing algorithm is configured"
libuser_conf=$(grep -Pi -- '^\h*crypt_style\h*=\h*(sha512|yescrypt)\b' /etc/libuser.conf)
login_defs=$(grep -Pi -- '^\h*ENCRYPT_METHOD\h+(SHA512|yescrypt)\b' /etc/login.defs)

if [[ -n "$libuser_conf" && -n "$login_defs" ]]; then
    result="Passed"
    additional_output="Strong password hashing algorithm (sha512 or yescrypt) is configured in libuser.conf and login.defs"
else
    result="Failed"
    additional_output="Strong password hashing algorithm (sha512 or yescrypt) is not configured in libuser.conf or login.defs"
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


title="4.5.1.2 - Ensure password expiration is 365 days or less"
login_defs=$(grep -E '^\s*PASS_MAX_DAYS\s+365' /etc/login.defs)
users=$(grep -E '^[^:]+:[^!*]' /etc/shadow | cut -d: -f1,5)

if [[ -n "$login_defs" ]]; then
    result="Passed"
    additional_output="Password expiration is set to 365 days or less in login.defs"
else
    result="Failed"
    additional_output="Password expiration is not set to 365 days or less in login.defs"
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


title="4.5.1.3 - Ensure password expiration warning days is 7 or more"
login_defs=$(grep -E '^\s*PASS_WARN_AGE\s+7' /etc/login.defs)
users=$(awk -F: '/^[^:\n\r]+:[^!\*xX\n\r]/ {print $1 ":" $6}' /etc/shadow)

if [[ -n "$login_defs" ]]; then
    result="Passed"
    additional_output="Password expiration warning is set to 7 or more days in login.defs"
else
    result="Failed"
    additional_output="Password expiration warning is not set to 7 or more days in login.defs"
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


title="4.5.1.4 - Ensure inactive password lock is 30 days or less"
inactive_setting=$(useradd -D | grep INACTIVE | awk -F= '{print $2}')
users=$(awk -F: '/^[^#:]+:[^!*:]*:[^:]*:[^:]*:[^:]*:[^:]*:(\s*|-1|3[1-9]|[4-9][0-9]|[1-9][0-9][0-9]+):[^:]*:[^:]*\s*$/ {print $1":"$7}' /etc/shadow)

if [[ "$inactive_setting" -le 30 ]]; then
    result="Passed"
    additional_output="Inactive password lock is set to 30 days or less"
else
    result="Failed"
    additional_output="Inactive password lock is set to more than 30 days"
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


title="4.5.1.5 - Ensure all users last password change date is in the past"

while IFS= read -r l_user; do
    l_change=$(date -d "$(chage --list "$l_user" | grep '^Last password change' | cut -d: -f2 | grep -v 'never$')" +%s)
    if [[ "$l_change" -gt "$(date +%s)" ]]; then
        echo "User: \"$l_user\" last password change was \"$(chage --list "$l_user" | grep '^Last password change' | cut -d: -f2)\""
    fi
done < <(awk -F: '/^[^:\n\r]+:[^!*xX\n\r]/{print $1}' /etc/shadow)

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


title="4.5.2.1 - Ensure default group for the root account is GID 0"
root_group=$(awk -F: '$1=="root"{print $1":"$4}' /etc/passwd)

if [[ "$root_group" == "root:0" ]]; then
    result="Passed"
    additional_output="Default group for the root account is GID 0"
else
    result="Failed"
    additional_output="Default group for the root account is not GID 0"
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

title="4.5.2.2 - Ensure root user umask is configured"

umask_config=$(grep -Psi -- '^\h*umask\h+(([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b)|([0-7][01][0-7]\b|[0-7][0-7][0-6]\b)|(u=[rwx]{1,3},)?(((g=[rx]?[rx]?w[rx]?[rx]?\b)(,o=[rwx]{1,3})?)|((g=[wrx]{1,3},)?o=[wrx]{1,3}\b)))' /root/.bash_profile /root/.bashrc)

if [[ -z "$umask_config" ]]; then
    result="Passed"
    additional_output="Root user umask is properly configured"
else
    result="Failed"
    additional_output="Root user umask is not properly configured"
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



title="4.5.2.3 - Ensure system accounts are secured"

system_accounts=$(awk -F: '($1!~/^(root|halt|sync|shutdown|nfsnobody)$/ && ($3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' || $3 == 65534) && $7!~/^(\/usr)?\/sbin\/nologin$/) { print $1 }' /etc/passwd)

disabled_accounts=$(awk -F: '/nologin/ {print $1}' /etc/passwd | xargs -I '{}' passwd -S '{}' | awk '($2!="L" && $2!="LK") {print $1}')

if [[ -z "$system_accounts" && -z "$disabled_accounts" ]]; then
    result="Passed"
    additional_output="System accounts are properly secured"
else
    result="Failed"
    additional_output="System accounts are not properly secured"
    additional_output+="\nSystem Accounts without nologin or with non-disabled passwords: $system_accounts"
    additional_output+="\nAccounts with nologin but passwords not disabled: $disabled_accounts"
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

title="4.5.2.4 - Ensure root password is set"

root_password_status=$(passwd -S root)

if echo "$root_password_status" | grep -q "Password set"; then
    result="Passed"
    additional_output="Root password is set"
else
    result="Failed"
    additional_output="Root password is not set"
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

title="4.5.3.1 - Ensure nologin is not listed in /etc/shells"

if grep -q '/nologin\b' /etc/shells; then
    result="Failed"
    additional_output="'nologin' is listed in /etc/shells"
else
    result="Passed"
    additional_output="'nologin' is not listed in /etc/shells"
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




title="4.5.3.2 - Ensure default user shell timeout is configured"

{
    output1="" output2=""
    [ -f /etc/bashrc ] && BRC="/etc/bashrc"
    for f in "$BRC" /etc/profile /etc/profile.d/*.sh ; do
        grep -Pq '^\s*([^#]+\s+)?TMOUT=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9])\b' "$f" &&
        grep -Pq '^\s*([^#]+;\s*)?readonly\s+TMOUT(\s+|\s*;|\s*$|=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9]))\b' "$f" &&
        grep -Pq '^\s*([^#]+;\s*)?export\s+TMOUT(\s+|\s*;|\s*$|=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9]))\b' "$f" &&
        output1="$f"
    done
    grep -Pq '^\s*([^#]+\s+)?TMOUT=(9[0-9][1-9]|9[1-9][0-9]|0+|[1-9]\d{3,})\b' /etc/profile /etc/profile.d/*.sh "$BRC" &&
    output2=$(grep -Ps '^\s*([^#]+\s+)?TMOUT=(9[0-9][1-9]|9[1-9][0-9]|0+|[1-9]\d{3,})\b' /etc/profile /etc/profile.d/*.sh "$BRC")

    if [ -n "$output1" ] && [ -z "$output2" ]; then
        result="Passed"
        additional_output="TMOUT is configured in: \"$output1\""
    else
        [ -z "$output1" ] && additional_output="TMOUT is not configured"
        [ -n "$output2" ] && additional_output="TMOUT is incorrectly configured in: \"$output2\""
        result="Failed"
    fi
}

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


title="4.5.3.3 - Ensure default user umask is configured"

l_output=""
l_output1=""
l_output2=""

file_umask_chk() {
    if grep -Psiq -- '^\h*umask\h+(0?[0-7][2-7]7|u(=[rwx]{0,3}),g=([rx]{0,2}),o=)(\h*#.*)?$' "$l_file"; then
        l_output="$l_output umask is set correctly in \"$l_file\""
    elif grep -Psiq -- '^\h*umask\h+(([0-7][0-7][01][0-7]\b|[0-7][0-7][0-6]\b)|([0-7][01][0-7]\b|[0-7][0-7][0-6]\b)|(u=[rwx]{1,3},)?(((g=[rx]?[rx]?w[rx]?[rx]?\b)(,o=[rwx]{1,3})?)|((g=[wrx]{1,3},)?o=[wrx]{1,3}\b)))' "$l_file"; then
        l_output2="$l_output2 umask is incorrectly set in \"$l_file\""
    fi
}

while IFS= read -r -d $'\0' l_file; do
    file_umask_chk
done < <(find /etc/profile.d/ -type f -name '*.sh' -print0)

l_file="/etc/profile" && file_umask_chk
l_file="/etc/bashrc" && file_umask_chk
l_file="/etc/bash.bashrc" && file_umask_chk

l_file="/etc/pam.d/postlogin"
if grep -Psiq -- '^\h*session\h+[^#\n\r]+\h+pam_umask\.so\h+([^#\n\r]+\h+)?umask=(0?[0-7][2-7]7)\b' "$l_file"; then
    l_output1="$l_output1 umask is set correctly in \"$l_file\""
elif grep -Psiq '^\h*session\h+[^#\n\r]+\h+pam_umask\.so\h+([^#\n\r]+\h+)?umask=(([0-7][0-7][01][0-7]\b|[0-7][0-7][0-6]\b)|([0-7][01][0-7]\b))' "$l_file"; then
    l_output2="$l_output2 umask is incorrectly set in \"$l_file\""
fi

l_file="/etc/login.defs" && file_umask_chk
l_file="/etc/default/login" && file_umask_chk

[[ -z "$l_output" && -z "$l_output2" ]] && l_output2="$l_output2\n - umask is not set"

if [ -z "$l_output2" ]; then
    result="Passed"
    additional_output="Correctly configured: $l_output"
else
    result="Failed"
    additional_output="$l_output2"
    [ -n "$l_output" ] && additional_output="$additional_output Correctly configured: $l_output"
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

