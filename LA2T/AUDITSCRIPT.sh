#!/bin/bash

timestamp=$(date +"%Y-%m-%d_%H:%M:%S")

# Check if cramfs kernel module is available
l_mname="cramfs"
l_mtype="fs"
title="1.1.1.1 Ensure cramfs kernel module is not available"
l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
l_mpath="/lib/modules/**/kernel/$l_mtype"
l_mpname="$(tr '-' '_' <<< "$l_mname")"
l_mndir="$(tr '-' '/' <<< "$l_mname")"

l_output=""
l_output2=""
l_dl=""

module_loadable_chk() {
    l_loadable="$(modprobe -n -v "$l_mname")"
    [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
    if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
        l_output=" - Not loadable: \"$l_mname\""
    else
        l_output2=" - Loadable: \"$l_mname\""
    fi
}

module_loaded_chk() {
    if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
        l_output=" - Not loaded: \"$l_mname\""
    else
        l_output2=" - Loaded: \"$l_mname\""
    fi
}

module_deny_chk() {
    l_dl="y"
    if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
        l_output=" - Deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
    else
        l_output2=" - Not deny listed"
    fi
}

for l_mdir in $l_mpath; do
    if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
        [ "$l_dl" != "y" ] && module_deny_chk
        if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
        fi
    else
        l_output=" - Doesn't exist in \"$l_mdir\""
    fi
done

if [ -z "$l_output2" ]; then
    additional_output="$l_mname kernel module is not available"
    result="Passed"
else
    additional_output="$l_mname kernel module is available"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


# Check if freevxfs kernel module is available
l_mname="freevxfs"
l_mtype="fs"
title="1.1.1.2 Ensure freevxfs kernel module is not available"
l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
l_mpath="/lib/modules/**/kernel/$l_mtype"
l_mpname="$(tr '-' '_' <<< "$l_mname")"
l_mndir="$(tr '-' '/' <<< "$l_mname")"

l_output=""
l_output2=""
l_dl=""

module_loadable_chk() {
    l_loadable="$(modprobe -n -v "$l_mname")"
    [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
    if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
        l_output=" - Not loadable: \"$l_mname\""
    else
        l_output2=" - Loadable: \"$l_mname\""
    fi
}

module_loaded_chk() {
    if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
        l_output=" - Not loaded: \"$l_mname\""
    else
        l_output2=" - Loaded: \"$l_mname\""
    fi
}

module_deny_chk() {
    l_dl="y"
    if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
        l_output=" - Deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
    else
        l_output2=" - Not deny listed"
    fi
}

for l_mdir in $l_mpath; do
    if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
        [ "$l_dl" != "y" ] && module_deny_chk
        if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
        fi
    else
        l_output=" - Doesn't exist in \"$l_mdir\""
    fi
done

if [ -z "$l_output2" ]; then
    additional_output="$l_mname kernel module is not available"
    result="Passed"
else
    additional_output="$l_output2"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if hfs kernel module is available
l_mname="hfs"
l_mtype="fs"
title="1.1.1.3 Ensure hfs kernel module is not available"
l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
l_mpath="/lib/modules/**/kernel/$l_mtype"
l_mpname="$(tr '-' '_' <<< "$l_mname")"
l_mndir="$(tr '-' '/' <<< "$l_mname")"

l_output=""
l_output2=""
l_dl=""

module_loadable_chk() {
    l_loadable="$(modprobe -n -v "$l_mname")"
    [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
    if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
        l_output=" - Not loadable: \"$l_mname\""
    else
        l_output2=" - Loadable: \"$l_mname\""
    fi
}

module_loaded_chk() {
    if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
        l_output=" - Not loaded: \"$l_mname\""
    else
        l_output2=" - Loaded: \"$l_mname\""
    fi
}

module_deny_chk() {
    l_dl="y"
    if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
        l_output=" - Deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
    else
        l_output2=" - Not deny listed"
    fi
}

for l_mdir in $l_mpath; do
    if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
        [ "$l_dl" != "y" ] && module_deny_chk
        if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
        fi
    else
        l_output=" - Doesn't exist in \"$l_mdir\""
    fi
done

if [ -z "$l_output2" ]; then
    additional_output="$l_mname kernel module is not available"
    result="Passed"
else
    additional_output="$l_mname kernel module is available"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if hfsplus kernel module is available
l_mname="hfsplus"
l_mtype="fs"
title="1.1.1.4 Ensure hfsplus kernel module is not available"
l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
l_mpath="/lib/modules/**/kernel/$l_mtype"
l_mpname="$(tr '-' '_' <<< "$l_mname")"
l_mndir="$(tr '-' '/' <<< "$l_mname")"

l_output=""
l_output2=""
l_dl=""

module_loadable_chk() {
    l_loadable="$(modprobe -n -v "$l_mname")"
    [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
    if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
        l_output=" - Not loadable: \"$l_mname\""
    else
        l_output2=" - Loadable: \"$l_mname\""
    fi
}

module_loaded_chk() {
    if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
        l_output=" - Not loaded: \"$l_mname\""
    else
        l_output2=" - Loaded: \"$l_mname\""
    fi
}

module_deny_chk() {
    l_dl="y"
    if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
        l_output=" - Deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
    else
        l_output2=" - Not deny listed"
    fi
}

for l_mdir in $l_mpath; do
    if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
        [ "$l_dl" != "y" ] && module_deny_chk
        if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
        fi
    else
        l_output=" - Doesn't exist in \"$l_mdir\""
    fi
done

if [ -z "$l_output2" ]; then
    additional_output="$l_mname kernel module is not available"
    result="Passed"
else
    additional_output="$l_mname kernel module is available"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


# Check if jffs2 kernel module is available
l_mname="jffs2"
l_mtype="fs"
title="1.1.1.5 Ensure jffs2 kernel module is not available"
l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
l_mpath="/lib/modules/**/kernel/$l_mtype"
l_mpname="$(tr '-' '_' <<< "$l_mname")"
l_mndir="$(tr '-' '/' <<< "$l_mname")"

l_output=""
l_output2=""
l_dl=""

module_loadable_chk() {
    l_loadable="$(modprobe -n -v "$l_mname")"
    [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
    if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
        l_output=" - Not loadable: \"$l_mname\""
    else
        l_output2=" - Loadable: \"$l_mname\""
    fi
}

module_loaded_chk() {
    if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
        l_output=" - Not loaded: \"$l_mname\""
    else
        l_output2=" - Loaded: \"$l_mname\""
    fi
}

module_deny_chk() {
    l_dl="y"
    if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
        l_output=" - Deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
    else
        l_output2=" - Not deny listed"
    fi
}

for l_mdir in $l_mpath; do
    if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
        [ "$l_dl" != "y" ] && module_deny_chk
        if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
        fi
    else
        l_output=" - Doesn't exist in \"$l_mdir\""
    fi
done

if [ -z "$l_output2" ]; then
    additional_output="$l_mname kernel module is not available"
    result="Passed"
else
    additional_output="$l_mname kernel module is available"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if squashfs kernel module is available
l_mname="squashfs"
l_mtype="fs"
title="1.1.1.6 Ensure squashfs kernel module is not available"
l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
l_mpath="/lib/modules/**/kernel/$l_mtype"
l_mpname="$(tr '-' '_' <<< "$l_mname")"
l_mndir="$(tr '-' '/' <<< "$l_mname")"

l_output=""
l_output2=""
l_dl=""

module_loadable_chk() {
    l_loadable="$(modprobe -n -v "$l_mname")"
    [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
    if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
        l_output=" - Not loadable: \"$l_mname\""
    else
        l_output2=" - Loadable: \"$l_mname\""
    fi
}

module_loaded_chk() {
    if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
        l_output=" - Not loaded: \"$l_mname\""
    else
        l_output2=" - Loaded: \"$l_mname\""
    fi
}

module_deny_chk() {
    l_dl="y"
    if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
        l_output=" - Deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
    else
        l_output2=" - Not deny listed"
    fi
}

for l_mdir in $l_mpath; do
    if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
        [ "$l_dl" != "y" ] && module_deny_chk
        if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
        fi
        else
        l_output=" - Doesn't exist in \"$l_mdir\""
    fi
done

if [ -z "$l_output2" ]; then
    additional_output="$l_mname kernel module is not available"
    result="Passed"
else
    additional_output="$l_mname kernel module is available"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if udf kernel module is available
l_mname="udf"
l_mtype="fs"
title="1.1.1.7 Ensure udf kernel module is not available"
l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
l_mpath="/lib/modules/**/kernel/$l_mtype"
l_mpname="$(tr '-' '_' <<< "$l_mname")"
l_mndir="$(tr '-' '/' <<< "$l_mname")"

l_output=""
l_output2=""
l_dl=""

module_loadable_chk() {
    l_loadable="$(modprobe -n -v "$l_mname")"
    [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
    if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
        l_output=" - Not loadable: \"$l_mname\""
    else
        l_output2=" - Loadable: \"$l_mname\""
    fi
}

module_loaded_chk() {
    if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
        l_output=" - Not loaded: \"$l_mname\""
    else
        l_output2=" - Loaded: \"$l_mname\""
    fi
}

module_deny_chk() {
    l_dl="y"
    if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
        l_output=" - Deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
    else
        l_output2=" - Not deny listed"
    fi
}

for l_mdir in $l_mpath; do
    if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
        [ "$l_dl" != "y" ] && module_deny_chk
        if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
        fi
    else
        l_output=" - Doesn't exist in \"$l_mdir\""
    fi
done

if [ -z "$l_output2" ]; then
    additional_output="$l_mname kernel module is not available"
    result="Passed"
else
    additional_output="$l_mname kernel module is available"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if usb-storage kernel module is available
l_mname="usb-storage"
l_mtype="drivers"
title="1.1.1.8 Ensure usb-storage kernel module is not available"
l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
l_mpath="/lib/modules/**/kernel/$l_mtype"
l_mpname="$(tr '-' '_' <<< "$l_mname")"
l_mndir="$(tr '-' '/' <<< "$l_mname")"

l_output=""
l_output2=""
l_dl=""

module_loadable_chk() {
    l_loadable="$(modprobe -n -v "$l_mname")"
    [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
    if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
        l_output=" - Not loadable: \"$l_mname\""
    else
        l_output2=" - Loadable: \"$l_mname\""
    fi
}

module_loaded_chk() {
    if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
        l_output=" - Not loaded: \"$l_mname\""
    else
        l_output2=" - Loaded: \"$l_mname\""
    fi
}

module_deny_chk() {
    l_dl="y"
    if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
        l_output=" - Deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
    else
        l_output2=" - Not deny listed"
    fi
}

for l_mdir in $l_mpath; do
    if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
        [ "$l_dl" != "y" ] && module_deny_chk
        if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
        fi
    else
        l_output=" - Doesn't exist in \"$l_mdir\""
    fi
done

if [ -z "$l_output2" ]; then
    additional_output="$l_mname kernel module is not available"
    result="Passed"
else
    additional_output="$l_mname kernel module is available"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


#--------------------------------------------------------------------------------------------------------------

# Function to check if a given mount option is set
check_mount_option() {
    mount_option="$1"
    mount_point="$2"
    title="$3"

    # Run findmnt command and grep for the specified mount option
    check=$(findmnt -kn "$mount_point" | grep -v "$mount_option")

    # If nothing is returned, the mount option is set
    if [ -z "$check" ]; then
        additional_output="$mount_option option is set"
        result="Passed"
    else
        additional_output="$mount_option option is not set on $mount_point"
        result="Failed"
    fi

    # Check if a custom CSV name is provided
    if [ -n "$4" ]; then
        # Use the custom name if provided
        csv_filename="$4"
    else
        # Otherwise, use the timestamp
        csv_filename="$timestamp.csv"
    fi

    echo "$title,$additional_output,$result" >> "$csv_filename"
}

# Check if /tmp is a separate partition
tmp_mount=$(findmnt -nk /tmp)
title="1.1.2.1.1 Ensure /tmp is a separate partition"
if [ -n "$tmp_mount" ]; then
    # Check if systemd will mount /tmp at boot time
    systemctl_status=$(systemctl is-enabled tmp.mount)
    if [ "$systemctl_status" == "generated" ]; then
        additional_output="/tmp is a separate partition & will mount at boot time"
        result="Passed"
    else
        additional_output="/tmp is not a separate partition & will not mount at boot time"
        result="Failed"
    fi

    # Check mount options for /tmp partition
    check_mount_option "nodev" "/tmp" "1.1.2.1.2 Ensure nodev option set on /tmp partition"
    check_mount_option "nosuid" "/tmp" "1.1.2.1.3 Ensure nosuid option set on /tmp partition"
    check_mount_option "noexec" "/tmp" "1.1.2.1.4 Ensure noexec option set on /tmp partition"
else
    additional_output="/tmp is not a separate partition"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# # Check if /dev/shm is a separate partition
# shm_mount=$(findmnt -nk /dev/shm)
# title="1.1.2.2.1 Ensure /dev/shm is a separate partition"
# if [ -n "$shm_mount" ]; then
#     additional_output="/dev/shm is a separate partition"
#     result="Passed"

#     # Check mount options for /dev/shm partition
#     check_mount_option "nodev" "/dev/shm" "1.1.2.2.2 Ensure nodev option set on /dev/shm partition"
#     check_mount_option "nosuid" "/dev/shm" "1.1.2.2.3 Ensure nosuid option set on /dev/shm partition"
#      check_mount_option "noexec" "/dev/shm" "1.1.2.2.4 Ensure noexec option set on /dev/shm partition"
# else
#     additional_output="/dev/shm is not a separate partition"
#     result="Failed"
# fi

# # Check if a custom CSV name is provided
# if [ -n "$1" ]; then
#     # Use the custom name if provided
#     csv_filename="$1"
# else
#     # Otherwise, use the timestamp
#     csv_filename="$timestamp.csv"
# fi

# echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if /home is a separate partition
home_mount=$(findmnt -nk /home)
title="1.1.2.3.1 Ensure separate partition exists for /home"
if [ -n "$home_mount" ]; then
    additional_output="/home is a separate partition"
    result="Passed"

    # Check mount options for /home partition
    check_mount_option "nodev" "/home" "1.1.2.3.2 Ensure nodev option set on /home partition"
    check_mount_option "nosuid" "/home" "1.1.2.3.3 Ensure nosuid option set on /home partition"
else
    additional_output="/home is not a separate partition"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if /var is a separate partition
var_mount=$(findmnt -nk /var)
title="1.1.2.4.1 Ensure separate partition exists for /var"
if [ -n "$var_mount" ]; then
    additional_output="/var is a separate partition"
    result="Passed"

    # Check mount options for /var partition
    check_mount_option "nodev" "/var" "1.1.2.4.2 Ensure nodev option set on /var partition"
    check_mount_option "nosuid" "/var" "1.1.2.4.3 Ensure nosuid option set on /var partition"
else
    additional_output="/var is not a separate partition"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if /var/tmp is a separate partition
var_tmp_mount=$(findmnt -nk /var/tmp)
title="1.1.2.5.1 Ensure separate partition exists for /var/tmp"
if [ -n "$var_tmp_mount" ]; then
    additional_output="/var/tmp is a separate partition"
    result="Passed"

    # Check mount options for /var/tmp partition
    check_mount_option "nodev" "/var/tmp" "1.1.2.5.2 Ensure nodev option set on /var/tmp partition"
    check_mount_option "nosuid" "/var/tmp" "1.1.2.5.3 Ensure nosuid option set on /var/tmp partition"
    check_mount_option "noexec" "/var/tmp" "1.1.2.5.4 Ensure noexec option set on /var/tmp partition"
else
    additional_output="/var/tmp is not a separate partition"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if /var/log is a separate partition
var_log_mount=$(findmnt -nk /var/log)
title="1.1.2.6.1 Ensure separate partition exists for /var/log"
if [ -n "$var_log_mount" ]; then
    additional_output="/var/log is a separate partition"
    result="Passed"

    # Check mount options for /var/log partition
    check_mount_option "nodev" "/var/log" "1.1.2.6.2 Ensure nodev option set on /var/log partition"
    check_mount_option "nosuid" "/var/log" "1.1.2.6.3 Ensure nosuid option set on /var/log partition"
    check_mount_option "noexec" "/var/log" "1.1.2.6.4 Ensure noexec option set on /var/log partition"
else
    additional_output="/var/log is not a separate partition"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# Check if /var/log/audit is a separate partition
var_log_audit_mount=$(findmnt -nk /var/log/audit)
title="1.1.2.7.1 Ensure separate partition exists for /var/log/audit"
if [ -n "$var_log_audit_mount" ]; then
    additional_output="/var/log/audit is a separate partition"
    result="Passed"

    # Check mount options for /var/log/audit partition
    check_mount_option "nodev" "/var/log/audit" "1.1.2.7.2 Ensure nodev option set on /var/log/audit partition"
    check_mount_option "nosuid" "/var/log/audit" "1.1.2.7.3 Ensure nosuid option set on /var/log/audit partition"
    check_mount_option "noexec" "/var/log/audit" "1.1.2.7.4 Ensure noexec option set on /var/log/audit partition"
else
    additional_output="/var/log/audit is not a separate partition"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

repo_path="/etc/yum.repos.d/myrepo.repo"
title="1.2.1 Ensure GPG keys are configured"

# Use grep with redirection to suppress stderr
if grep -q gpgkey "${repo_path}" 2>/dev/null; then
    additional_output="GPG keys are configured for all repository"
    result="Passed"
else
    additional_output="GPG keys are not configured for repository ${repo_path}"
    result="Failed"
fi

# Check if a custom CSV name is provided
    if [ -n "$1" ]; then
        # Use the custom name if provided
        csv_filename="$1"
    else
        # Otherwise, use the timestamp
        csv_filename="$timestamp.csv"
    fi

    echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.2.2 Ensure gpgcheck is globally activated"

if grep -q '^gpgcheck=1' /etc/dnf/dnf.conf; then
    additional_output="gpgcheck is globally activated in /etc/dnf/dnf.conf"
    result="Passed"
else
    additional_output="gpgcheck not globally activated in /etc/dnf/dnf.conf"
    result="Failed"
fi

# Check if a custom CSV name is provided
    if [ -n "$1" ]; then
        # Use the custom name if provided
        csv_filename="$1"
    else
        # Otherwise, use the timestamp
        csv_filename="$timestamp.csv"
    fi

    echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.2.3 Ensure repo_gpgcheck is globally activated"

if grep -q '^repo_gpgcheck=1' /etc/dnf/dnf.conf; then
    additional_output="repo_gpgcheck is globally activated in /etc/dnf/dnf.conf"
    result="Passed"
else
    additional_output="repo_gpgcheck not globally activated in /etc/dnf/dnf.conf"
    result="Failed"
fi

# Check if a custom CSV name is provided
    if [ -n "$1" ]; then
        # Use the custom name if provided
        csv_filename="$1"
    else
        # Otherwise, use the timestamp
        csv_filename="$timestamp.csv"
    fi

    echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.2.4 Ensure package manager repositories are configured"

if dnf repolist &>/dev/null; then
    additional_output="Package manager repositories are configured"
    result="Passed"
else
    additional_output="Package manager repositories not configured"
    result="Failed"
fi

# Check if a custom CSV name is provided
    if [ -n "$1" ]; then
        # Use the custom name if provided
        csv_filename="$1"
    else
        # Otherwise, use the timestamp
        csv_filename="$timestamp.csv"
    fi

    echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.2.5 Ensure updates & patches and additional security software"

# Check for updates using dnf check-update
dnf_check_result=$(dnf check-update 2>&1)

# Check if there are no updates available
if [[ "$dnf_check_result" == "0 packages to upgrade." ]]; then
    reboot_required=$(dnf needs-restarting -r)
    if [[ -z "$reboot_required" ]]; then
        additional_output="Updates and patches and additional security software are installed"
        result="Passed"
    else
        additional_output="Updates and patches and additional security software are not installed. Run 'dnf update' to install them."
        result="Failed"
    fi
else
    additional_output="Updates or patches is available. Run 'dnf update' to install them."
    result="Failed"
fi
# Check if a custom CSV name is provided
    if [ -n "$1" ]; then
        # Use the custom name if provided
        csv_filename="$1"
    else
        # Otherwise, use the timestamp
        csv_filename="$timestamp.csv"
    fi

    echo "$title,$additional_output,$result" >> "$csv_filename"


title="1.3.1 Ensure bootloader password is set"

# Check if the bootloader password is set
l_grub_password_file="$(find /boot -type f -name 'user.cfg' ! -empty)"
if [ -f "$l_grub_password_file" ]; then
    l_grub2_password=$(awk -F. '/^\s*GRUB2_PASSWORD=\S+/ {print $1"."$2"."$3}' "$l_grub_password_file")
    if [ -n "$l_grub2_password" ]; then
        additional_output="Bootloader password is set"
        result="Passed"
    else
        additional_output="Bootloader password is not set"
        result="Failed"
    fi
else
    additional_output="Bootloader password file not found"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


title="1.3.2 Ensure permissions on bootloader config are configured"

l_output=""
l_output2=""

while IFS= read -r -d $'\0' l_gfile; do
    while read -r l_file l_mode l_user l_group; do
        l_out=""
        l_out2=""
        [[ "$(dirname "$l_file")" =~ ^\/boot\/efi\/EFI ]] && l_pmask="0077" || l_pmask="0177"
        l_maxperm="$(printf '%o' $(( 0777 & ~$l_pmask )))"

        if [ $(( $l_mode & $l_pmask )) -gt 0 ]; then
            l_out2="$l_out2\n - Is mode \"$l_mode\" and should be mode: \"$l_maxperm\" or more restrictive"
        else
            l_out="$l_out\n - Is correctly mode: \"$l_mode\" which is mode: \"$l_maxperm\" or more restrictive"
        fi

        if [ "$l_user" = "root" ]; then
            l_out="$l_out\n - Is correctly owned by user: \"$l_user\""
        else
            l_out2="$l_out2\n - Is owned by user: \"$l_user\" and should be owned by user: \"root\""
        fi
        if [ "$l_group" = "root" ]; then
            l_out="$l_out\n - Is correctly group-owned by group: \"$l_user\""
        else
            l_out2="$l_out2\n - Is group-owned by group: \"$l_user\" and should be group-owned by group: \"root\""
        fi

        [ -n "$l_out" ] && l_output="$l_output\n - File: \"$l_file\"$l_out\n"
        [ -n "$l_out2" ] && l_output2="$l_output2\n - File: \"$l_file\"$l_out2\n"
    done <<< "$(stat -Lc '%n %#a %U %G' "$l_gfile")"
done < <(find /boot -type f \( -name 'grub*' -o -name 'user.cfg' \) -print0)

if [ -z "$l_output2" ]; then
    additional_output="Permissions on bootloader config are correctly set"
    result="Passed"
else
    additional_output="Permissions on bootloader config are not correctly set"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


title="1.4.1 Ensure address space layout randomization (ASLR) is enabled"
l_output=""
l_output2=""

while IFS="=" read -r l_kpname l_kpvalue; do
    l_kpname="${l_kpname// /}"
    l_kpvalue="${l_kpvalue// /}"

    if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
        l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
    else
        l_krp="$(sysctl "$l_kpname" 2>/dev/null | awk -F= '{print $2}' | xargs)"

        if [ -z "$l_krp" ]; then
            # Skip if sysctl key not found
            continue
        fi

        # Check running configuration
        if [ "$l_krp" = "$l_kpvalue" ]; then
            l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
        else
            l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
        fi

        unset A_out
        declare -A A_out

        # Check durable setting (files)
        while read -r l_out; do
            if [ -n "$l_out" ]; then
                if [[ $l_out =~ ^\s*# ]]; then
                    l_file="${l_out//# /}"
                else
                    l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
                    [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
                fi
            fi
        done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')

        if [ -n "$l_ufwscf" ]; then
            # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
            l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
            l_kpar="${l_kpar//\//.}"
            [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
        fi

        if (( ${#A_out[@]} > 0 )); then
            # Assess output from files and generate output
            while IFS="=" read -r l_fkpname l_fkpvalue; do
                l_fkpname="${l_fkpname// /}"
                l_fkpvalue="${l_fkpvalue// /}"

                if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
                    l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in \"$(printf '%s' "${A_out[@]}")\"\n"
                else
                    l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
                fi
            done < <(grep -Pio -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
        else
            l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
        fi
    fi
done < <(printf '%s\n' "${a_parlist[@]}")

if [ -z "$l_output2" ]; then
    additional_output="Address space layout randomization (ASLR) is enabled"
    result="Passed"
else
    additional_output="Address space layout randomization (ASLR) is not properly configured"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.4.2 Ensure ptrace_scope is restricted"
l_output=""
l_output2=""

while IFS="=" read -r l_kpname l_kpvalue; do
    l_kpname="${l_kpname// /}"
    l_kpvalue="${l_kpvalue// /}"

    if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
        l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
    else
        l_krp="$(sysctl "$l_kpname" 2>/dev/null | awk -F= '{print $2}' | xargs)"

        if [ -z "$l_krp" ]; then
            # Skip if sysctl key not found
            continue
        fi

        # Check running configuration
        if [ "$l_krp" = "$l_kpvalue" ]; then
            l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
        else
            l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
        fi

        unset A_out
        declare -A A_out

        # Check durable setting (files)
        while read -r l_out; do
            if [ -n "$l_out" ]; then
                if [[ $l_out =~ ^\s*# ]]; then
                    l_file="${l_out//# /}"
                else
                    l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
                    [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
                fi
            fi
        done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')

        if [ -n "$l_ufwscf" ]; then
            # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
            l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
            l_kpar="${l_kpar//\//.}"
            [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
        fi

        if (( ${#A_out[@]} > 0 )); then
            # Assess output from files and generate output
            while IFS="=" read -r l_fkpname l_fkpvalue; do
                l_fkpname="${l_fkpname// /}"
                l_fkpvalue="${l_fkpvalue// /}"

                if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
                    l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in \"$(printf '%s' "${A_out[@]}")\"\n"
                else
                    l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
                fi
            done < <(grep -Pio -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
        else
            l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
        fi
    fi
done < <(printf '%s\n' "${a_parlist[@]}")

if [ -z "$l_output2" ]; then
    additional_output="ptrace_scope is restricted"
    result="Passed"
else
    additional_output="ptrace_scope is not properly restricted - Reason: $l_output2"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.4.3 Ensure core dump backtraces are disabled"
l_output=""
l_output2=""

while IFS="=" read -r l_systemd_parameter_name l_systemd_parameter_value; do
    l_systemd_parameter_name="${l_systemd_parameter_name// /}"
    l_systemd_parameter_value="${l_systemd_parameter_value// /}"

    l_systemd_config_file="/etc/systemd/coredump.conf"

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

    config_file_parameter_chk
done < <(printf '%s\n' "${a_parlist[@]}")

if [ -z "$l_output2" ]; then
    additional_output="Core dump backtraces are disabled"
    result="Passed"
else
    additional_output="Core dump backtraces are not properly configured"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.4.4 Ensure core dump storage is disabled"
l_output=""
l_output2=""

while IFS="=" read -r l_systemd_parameter_name l_systemd_parameter_value; do
    l_systemd_parameter_name="${l_systemd_parameter_name// /}"
    l_systemd_parameter_value="${l_systemd_parameter_value// /}"

    l_systemd_config_file="/etc/systemd/coredump.conf"

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

    config_file_parameter_chk
done < <(printf '%s\n' "${a_parlist[@]}")

if [ -z "$l_output2" ]; then
    additional_output="Core dump storage is disabled"
    result="Passed"
else
    additional_output="Core dump storage is not properly configured"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.5.1.1 Ensure SELinux is installed"
# 1.5.1.1 Ensure SELinux is installed
if rpm -q libselinux &> /dev/null; then
  additional_output="SELinux is installed"
  result="Passed"
else
  additional_output="SELinux is not installed"
  result="Failed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"
title="1.5.1.2 Ensure SELinux is not disabled in bootloader configuration"
# 1.5.1.2 Ensure SELinux is not disabled in bootloader configuration
if grubby --info=ALL | grep -Po '(selinux|enforcing)=0\b' &> /dev/null; then
  additional_output="SELinux is disabled in bootloader configuration"
  result="Failed"
else
  additional_output="SELinux is enabled in bootloader configuration"
  result="Passed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.5.1.3 Ensure SELinux policy is configured"
# 1.5.1.3 Ensure SELinux policy is configured
if grep -E '^\s*SELINUXTYPE=(targeted|mls)\b' /etc/selinux/config &> /dev/null; then
  if sestatus | grep Loaded | grep -q "targeted\|mls"; then
	additional_output="SELinux policy is configured"
        result="Passed"
  else
        additional_output="SELinux policy does not match 'targeted' or 'mls'"
        result="Failed"
  fi
else
  additional_output="SELinux policy is not configured"
  result="Failed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi
echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.5.1.4 Ensure the SELinux mode is not disabled"
# 1.5.1.4 Ensure the SELinux mode is not disabled
if [ "$(getenforce)" != "Disabled" ]; then
  if grep -Ei '^\s*SELINUX=(enforcing|permissive)' /etc/selinux/config | grep -q "enforcing"; then
        additional_output="SELinux is enabled"
        result="Passed"
  else
        additional_output="SELinux mode is not set in configuration"
        result="Failed"
  fi
else
  additional_output="SELinux is disabled"
  result="Failed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.5.1.5 Ensure the SELinux mode is enforcing"
# 1.5.1.5 Ensure the SELinux mode is enforcing
if [ "$(getenforce)" == "Enforcing" ]; then
  if grep -i SELINUX=enforcing /etc/selinux/config &> /dev/null; then
        additional_output="SELinux is in enforcing mode"
        result="Passed"
  else
        additional_output="SELinux mode is not set to 'enforcing' in configuration"
        result="Failed"
  fi
else
  additional_output="SELinux is not in enforcing mode"
  result="Failed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"
title="1.5.1.6 Ensure no unconfined services exist"
# 1.5.1.6 Ensure no unconfined services exist
if ps -eZ | grep unconfined_service_t &> /dev/null; then
  additional_output="Unconfined services exist"
  result="Failed"
else
  additional_output="No unconfined services exist"
  result="Passed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.5.1.7 Ensure the MCS Translation Service (mcstrans) is not installed"
# 1.5.1.7 Ensure the MCS Translation Service (mcstrans) is not installed
if rpm -q mcstrans &> /dev/null; then
  additional_output="MCS Translation Service is installed"
  result="Failed"
else
  additional_output="MCS Translation Service is not installed"
  result="Passed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.5.1.8 Ensure SETroubleshoot is not installed"
# 1.5.1.8 Ensure SETroubleshoot is not installed
if rpm -q setroubleshoot &> /dev/null; then
  additional_output="SETroubleshoot is installed"
  result="Failed"
else
  additional_output="SETroubleshoot is not installed"
  result="Passed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.6.1 Ensure system wide crypto policy is not set to legacy"
# 1.6.1 Ensure system wide crypto policy is not set to legacy
if grep -Pi '^\h*LEGACY\b' /etc/crypto-policies/config &> /dev/null; then
  additional_output="System-wide crypto policy is set to LEGACY"
  result="Failed"
else
  additional_output="System-wide crypto policy is not set to LEGACY"
  result="Passed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.6.2 Ensure system wide crypto policy disables sha1 hash and signature support"
# 1.6.2 Ensure system wide crypto policy disables sha1 hash and signature support
if grep -Pi -- '^\h*(hash|sign)\h*=\h*([^\n\r#]+)?-sha1\b' /etc/crypto-policies/state/CURRENT.pol &> /dev/null ||
   grep -Pi -- '^\h*sha1_in_certs\h*=\h*' /etc/crypto-policies/state/CURRENT.pol &> /dev/null; then
  additional_output="SHA1 hash and signature support are not disabled"
  result="Failed"
else
  additional_output="SHA1 hash and signature support are disabled"
  result="Passed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


# 1.6.3 Ensure system wide crypto policy disables cbc for ssh
{
  l_output=""
  l_output2=""
  title="1.6.3 Ensure system wide crypto policy disables cbc for ssh"
  if [ -f /etc/crypto-policies/state/CURRENT.pol ] &&
    grep -Piq -- '^\h*cipher\h*=\h*([^#\n\r]+)?-CBC\b' /etc/crypto-policies/state/CURRENT.pol; then
    if grep -Piq -- '^\h*cipher@(lib|open)ssh(-server|-client)?\h*=\h*' /etc/crypto-policies/state/CURRENT.pol; then
      if ! grep -Piq -- '^\h*cipher@(lib|open)ssh(-server|-client)?\h*=\h*([^#\n\r]+)?-CBC\b' /etc/crypto-policies/state/CURRENT.pol; then
        l_output="$l_output\n - Cipher Block Chaining (CBC) is disabled for SSH"
      else
        l_output2="$l_output2\n - Cipher Block Chaining (CBC) is enabled for SSH"
      fi
    else
      l_output2="$l_output2\n - Cipher Block Chaining (CBC) is enabled for SSH"
    fi
  else
    l_output=" - Cipher Block Chaining (CBC) is disabled"
  fi

  if [ -z "$l_output2" ]; then
    # Provide output from checks
    additional_output="Cipher Block Chaining (CBC) is disabled for SSH"
    result="Passed"
  else
    additional_output="Cipher Block Chaining (CBC) is enabled for SSH - $l_output2"
    result="Failed"
  fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"
}

title="1.6.4 Ensure system wide crypto policy disables macs less than 128 bits"
# 1.6.4 Ensure system wide crypto policy disables macs less than 128 bits
if grep -Pi -- '^\h*mac\h*=\h*([^#\n\r]+)?-64\b' /etc/crypto-policies/state/CURRENT.pol &> /dev/null; then
  additional_output="Weak MACs less than 128 bits are not disabled"
  result="Failed"
else
  additional_output="Weak MACs less than 128 bits are disabled"
  result="Passed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.7.1 Ensure message of the day is configured properly"
# 1.7.1 Ensure message of the day is configured properly
MOTD_CONTENT=$(cat /etc/motd)
if [ -n "$MOTD_CONTENT" ]; then
  if grep -E -i "(\\v|\\r|\\m|\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/motd &> /dev/null; then
    additional_output="Message of the day is not configured properly"
    result="Failed"
  else
    additional_output="Message of the day is configured properly"
    result="Passed"
  fi
else
  additional_output="Message of the day is not configured"
  result="Failed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.7.2 Ensure local login warning banner is configured properly"
# 1.7.2 Ensure local login warning banner is configured properly
ISSUE_CONTENT=$(cat /etc/issue)
if [ -n "$ISSUE_CONTENT" ]; then
  if grep -E -i "(\\v|\\r|\\m|\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue &> /dev/null; then
    additional_output="Local login warning banner is not configured properly"
    result="Failed"
  else
    additional_output="Local login warning banner is configured properly"
    result="Passed"
  fi
else
  additional_output="Local login warning banner is not configured"
  result="Failed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.7.3 Ensure remote login warning banner is configured properly"
# 1.7.3 Ensure remote login warning banner is configured properly
ISSUE_NET_CONTENT=$(cat /etc/issue.net)
if [ -n "$ISSUE_NET_CONTENT" ]; then
  if grep -E -i "(\\v|\\r|\\m|\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue.net &> /dev/null; then
    additional_output="Remote login warning banner is not configured properly"
    result="Failed"
  else
    additional_output="Remote login warning banner is configured properly"
    result="Passed"
  fi
else
  additional_output="Remote login warning banner is not configured"
  result="Failed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.7.4 Ensure access to /etc/motd is configured"
# 1.7.4 Ensure access to /etc/motd is configured
MOTD_ACCESS=$(stat -Lc '%a' /etc/motd 2>/dev/null)
if [ -n "$MOTD_ACCESS" ]; then
  if [ "$MOTD_ACCESS" -ge 644 ]; then
    additional_output="Access to /etc/motd is configured properly"
    result="Passed"
  else
    additional_output="Access to /etc/motd is not configured properly"
    result="Failed"
  fi
else
  additional_output="/etc/motd does not exist"
  result="Failed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.7.5 Ensure access to /etc/issue is configured"
# 1.7.5 Ensure access to /etc/issue is configured
ISSUE_ACCESS=$(stat -Lc '%a' /etc/issue)
if [ "$ISSUE_ACCESS" -ge 644 ]; then
  additional_output="Access to /etc/issue is configured properly"
  result="Passed"
else
  additional_output="Access to /etc/issue is not configured properly"
  result="Failed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"
title="1.7.6 Ensure access to /etc/issue.net is configured"
# 1.7.6 Ensure access to /etc/issue.net is configured
ISSUE_NET_ACCESS=$(stat -Lc '%a' /etc/issue.net)
if [ "$ISSUE_NET_ACCESS" -ge 644 ]; then
  additional_output="Access to /etc/issue.net is configured properly"
  result="Passed"
else
  additional_output="Access to /etc/issue.net is not configured properly"
  result="Failed"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.8.1 Ensure GNOME Display Manager is removed"
additional_output=""
result=""

if ! command -v gdm &> /dev/null; then
    additional_output="GNOME Display Manager is removed"
    result="Passed"
else
    additional_output="GNOME Display Manager is not removed"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.8.2 Ensure GDM login banner is configured"
additional_output=""
result=""

l_pkgoutput=""
if command -v dpkg-query > /dev/null 2>&1; then
    l_pq="dpkg-query -W"
elif command -v rpm > /dev/null 2>&1; then
    l_pq="rpm -q"
fi

l_pcl="gdm gdm3"

for l_pn in $l_pcl; do
    $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
done

if [ -n "$l_pkgoutput" ]; then
    l_output=""
    l_output2=""

    l_gdmfile="$(grep -Prils '^\h*banner-message-enable\b' /etc/dconf/db/*.d)"
    if [ -n "$l_gdmfile" ]; then
        l_gdmprofile="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_gdmfile")"
        if grep -Pisq '^\h*banner-message-enable=true\b' "$l_gdmfile"; then
            l_output="$l_output\n - The \"banner-message-enable\" option is enabled in \"$l_gdmfile\""
        else
            l_output2="$l_output2\n - The \"banner-message-enable\" option is not enabled"
        fi
        l_lsbt="$(grep -Pios '^\h*banner-message-text=.*$' "$l_gdmfile")"
        if [ -n "$l_lsbt" ]; then
            l_output="$l_output\n - The \"banner-message-text\" option is set in \"$l_gdmfile\"\n - banner-message-text is set to:\n - \"$l_lsbt\""
        else
            l_output2="$l_output2\n - The \"banner-message-text\" option is not set"
        fi
        if grep -Pq "^\h*system-db:$l_gdmprofile" /etc/dconf/profile/"$l_gdmprofile"; then
            l_output="$l_output\n - The \"$l_gdmprofile\" profile exists"
        else
            l_output2="$l_output2\n - The \"$l_gdmprofile\" doesn't exist"
        fi
        if [ -f "/etc/dconf/db/$l_gdmprofile" ]; then
            l_output="$l_output\n - The \"$l_gdmprofile\" profile exists in the dconf database"
        else
            l_output2="$l_output2\n - The \"$l_gdmprofile\" profile doesn't exist in the dconf database"
        fi
    else
        l_output2="$l_output2\n - The \"banner-message-enable\" option isn't configured"
    fi
else
    echo -e "\n - GNOME Desktop Manager isn't installed\n - Recommendation is Not Applicable\n- Audit result:\n *** PASS ***\n"
fi

if [ -z "$l_output2" ]; then
    additional_output="GDM login banner is configured"
    result="Passed"
else
    additional_output=("GDM login banner is not configured")
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.8.3 Ensure GDM disable-user-list option is enabled"
additional_output=""
result=""

l_pkgoutput=""
if command -v dpkg-query > /dev/null 2>&1; then
    l_pq="dpkg-query -W"
elif command -v rpm > /dev/null 2>&1; then
    l_pq="rpm -q"
fi

l_pcl="gdm gdm3"

for l_pn in $l_pcl; do
    $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
done

if [ -n "$l_pkgoutput" ]; then
    output=""
    output2=""
    l_gdmfile="$(grep -Pril '^\h*disable-user-list\h*=\h*true\b' /etc/dconf/db)"
    if [ -n "$l_gdmfile" ]; then
        output="$output\n - The \"disable-user-list\" option is enabled in \"$l_gdmfile\""
        l_gdmprofile="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_gdmfile")"
        if grep -Pq "^\h*system-db:$l_gdmprofile" /etc/dconf/profile/"$l_gdmprofile"; then
            output="$output\n - The \"$l_gdmprofile\" exists"
        else
            output2="$output2\n - The \"$l_gdmprofile\" doesn't exist"
        fi
        if [ -f "/etc/dconf/db/$l_gdmprofile" ]; then
            output="$output\n - The \"$l_gdmprofile\" profile exists in the dconf database"
        else
            output2="$output2\n - The \"$l_gdmprofile\" profile doesn't exist in the dconf database"
        fi
    else
        output2="$output2\n - The \"disable-user-list\" option is not enabled"
    fi
    if [ -z "$output2" ]; then
        additional_output="GDM disable-user-list option check passed"
        result="Passed"
    else
        additional_output="GDM disable-user-list option check failed"
        result="Failed"
    fi
else
    additional_output="GNOME Desktop Manager isn't installed"
    result="Passed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.8.4 Ensure GDM screen locks when the user is idle"
additional_output=""
result=""
FAILEDWR=""

l_pkgoutput=""
if command -v dpkg-query > /dev/null 2>&1; then
    l_pq="dpkg-query -W"
elif command -v rpm > /dev/null 2>&1; then
    l_pq="rpm -q"
fi

l_pcl="gdm gdm3"

for l_pn in $l_pcl; do
    $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="Package: \"$l_pn\" exists on the system - checking configuration"
done

if [ -n "$l_pkgoutput" ]; then
    l_output=""
    l_output2=""
    l_idmv="900"
    l_ldmv="5"
    l_kfile="$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/)"

    if [ -n "$l_kfile" ]; then
        l_profile="$(awk -F'/' '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")"
        l_pdbdir="/etc/dconf/db/$l_profile.d"
        l_idv="$(awk -F 'uint32' '/idle-delay/{print $2}' "$l_kfile" | xargs)"

        if [ -n "$l_idv" ]; then
            [ "$l_idv" -gt "0" -a "$l_idv" -le "$l_idmv" ] && l_output="$l_output\n - The \"idle-delay\" option is set to \"$l_idv\" seconds in \"$l_kfile\""
            [ "$l_idv" = "0" ] && l_output2="$l_output2\n - The \"idle-delay\" option is set to \"$l_idv\" (disabled) in \"$l_kfile\""
            [ "$l_idv" -gt "$l_idmv" ] && l_output2="$l_output2\n - The \"idle-delay\" option is set to \"$l_idv\" seconds (greater than $l_idmv) in \"$l_kfile\""
        else
            l_output2="$l_output2\n - The \"idle-delay\" option is not set in \"$l_kfile\""
        fi

        l_ldv="$(awk -F 'uint32' '/lock-delay/{print $2}' "$l_kfile" | xargs)"

        if [ -n "$l_ldv" ]; then
            [ "$l_ldv" -ge "0" -a "$l_ldv" -le "$l_ldmv" ] && l_output="$l_output\n - The \"lock-delay\" option is set to \"$l_ldv\" seconds in \"$l_kfile\""
            [ "$l_ldv" -gt "$l_ldmv" ] && l_output2="$l_output2\n - The \"lock-delay\" option is set to \"$l_ldv\" seconds (greater than $l_ldmv) in \"$l_kfile\""
        else
            l_output2="$l_output2\n - The \"lock-delay\" option is not set in \"$l_kfile\""
        fi

        if grep -Psq "^\h*system-db:$l_profile" /etc/dconf/profile/*; then
            l_output="$l_output\n - The \"$l_profile\" profile exists"
        else
            l_output2="$l_output2\n - The \"$l_profile\" doesn't exist"
        fi

        if [ -f "/etc/dconf/db/$l_profile" ]; then
            l_output="$l_output\n - The \"$l_profile\" profile exists in the dconf database"
        else
            l_output2="$l_output2\n - The \"$l_profile\" profile doesn't exist in the dconf database"
        fi
    else
        l_output2="$l_output2\n - The \"idle-delay\" option doesn't exist, remaining tests skipped"
    fi
else
    l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable"
fi

# Display only if there are other outputs
[ -n "$l_pkgoutput" ] && [ -n "$l_output" ] && echo -e "\n$l_pkgoutput"

title="1.8.4 Ensure GDM screen locks when the user is idle"
if [ -z "$l_output2" ]; then
    additional_output="GDM screen locks when the user is idle"
    result="Passed"
else
    additional_output="GDM screen doesn't locks when the user is idle"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="1.8.5 Ensure GDM screen locks cannot be overridden"
additional_output=""
result=""

l_pkgoutput=""
if command -v dpkg-query > /dev/null 2>&1; then
    l_pq="dpkg-query -W"
elif command -v rpm > /dev/null 2>&1; then
    l_pq="rpm -q"
fi

l_pcl="gdm gdm3"

for l_pn in $l_pcl; do
    $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="Package: \"$l_pn\" exists on the system - checking configuration"
done

if [ -n "$l_pkgoutput" ]; then
    l_output=""
    l_output2=""
    l_kfd="/etc/dconf/db/$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d"
    l_kfd2="/etc/dconf/db/$(grep -Psril '^\h*lock-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d"

    if [ -d "$l_kfd" ]; then
        if grep -Prilq '\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd"; then
            l_output="$l_output\n - \"idle-delay\" is locked in \"$(grep -Pril '\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd")\""
        else
            l_output2="$l_output2\n - \"idle-delay\" is not locked"
        fi
    else
        l_output2="$l_output2\n - \"idle-delay\" is not set so it can not be locked"
    fi

    if [ -d "$l_kfd2" ]; then
        if grep -Prilq '\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2"; then
            l_output="$l_output\n - \"lock-delay\" is locked in \"$(grep -Pril '\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2")\""
        else
            l_output2="$l_output2\n - \"lock-delay\" is not locked"
        fi
    else
        l_output2="$l_output2\n - \"lock-delay\" is not set so it can not be locked"
    fi
else
    l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable"
fi

# Display only if there are other outputs
[ -n "$l_pkgoutput" ] && [ -n "$l_output" ] && echo -e "\n$l_pkgoutput"

title="1.8.5 Ensure GDM screen locks cannot be overridden"
if [ -z "$l_output2" ]; then
    additional_output="GDM screen locks cannot be overridden"
    result="Passed"
else
    additional_output="GDM screen locks can be overridden"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


title="1.8.6 Ensure GDM automatic mounting of removable media is disabled"
additional_output=""
result=""

l_pkgoutput=""
if command -v dpkg-query > /dev/null 2>&1; then
    l_pq="dpkg-query -W"
elif command -v rpm > /dev/null 2>&1; then
    l_pq="rpm -q"
fi

l_pcl="gdm gdm3"

for l_pn in $l_pcl; do
    $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="Package: \"$l_pn\" exists on the system - checking configuration"
done

if [ -n "$l_pkgoutput" ]; then
    l_output=""
    l_output2=""
    l_kfile="$(grep -Prils -- '^\h*automount\b' /etc/dconf/db/*.d)"
    l_kfile2="$(grep -Prils -- '^\h*automount-open\b' /etc/dconf/db/*.d)"

    if [ -f "$l_kfile" ]; then
        l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")"
    elif [ -f "$l_kfile2" ]; then
        l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile2")"
    fi

    if [ -n "$l_gpname" ]; then
        l_gpdir="/etc/dconf/db/$l_gpname.d"

        if grep -Pq -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*; then
            l_output="$l_output\n - dconf database profile file \"$(grep -Pl -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*)\" exists"
        else
            l_output2="$l_output2\n - dconf database profile isn't set"
        fi

        if [ -f "/etc/dconf/db/$l_gpname" ]; then
            l_output="$l_output\n - The dconf database \"$l_gpname\" exists"
        else
            l_output2="$l_output2\n - The dconf database \"$l_gpname\" doesn't exist"
        fi

        if [ -d "$l_gpdir" ]; then
            l_output="$l_output\n - The dconf directory \"$l_gpdir\" exists"
        else
            l_output2="$l_output2\n - The dconf directory \"$l_gpdir\" doesn't exist"
        fi

        if grep -Pqrs -- '^\h*automount\h*=\h*false\b' "$l_kfile"; then
            l_output="$l_output\n - \"automount\" is set to false in: \"$l_kfile\""
        else
            l_output2="$l_output2\n - \"automount\" is not set correctly"
        fi

        if grep -Pqs -- '^\h*automount-open\h*=\h*false\b' "$l_kfile2"; then
            l_output="$l_output\n - \"automount-open\" is set to false in: \"$l_kfile2\""
        else
            l_output2="$l_output2\n - \"automount-open\" is not set correctly"
        fi

    else
        l_output2="$l_output2\n - neither \"automount\" or \"automount-open\" is set"
    fi
else
    l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable"
fi

# Display only if there are other outputs
[ -n "$l_pkgoutput" ] && [ -n "$l_output" ] && echo -e "\n$l_pkgoutput"

title="1.8.6 Ensure GDM automatic mounting of removable media is disabled"
if [ -z "$l_output2" ]; then
    additional_output="GDM automatic mounting of removable media is disabled"
    result="Passed"
else
    additional_output="GDM automatic mounting of removable media is enabled"
    result="Failed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


title="1.8.7 Ensure GDM disabling automatic mounting of removable media is not overridden"
additional_output=""
result=""

l_pkgoutput=""
if command -v dpkg-query > /dev/null 2>&1; then
    l_pq="dpkg-query -W"
elif command -v rpm > /dev/null 2>&1; then
    l_pq="rpm -q"
fi

l_pcl="gdm gdm3"

for l_pn in $l_pcl; do
    $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="Package: \"$l_pn\" exists on the system - checking configuration"
done

if [ -n "$l_pkgoutput" ]; then
    l_output=""
    l_output2=""

    l_kfd="/etc/dconf/db/$(grep -Psril '^\h*automount\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d"
    l_kfd2="/etc/dconf/db/$(grep -Psril '^\h*automount-open\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d"

    if [ -d "$l_kfd" ]; then
        if grep -Priq '^\h*\/org/gnome\/desktop\/media-handling\/automount\b' "$l_kfd"; then
            l_output="$l_output\n - \"automount\" is locked in \"$(grep -Pril '^\h*\/org/gnome\/desktop\/media-handling\/automount\b' "$l_kfd")\""
        else
            l_output2="$l_output2\n - \"automount\" is not locked"
        fi
    else
        l_output2="$l_output2\n - \"automount\" is not set so it cannot be locked"
    fi

    if [ -d "$l_kfd2" ]; then
        if grep -Priq '^\h*\/org/gnome\/desktop\/media-handling\/automount-open\b' "$l_kfd2"; then
            l_output="$l_output\n - \"lautomount-open\" is locked in \"$(grep -Pril '^\h*\/org/gnome\/desktop\/media-handling\/automount-open\b' "$l_kfd2")\""
        else
            l_output2="$l_output2\n - \"automount-open\" is not locked"
        fi
    else
        l_output2="$l_output2\n - \"automount-open\" is not set so it cannot be locked"
    fi

    # Display only if there are other outputs
    [ -n "$l_output" ] && echo -e "\n$l_pkgoutput"

    title="1.8.7 Ensure GDM disabling automatic mounting of removable media is not overridden"
    if [ -z "$l_output2" ]; then
        additional_output="GDM disabling automatic mounting of removable media is not overridden"
        result="Passed"
    else
        additional_output="GDM disabling automatic mounting of removable media is overridden"
        result="Failed"
    fi

    # Check if a custom CSV name is provided
    if [ -n "$1" ]; then
        # Use the custom name if provided
        csv_filename="$1"
    else
        # Otherwise, use the timestamp
        csv_filename="$timestamp.csv"
    fi

    echo "$title,$additional_output,$result" >> "$csv_filename"
fi

title="1.8.8 Ensure GDM autorun-never is enabled"
additional_output=""
result=""

l_pkgoutput=""
if command -v dpkg-query > /dev/null 2>&1; then
    l_pq="dpkg-query -W"
elif command -v rpm > /dev/null 2>&1; then
    l_pq="rpm -q"
fi

l_pcl="gdm gdm3"

for l_pn in $l_pcl; do
    $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="Package: \"$l_pn\" exists on the system - checking configuration"
done

if [ -n "$l_pkgoutput" ]; then
    l_output=""
    l_output2=""

    l_kfile="$(grep -Prils -- '^\h*autorun-never\b' /etc/dconf/db/*.d)"

    if [ -f "$l_kfile" ]; then
        l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")"
    fi

    if [ -n "$l_gpname" ]; then
        l_gpdir="/etc/dconf/db/$l_gpname.d"

        if grep -Pq -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*; then
            l_output="$l_output\n - dconf database profile file \"$(grep -Pl -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*)\" exists"
        else
            l_output2="$l_output2\n - dconf database profile isn't set"
        fi

        if [ -f "/etc/dconf/db/$l_gpname" ]; then
            l_output="$l_output\n - The dconf database \"$l_gpname\" exists"
        else
            l_output2="$l_output2\n - The dconf database \"$l_gpname\" doesn't exist"
        fi

        if [ -d "$l_gpdir" ]; then
            l_output="$l_output\n - The dconf directory \"$l_gpdir\" exists"
        else
            l_output2="$l_output2\n - The dconf directory \"$l_gpdir\" doesn't exist"
        fi

        if grep -Pqrs -- '^\h*autorun-never\h*=\h*true\b' "$l_kfile"; then
            l_output="$l_output\n - \"autorun-never\" is set to true in: \"$l_kfile\""
        else
            l_output2="$l_output2\n - \"autorun-never\" is not set correctly"
        fi
    else
        l_output2="$l_output2\n - \"autorun-never\" is not set"
    fi

    # Display only if there are other outputs
    [ -n "$l_output" ] && echo -e "\n$l_pkgoutput"

    title="1.8.8 Ensure GDM autorun-never is enabled"
    if [ -z "$l_output2" ]; then
        additional_output="GDM autorun-never is enabled"
        result="Passed"
    else
        additional_output="GDM autorun-never is disabled"
        result="Failed"
    fi

    # Check if a custom CSV name is provided
    if [ -n "$1" ]; then
        # Use the custom name if provided
        csv_filename="$1"
    else
        # Otherwise, use the timestamp
        csv_filename="$timestamp.csv"
    fi

    echo "$title,$additional_output,$result" >> "$csv_filename"
fi


title="1.8.9 Ensure GDM autorun-never is not overridden"
additional_output=""
result=""

l_pkgoutput=""
if command -v dpkg-query > /dev/null 2>&1; then
    l_pq="dpkg-query -W"
elif command -v rpm > /dev/null 2>&1; then
    l_pq="rpm -q"
fi

l_pcl="gdm gdm3"

for l_pn in $l_pcl; do
    $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="Package: \"$l_pn\" exists on the system - checking configuration"
done

if [ -n "$l_pkgoutput" ]; then
    l_output=""
    l_output2=""

    l_kfd="/etc/dconf/db/$(grep -Psril '^\h*autorun-never\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d"

    if [ -d "$l_kfd" ]; then
        if grep -Priq '^\h*\/org/gnome\/desktop\/media-handling\/autorun-never\b' "$l_kfd"; then
            l_output="$l_output\n - \"autorun-never\" is locked in \"$(grep -Pril '^\h*\/org/gnome\/desktop\/media-handling\/autorun-never\b' "$l_kfd")\""
        else
            l_output2="$l_output2\n - \"autorun-never\" is not locked"
        fi
    else
        l_output2="$l_output2\n - \"autorun-never\" is not set so it cannot be locked"
    fi

    # Display only if there are other outputs
    [ -n "$l_output" ] && echo -e "\n$l_pkgoutput"

    title="1.8.9 Ensure GDM autorun-never is not overridden"
    if [ -z "$l_output2" ]; then
        additional_output="GDM autorun-never is not overridden"
        result="Passed"
    else
        additional_output="GDM autorun-never is overridden"
        result="Failed"
    fi

    # Check if a custom CSV name is provided
    if [ -n "$1" ]; then
        # Use the custom name if provided
        csv_filename="$1"
    else
        # Otherwise, use the timestamp
        csv_filename="$timestamp.csv"
    fi

    echo "$title,$additional_output,$result" >> "$csv_filename"
fi

title="1.8.10 Ensure XDMCP is not enabled"
additional_output=""
result=""

# Check if XDMCP is enabled in /etc/gdm/custom.conf
if grep -Eis '^\s*Enable\s*=\s*true' /etc/gdm/custom.conf; then
    additional_output="XDMCP is enabled in /etc/gdm/custom.conf"
    result="Failed"
else
    additional_output="XDMCP is not enabled"
    result="Passed"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"





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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
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

    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

title="3.1.1 Ensure IPv6 status is identified (Manual)"


ipv6_disabled=$(grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disabel)

if [ -z "$ipv6_disabled" ]; then

           result="Passed"
           additional_output="IPv6 is enabled"
else
           result="Failed"
           additional_output="IPv6 is Disabled"

fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



title="3.1.2 Ensure wireless interfaces are disabled (Automated)"


# Initialize output variables
l_output=""
l_output2=""

# Function to check module properties
module_chk() {
    # Check if the module is loadable
    l_loadable="$(modprobe -n -v "$l_mname")"
    if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
        l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
    fi

    # Check if the module is currently loaded
    if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
        l_output="$l_output\n - module: \"$l_mname\" is not loaded"
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
    fi

    # Check if the module is deny-listed (blacklisted)
    if modprobe --showconfig | grep -Pq -- "^\h*blacklist\h+$l_mname\b"; then
        l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pl -- "^\h*blacklist\h+$l_mname\b" /etc/modprobe.d/*)\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
    fi
}

# Check for wireless network interface controllers (NICs)
if [ -n "$(find /sys/class/net/*/ -type d -name wireless)" ]; then
    # Identify wireless NIC modules
    l_dname=$(find /sys/class/net/*/ -type d -name wireless | xargs -I{} dirname {} | xargs -I{} basename $(readlink -f "{}/device/driver/module") | sort -u)

    # Iterate through wireless NIC modules and check them
    for l_mname in $l_dname; do
        module_chk
    done
fi

# Report results
if [ -z "$l_output2" ]; then
    result="Passed"

    if [ -z "$l_output" ]; then
        additional_output="System has no wireless NICs installed"   
    else
       additional_output="System has no wireless NICs installed but $l_output"
    fi
else
   result="Failed"
   additional_output="System has  wireless NICs installed"
    [ -n "$l_output" ] 
fi


# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"






title="3.1.3 Ensure Bluetooth Services are not in USE (Automated)"

# Check if bluetooth.service is enabled
if systemctl is-enabled bluetooth.service 2>/dev/null | grep -q 'enabled'; then
    additional_output="bluetooth.service is enabled"
    result="Failed"
else
    additional_output="bluetooth.service is not enabled"
    result="Passed"
fi




# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"






title="3.2.1 Ensure dccp kernal Module is not available(Automated)"

# Initialize variables
l_output=""
l_output2=""
l_output3=""
l_dl=""
l_mname="dccp"       # Module name
l_mtype="net"        # Module type
l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
l_mpath="/lib/modules/**/kernel/$l_mtype"
l_mpname="$(tr '-' '_' <<< "$l_mname")"
l_mndir="$(tr '-' '/' <<< "$l_mname")"


# Function to check if the module is loadable
module_loadable_chk() {
    l_loadable="$(modprobe -n -v "$l_mname")"
    # If the module is not loadable, log the reason
    if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
        l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
    fi
}

# Function to check if the module is currently loaded
module_loaded_chk() {
    if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
        l_output="$l_output\n - module: \"$l_mname\" is not loaded"
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
    fi
}

# Function to check if the module is deny-listed
module_deny_chk() {
    l_dl="y"
    if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
        l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
    fi
}

# Main audit function
audit_module() {
    # Check potential paths for the module
    for l_mdir in $l_mpath; do
        if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
            l_output3="$l_output3\n - \"$l_mdir\""
            [ "$l_dl" != "y" ] && module_deny_chk
            if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
                module_loadable_chk
                module_loaded_chk
            fi
        else
            l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
        fi
    done

    # Report audit results
    [ -n "$l_output3" ]
    if [ -z "$l_output2" ]; then
        additional_output="$l_output"
        result="Passed" 
    else
        [ -n "$l_output" ] 
        additional_output="$l_output2"
        result="Failed"
  
    fi
}

# Call the main audit function
audit_module


additional_output="${additional_output[*]:5:120}"


# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



title="3.2.2 Ensure tipc kernel module is not available (Automated)"


# Initialize output variables
l_output=""
l_output2=""
l_output3=""
l_dl=""

# Define module-related variables
l_mname="tipc"                       # Module name
l_mtype="net"                        # Module type
l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
l_mpath="/lib/modules/**/kernel/$l_mtype"
l_mpname="$(tr '-' '_' <<< "$l_mname")"
l_mndir="$(tr '-' '/' <<< "$l_mname")"

# Function to check if the module is loadable
module_loadable_chk() {
    l_loadable="$(modprobe -n -v "$l_mname")"
    if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
        l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
    fi
}

# Function to check if the module is currently loaded
module_loaded_chk() {
    if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
        l_output="$l_output\n - module: \"$l_mname\" is not loaded"
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
    fi
}

# Function to check if the module is deny-listed
module_deny_chk() {
    if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
        l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
    fi
}

# Main module existence and audit function
for l_mdir in $l_mpath; do
    if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
        l_output3="$l_output3\n - \"$l_mdir\""
        [ "$l_dl" != "y" ] && module_deny_chk
        if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
        fi
    else
        l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
    fi
done

# Report audit results
[ -n "$l_output3" ] 
if [ -z "$l_output2" ]; then
    additional_output="$l_output"
    result="Passed"


else
    [ -n "$l_output" ] 
    additional_output="$l_output2"
    result="Failed"

 
fi


additional_output="${additional_output[*]:5:120}"



# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"






title="3.2.3 Ensure rds kernel module is not available (Automated)"


# -----------------------------------
# Variables Initialization
# -----------------------------------

# Unset output variables
l_output=""
l_output2=""
l_output3=""
l_dl=""

# Define module-related variables
l_mname="rds"
l_mtype="net"
l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
l_mpath="/lib/modules/**/kernel/$l_mtype"
l_mpname="$(tr '-' '_' <<< "$l_mname")"
l_mndir="$(tr '-' '/' <<< "$l_mname")"

# -----------------------------------
# Functions
# -----------------------------------

# Check if the module is currently loadable
module_loadable_chk() {
    l_loadable="$(modprobe -n -v "$l_mname")"
    [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
    
    if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
        l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
    fi
}

# Check if the module is currently loaded
module_loaded_chk() {
    if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
        l_output="$l_output\n - module: \"$l_mname\" is not loaded"
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
    fi
}

# Check if the module is deny-listed
module_deny_chk() {
    if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
        l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
    fi
}

# -----------------------------------
# Main Logic
# -----------------------------------

# Iterate over potential paths for the module
for l_mdir in $l_mpath; do
    if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
        l_output3="$l_output3\n - \"$l_mdir\""
        [ "$l_dl" != "y" ] && module_deny_chk
        if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
        fi
    else
        l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
    fi
done

# Report audit results
[ -n "$l_output3" ] 
if [ -z "$l_output2" ]; then
    additional_output="$l_output"
    result="Passed"


else
    [ -n "$l_output" ] 
    additional_output="$l_output2"
    result="Failed"



fi

additional_output="${additional_output[*]:5:120}"



# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



title="3.2.4 Ensure sctp kernel module is not available (Automated)"



# Initialize output variables to store results
l_output=""
l_output2=""
l_output3=""
l_dl=""

# Set module-related variables
l_mname="sctp"                      # Name of the module
l_mtype="net"                       # Type of module
l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"  # Locations to search for blacklist configurations
l_mpath="/lib/modules/**/kernel/$l_mtype"  # Path to the module in the Linux kernel
l_mpname="$(tr '-' '_' <<< "$l_mname")"     # Modify module name for specific checks
l_mndir="$(tr '-' '/' <<< "$l_mname")"      # Modify module name for directory structure

# Function to check if the module is loadable
module_loadable_chk() {
    l_loadable="$(modprobe -n -v "$l_mname")"                  # Simulate loading the module
    [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
    if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
        l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
    fi
}

# Function to check if the module is currently loaded
module_loaded_chk() {
    if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
        l_output="$l_output\n - module: \"$l_mname\" is not loaded"
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
    fi
}

# Function to check if the module is deny-listed
module_deny_chk() {
    l_dl="y"
    if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
        l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
    fi
}

# Check if the module exists on the system by iterating over potential paths
for l_mdir in $l_mpath; do
    if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
        l_output3="$l_output3\n - \"$l_mdir\""
        [ "$l_dl" != "y" ] && module_deny_chk
        if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
        fi
    else
        l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
    fi
done

# Display audit results based on checks performed
[ -n "$l_output3" ] 
if [ -z "$l_output2" ]; then
    additional_output="$l_output"
    result="Passed"


else
    [ -n "$l_output" ] 
    additional_output="$l_output2"
    result="Failed"

   
 
fi


additional_output="${additional_output[*]:5:120}"


# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




title="3.3.1 Ensure Ip forwarding is disabled (Automated)"

l_output=""
l_output2=""
a_parlist=("net.ipv4.ip_forward=0" "net.ipv6.conf.all.forwarding=0")
l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"

kernel_parameter_chk() {
    l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)"

    # Check running configuration
    if [ "$l_krp" = "$l_kpvalue" ]; then
        l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
    else
        l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
    fi

    unset A_out
    declare -A A_out

    # Check durable setting (files)
    while read -r l_out; do
        if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
                l_file="${l_out//# /}"
            else
                l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
                [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
        fi
    done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')

    if [ -n "$l_ufwscf" ]; then
        # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
        l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
        l_kpar="${l_kpar//\//.}"
        [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
    fi

    if (( ${#A_out[@]} > 0 )); then
        # Assess output from files and generate output
        while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"
            l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
                l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\""
            else
                l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\""
            fi
        done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
    else
        l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n * Note: \"$l_kpname\" May be set in a file that's ignored by load procedure *"
    fi
}

while IFS="=" read -r l_kpname l_kpvalue; do
    l_kpname="${l_kpname// /}"
    l_kpvalue="${l_kpvalue// /}"

    if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
        l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
    else
        kernel_parameter_chk
    fi
done < <(printf '%s\n' "${a_parlist[@]}")

if [ -z "$l_output2" ]; then
    # Provide output from checks
    additional_output="$l_output"
    result="Passed"


else
    [ -n "$l_output" ] 
    additional_output="$l_output2"
    result="Failed" 

fi

additional_output="${additional_output[*]:6:120}"

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



title="3.3.2 Ensure packet redirect sending is disabled (Automated)"

# Initialize variables
l_output=""
l_output2=""
a_parlist=("net.ipv4.conf.all.send_redirects=0" "net.ipv4.conf.default.send_redirects=0")
l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"

# Function to check kernel parameters
kernel_parameter_chk() {
    l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)"
    
    # Check the running configuration
    if [ "$l_krp" = "$l_kpvalue" ]; then
        l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
    else
        l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
    fi
    
    # Check durable settings from files
    check_durable_settings
}

# Function to check durable settings from files
check_durable_settings() {
    declare -A A_out
    while read -r l_out; do
        if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
                l_file="${l_out//# /}"
            else
                l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
                [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
        fi
    done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')

    # Account for systems with UFW
    if [ -n "$l_ufwscf" ]; then
        l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
        l_kpar="${l_kpar//\//.}"
        [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
    fi

    # Assess output from files and generate output
    assess_file_output
}

# Function to assess output from files
assess_file_output() {
    if (( ${#A_out[@]} > 0 )); then
        while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"
            l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
                l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
                l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
        done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
    else
        l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
    fi
}

# Loop through the parameter list and assess each
while IFS="=" read -r l_kpname l_kpvalue; do
    l_kpname="${l_kpname// /}"
    l_kpvalue="${l_kpvalue// /}"
    
    # Check if IPv6 is disabled
    if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
        l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
    else
        kernel_parameter_chk
    fi
done < <(printf '%s\n' "${a_parlist[@]}")

# Display audit result
if [ -z "$l_output2" ]; then
   additional_output="$l_output"
   result="Passed"


else
    [ -n "$l_output" ] 
   
    additional_output=$l_output2
    result="Failed"
    

 

fi

additional_output="${additional_output[*]:6:120}"


# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



title="3.3.3 Ensure bogus icmp responses are ignored (Automated)"

# Initialize variables
l_output=""
l_output2=""
a_parlist=("net.ipv4.icmp_ignore_bogus_error_responses=1")
l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"

# Function to check kernel parameters
kernel_parameter_chk() {
    l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)"
    
    # Check running configuration
    if [ "$l_krp" = "$l_kpvalue" ]; then
        l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
    else
        l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
    fi
    
    # Array to store durable settings
    declare -A A_out
    
    # Check durable setting (files)
    while read -r l_out; do
        if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
                l_file="${l_out//# /}"
            else
                l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
                [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
        fi
    done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
    
    # Check for UFW configurations
    if [ -n "$l_ufwscf" ]; then
        l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
        l_kpar="${l_kpar//\//.}"
        [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
    fi
    
    # Assess output from files and generate output
    if (( ${#A_out[@]} > 0 )); then
        while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"
            l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
                l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
                l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
        done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
    else
        l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
    fi
}

# Main script logic
while IFS="=" read -r l_kpname l_kpvalue; do
    l_kpname="${l_kpname// /}"
    l_kpvalue="${l_kpvalue// /}"
    
    # Check for IPv6 settings
    if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
        l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
    else
        kernel_parameter_chk
    fi
done < <(printf '%s\n' "${a_parlist[@]}")

# Provide audit result
if [ -z "$l_output2" ]; then
    additional_output="$l_output"
    result="Passed"




else
    [ -n "$l_output" ] 
    additional_output="$l_output2"
    result="Failed"

 

fi


additional_output="${additional_output[*]:6:120}"


# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"





title="3.3.4 Ensure broadcast icmp requests are ignored (Automated)"

# Initialize variables
l_output=""
l_output2=""
a_parlist=("net.ipv4.icmp_echo_ignore_broadcasts=1")
l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"

# Function to check kernel parameters
kernel_parameter_chk() {
    l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)"

    # Check running configuration
    if [ "$l_krp" = "$l_kpvalue" ]; then
        l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
    else
        l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
    fi

    unset A_out
    declare -A A_out

    # Check durable setting (files)
    while read -r l_out; do
        if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
                l_file="${l_out//# /}"
            else
                l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
                [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
        fi
    done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')

    # Account for systems with UFW
    if [ -n "$l_ufwscf" ]; then
        l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
        l_kpar="${l_kpar//\//.}"
        [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
    fi

    # Assess output from files and generate output
    if (( ${#A_out[@]} > 0 )); then
        while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"
            l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
                l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
                l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
        done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
    else
        l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
    fi
}

# Main script logic
while IFS="=" read -r l_kpname l_kpvalue; do
    l_kpname="${l_kpname// /}"
    l_kpvalue="${l_kpvalue// /}"

    if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
        l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
    else
        kernel_parameter_chk
    fi
done < <(printf '%s\n' "${a_parlist[@]}")

# Provide audit result
if [ -z "$l_output2" ]; then
    additional_output="$l_output"
    result="Passed"
 


else
    [ -n "$l_output" ] 
    additional_output="$l_output2"
    result="Failed"



fi



additional_output="${additional_output[*]:6:120}"


# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"





title="3.3.5 Ensure icmp redirects are not accepted (Automated)"

# Initialize variables
l_output=""
l_output2=""
a_parlist=("net.ipv4.conf.all.accept_redirects=0" "net.ipv4.conf.default.accept_redirects=0" "net.ipv6.conf.all.accept_redirects=0" "net.ipv6.conf.default.accept_redirects=0")
l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"

# Function to check kernel parameters
kernel_parameter_chk() {
    l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)"

    # Check running configuration
    if [ "$l_krp" = "$l_kpvalue" ]; then
        l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
    else
        l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
    fi

    # Array for durable settings
    unset A_out
    declare -A A_out

    # Check durable setting (files)
    while read -r l_out; do
        if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
                l_file="${l_out//# /}"
            else
                l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
                [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
        fi
    done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')

    # Account for systems with UFW
    if [ -n "$l_ufwscf" ]; then
        l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
        l_kpar="${l_kpar//\//.}"
        [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
    fi

    # Assess settings from files
    if (( ${#A_out[@]} > 0 )); then
        while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"
            l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
                l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
                l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
        done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
    else
        l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
    fi
}

# Main script logic
while IFS="=" read -r l_kpname l_kpvalue; do
    l_kpname="${l_kpname// /}"
    l_kpvalue="${l_kpvalue// /}"

    # Check for IPv6 settings
    if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
        l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
    else
        kernel_parameter_chk
    fi
done < <(printf '%s\n' "${a_parlist[@]}")

# Provide audit result
if [ -z "$l_output2" ]; then
    additional_output="$l_output"
    result="Passed"



else
    [ -n "$l_output" ] 

    additional_output="$l_output2"
    result="Failed"


fi


additional_output="${additional_output[*]:6:120}"


# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




title="3.3.6 Ensure secure icmp redirects are not accepted (Automated)"

# Initialize variables
l_output=""
l_output2=""
a_parlist=("net.ipv4.conf.all.secure_redirects=0" "net.ipv4.conf.default.secure_redirects=0")
l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"

# Function to check kernel parameters
kernel_parameter_chk() {
    l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)"

    # Check running configuration
    if [ "$l_krp" = "$l_kpvalue" ]; then
        l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
    else
        l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
    fi

    unset A_out; declare -A A_out

    # Check durable setting (files)
    while read -r l_out; do
        if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
                l_file="${l_out//# /}"
            else
                l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
                [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
        fi
    done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')

    if [ -n "$l_ufwscf" ]; then
        l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
        l_kpar="${l_kpar//\//.}"
        [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
    fi

    if (( ${#A_out[@]} > 0 )); then
        while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
                l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\""
            else
                l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\""
            fi
        done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
    else
        l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n * Note: \"$l_kpname\" May be set in a file that's ignored by load procedure *"
    fi
}

# Main script logic
while IFS="=" read -r l_kpname l_kpvalue; do
    l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
    if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
        l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
    else
        kernel_parameter_chk
    fi
done < <(printf '%s\n' "${a_parlist[@]}")

# Provide audit results
if [ -z "$l_output2" ]; then
   additional_output="$l_output" 
   result="Passed"

else
    [ -n "$l_output" ] 
    additional_output="$l_output2"
    result="Failed"
 


fi


additional_output="${additional_output[*]:6:120}"


# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"





title="3.3.7 Ensure reverse path filtering is enabled (Automated)"

# Initialize output variables
l_output=""
l_output2=""
a_parlist=("net.ipv4.conf.all.rp_filter=1" "net.ipv4.conf.default.rp_filter=1")
l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"

# Function to check kernel parameters
kernel_parameter_chk() {
    l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)"

    # Check running configuration
    if [ "$l_krp" = "$l_kpvalue" ]; then
        l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
    else
        l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
    fi

    unset A_out; declare -A A_out

    # Check durable settings in files
    while read -r l_out; do
        if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
                l_file="${l_out//# /}"
            else
                l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
                [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
        fi
    done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')

    # Check UFW configurations
    if [ -n "$l_ufwscf" ]; then
        l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
        l_kpar="${l_kpar//\//.}"
        [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
    fi

    # Assess output from files and generate output
    if (( ${#A_out[@]} > 0 )); then
        while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
                l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\""
            else
                l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\""
            fi
        done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
    else
        l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n * Note: \"$l_kpname\" may be set in a file that's ignored by the load procedure *"
    fi
}

# Main logic to assess parameters
while IFS="=" read -r l_kpname l_kpvalue; do
    l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
    if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
        l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
    else
        kernel_parameter_chk
    fi
done < <(printf '%s\n' "${a_parlist[@]}")

# Provide audit results
if [ -z "$l_output2" ]; then
    additional_output="$l_output"
    result="Passed"


else
    [ -n "$l_output" ] 
    
    additional_output="$l_output2"
    result="Failed"


fi

additional_output="${additional_output[*]:6:120}"

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




title="3.3.8 Ensure source routed packets are not accepted (Automated)"

l_output=""
l_output2=""
a_parlist=("net.ipv4.conf.all.accept_source_route=0" "net.ipv4.conf.default.accept_source_route=0" "net.ipv6.conf.all.accept_source_route=0" "net.ipv6.conf.default.accept_source_route=0")
l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"

kernel_parameter_chk() {
    l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)"
    
    if [ "$l_krp" = "$l_kpvalue" ]; then
        l_output+="\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
    else
        l_output2+="\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
    fi
    
    unset A_out
    declare -A A_out
    
    while read -r l_out; do
        if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
                l_file="${l_out//# /}"
            else
                l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
                [ "$l_kpar" = "$l_kpname" ] && A_out["$l_kpar"]="$l_file"
            fi
        fi
    done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
    
    if [ -n "$l_ufwscf" ]; then
        l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
        l_kpar="${l_kpar//\//.}"
        [ "$l_kpar" = "$l_kpname" ] && A_out["$l_kpar"]="$l_ufwscf"
    fi
    
    if (( ${#A_out[@]} > 0 )); then
        for key in "${!A_out[@]}"; do
            if [ "${A_out[$key]}" = "$l_kpvalue" ]; then
                l_output+="\n - \"$l_kpname\" is correctly set to \"$l_kpvalue\" in \"$key\""
            else
                l_output2+="\n - \"$l_kpname\" is incorrectly set to \"${A_out[$key]}\" in \"$key\" and should have a value of: \"$l_kpvalue\""
            fi
        done
    else
        l_output2+="\n - \"$l_kpname\" is not set in an included file\n * Note: \"$l_kpname\" May be set in a file that's ignored by load procedure *"
    fi
}

while IFS="=" read -r l_kpname l_kpvalue; do
    l_kpname="${l_kpname// /}"
    l_kpvalue="${l_kpvalue// /}"
    
    if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
        l_output+="\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"

    else
        kernel_parameter_chk
    fi
done < <(printf '%s\n' "${a_parlist[@]}")

if [ -z "$l_output2" ]; then
   additional_output="$l_output"
   result="Passed"


else
    [ -n "$l_output" ] 

     additional_output="$l_output2"
     result="Failed"



fi



additional_output="${additional_output[*]:6:120}"


# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"





title="3.3.9 Ensure suspicious packets are logged (Automated)"

l_output=""
l_output2=""
a_parlist=("net.ipv4.conf.all.log_martians=1" "net.ipv4.conf.default.log_martians=1")
l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"

kernel_parameter_chk() {
    l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)"
    
    if [ "$l_krp" = "$l_kpvalue" ]; then
        l_output+="\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
    else
        l_output2+="\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
    fi
    
    unset A_out
    declare -A A_out
    
    while read -r l_out; do
        if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
                l_file="${l_out//# /}"
            else
                l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
                [ "$l_kpar" = "$l_kpname" ] && A_out["$l_kpar"]="$l_file"
            fi
        fi
    done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
    
    if [ -n "$l_ufwscf" ]; then
        l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
        l_kpar="${l_kpar//\//.}"
        [ "$l_kpar" = "$l_kpname" ] && A_out["$l_kpar"]="$l_ufwscf"
    fi
    
    if (( ${#A_out[@]} > 0 )); then
        for key in "${!A_out[@]}"; do
            if [ "${A_out[$key]}" = "$l_kpvalue" ]; then
                l_output+="\n - \"$l_kpname\" is correctly set to \"$l_kpvalue\" in \"$key\""
            else
                l_output2+="\n - \"$l_kpname\" is incorrectly set to \"${A_out[$key]}\" in \"$key\" and should have a value of: \"$l_kpvalue\""
            fi
        done
    else
        l_output2+="\n - \"$l_kpname\" is not set in an included file\n * Note: \"$l_kpname\" May be set in a file that's ignored by load procedure *"
    fi
}

while IFS="=" read -r l_kpname l_kpvalue; do
    l_kpname="${l_kpname// /}"
    l_kpvalue="${l_kpvalue// /}"
    
    if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
        l_output+="\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
    else
        kernel_parameter_chk
    fi
done < <(printf '%s\n' "${a_parlist[@]}")

if [ -z "$l_output2" ]; then
    additional_output="$l_output"
    result="Passed" 


else
    [ -n "$l_output" ] 
     additional_output="$l_output2"
     result="Failed"

     

fi


additional_output="${additional_output[*]:6:120}"


# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



title="3.3.10 Ensure tcp syn cookies is enabled (Automated)"

l_output=""
l_output2=""

a_parlist=("net.ipv4.tcp_syncookies=1")

l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"

kernel_parameter_chk() {
    l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)"

    # Check running configuration
    if [ "$l_krp" = "$l_kpvalue" ]; then
        l_output+="\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
    else
        l_output2+="\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
    fi

    unset A_out
    declare -A A_out

    # Check durable setting (files)
    while read -r l_out; do
        if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
                l_file="${l_out//# /}"
            else
                l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
                [ "$l_kpar" = "$l_kpname" ] && A_out["$l_kpar"]="$l_file"
            fi
        fi
    done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')

    if [ -n "$l_ufwscf" ]; then
        l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
        l_kpar="${l_kpar//\//.}"
        [ "$l_kpar" = "$l_kpname" ] && A_out["$l_kpar"]="$l_ufwscf"
    fi

    if (( ${#A_out[@]} > 0 )); then
        for key in "${!A_out[@]}"; do
            value="${A_out[$key]}"
            if [ "$value" = "$l_kpvalue" ]; then
                l_output+="\n - \"$l_kpname\" is correctly set to \"$value\" in \"$key\""
            else
                l_output2+="\n - \"$l_kpname\" is incorrectly set to \"$value\" in \"$key\" and should have a value of: \"$l_kpvalue\""
            fi
        done
    else
        l_output2+="\n - \"$l_kpname\" is not set in an included file\n * Note: \"$l_kpname\" May be set in a file that's ignored by load procedure *"
    fi
}

while IFS="=" read -r l_kpname l_kpvalue; do
    l_kpname="${l_kpname// /}"
    l_kpvalue="${l_kpvalue// /}"

    if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
        l_output+="\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
    else
        kernel_parameter_chk
    fi
done < <(printf '%s\n' "${a_parlist[@]}")

if [ -z "$l_output2" ]; then
    additional_output="$l_output"
    result="Passed"    


else
    [ -n "$l_output" ] 

    additional_output="$l_output"
    result="Failed"


fi


additional_output="${additional_output[*]:6:120}"



# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"






title="3.3.11 Ensure ipv6 router advertisements are not accepted (Automated)"

l_output=""
l_output2=""
a_parlist=("net.ipv6.conf.all.accept_ra=0" "net.ipv6.conf.default.accept_ra=0")

l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"

kernel_parameter_chk() {
    l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)"

    # Check running configuration
    if [ "$l_krp" = "$l_kpvalue" ]; then
        l_output+="\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
    else
        l_output2+="\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
    fi

    unset A_out
    declare -A A_out

    # Check durable setting (files)
    while read -r l_out; do
        if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
                l_file="${l_out//# /}"
            else
                l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
                [ "$l_kpar" = "$l_kpname" ] && A_out["$l_kpar"]="$l_file"
            fi
        fi
    done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')

    if [ -n "$l_ufwscf" ]; then
        l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
        l_kpar="${l_kpar//\//.}"
        [ "$l_kpar" = "$l_kpname" ] && A_out["$l_kpar"]="$l_ufwscf"
    fi

    if (( ${#A_out[@]} > 0 )); then
        for key in "${!A_out[@]}"; do
            value="${A_out[$key]}"
            if [ "$value" = "$l_kpvalue" ]; then
                l_output+="\n - \"$l_kpname\" is correctly set to \"$value\" in \"$key\""
            else
                l_output2+="\n - \"$l_kpname\" is incorrectly set to \"$value\" in \"$key\" and should have a value of: \"$l_kpvalue\""
            fi
        done
    else
        l_output2+="\n - \"$l_kpname\" is not set in an included file\n * Note: \"$l_kpname\" May be set in a file that's ignored by load procedure *"
    fi
}

while IFS="=" read -r l_kpname l_kpvalue; do
    l_kpname="${l_kpname// /}"
    l_kpvalue="${l_kpvalue// /}"

    if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
        l_output+="\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
    else
        kernel_parameter_chk
    fi
done < <(printf '%s\n' "${a_parlist[@]}")

if [ -z "$l_output2" ]; then
    additional_output="$l_output"
    result="Passed"


else
    [ -n "$l_output" ] 
    additional_output="$l_output2"
    result="Failed"



fi

additional_output="${additional_output[*]:6:120}"

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




title="3.4.1.1 Ensure nftables is installed (Automated)"

# Check if nftables is installed
if command -v nft &> /dev/null; then
     
    additional_output="nftables is installed on the system."
    result="Passed"      

else

    additional_output="nftables is not installed on the system."
    result="Failed"


fi




# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



title="3.4.1.2 Ensure a single firewall configuration utility is in use (Automated)"


l_output=""
l_output2=""
l_fwd_status=""
l_nft_status=""
l_fwutil_status=""

# Determine FirewallD utility Status
rpm -q firewalld > /dev/null 2>&1 && l_fwd_status="$(systemctl is-enabled firewalld.service):$(systemctl is-active firewalld.service)"

# Determine NFTables utility Status
rpm -q nftables > /dev/null 2>&1 && l_nft_status="$(systemctl is-enabled nftables.service):$(systemctl is-active nftables.service)"

l_fwutil_status="$l_fwd_status:$l_nft_status"

case $l_fwutil_status in
    enabled:active:masked:inactive|enabled:active:disabled:inactive)
        l_output="\n - FirewallD utility is in use, enabled and active\n - NFTables utility is correctly disabled or masked and inactive"
        ;;
    masked:inactive:enabled:active|disabled:inactive:enabled:active)
        l_output="\n - NFTables utility is in use, enabled and active\n - FirewallD utility is correctly disabled or masked and inactive"
        ;;
    enabled:active:enabled:active)
        l_output2="\n - Both FirewallD and NFTables utilities are enabled and active"
        ;;
    enabled:*:enabled:*)
        l_output2="\n - Both FirewallD and NFTables utilities are enabled"
        ;;
    :active::active)
        l_output2="\n - Both FirewallD and NFTables utilities are enabled"
        ;;
    :enabled:active)
        l_output="\n - NFTables utility is in use, enabled, and active\n - FirewallD package is not installed"
        ;;
    :)
        l_output2="\n - Neither FirewallD nor NFTables is installed."
        ;;
    *:*:)
        l_output2="\n - NFTables package is not installed on the system"
        ;;
    *)
        l_output2="\n - Unable to determine firewall state"
        ;;
esac

if [ -z "$l_output2" ]; then
    additional_output="$l_output"
    result="Passed"


else
   
    result="Failed"


fi


additional_output="Firewall Utility is not configured"





# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"






title="3.4.2.1 Ensure nftables base chains exist (Automated)"

# Initialize output variables
l_output=""
l_output2=""

# Check for the existence of hooks in the nftables ruleset
if nft list ruleset | grep -q 'hook input'; then
    l_output+="\n - Base chain 'input' exists in the nftables ruleset"
else
    l_output2+="\n - Base chain 'input' does not exist in the nftables ruleset"
fi

if nft list ruleset | grep -q 'hook forward'; then
    l_output+="\n - Base chain 'forward' exists in the nftables ruleset"
else
    l_output2+="\n - Base chain 'forward' does not exist in the nftables ruleset"
fi

if nft list ruleset | grep -q 'hook output'; then
    l_output+="\n - Base chain 'output' exists in the nftables ruleset"
else
    l_output2+="\n - Base chain 'output' does not exist in the nftables ruleset"
fi

# Check and print the audit results
if [ -z "$l_output2" ]; then
    additional_output="$l_output"
    result="Passed"


else
    additional_output="$l_output2"
    result="Failed"


fi

additional_output="${additional_output[*]:5:105}"

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"





title="3.4.2.2 Ensure host based firewall loopback traffic is configured (Automated)"

l_output=""
l_output2=""

if nft list ruleset | awk '/hook\s+input\s+/,/\}\s*(#.*)?$/' | grep -Pq -- '\H+\h+"lo"\h+accept'; then
    l_output+="\n - Network traffic to the loopback address is correctly set to accept"
else
    l_output2+="\n - Network traffic to the loopback address is not set to accept"
fi

l_ipsaddr="$(nft list ruleset | awk '/filter_IN_public_deny|hook\s+input\s+/,/\}\s*(#.*)?$/' | grep -P -- 'ip\h+saddr')"

if grep -Pq -- 'ip\h+saddr\h+127\.0\.0\.0\/8\h+(counter\h+packets\h+\d+\h+bytes\h+\d+\h+)?drop' <<< "$l_ipsaddr" || grep -Pq -- 'ip\h+daddr\h+\!\=\h+127\.0\.0\.1\h+ip\h+saddr\h+127\.0\.0\.1\h+drop' <<< "$l_ipsaddr"; then
    l_output+="\n - IPv4 network traffic from loopback address correctly set to drop"
else
    l_output2+="\n - IPv4 network traffic from loopback address not set to drop"
fi

if grep -Pq -- '^\h*0\h*$' /sys/module/ipv6/parameters/disable; then
    l_ip6saddr="$(nft list ruleset | awk '/filter_IN_public_deny|hook input/,/}/' | grep 'ip6 saddr')"
    if grep -Pq 'ip6\h+saddr\h+::1\h+(counter\h+packets\h+\d+\h+bytes\h+\d+\h+)?drop' <<< "$l_ip6saddr" || grep -Pq -- 'ip6\h+daddr\h+\!=\h+::1\h+ip6\h+saddr\h+::1\h+drop' <<< "$l_ip6saddr"; then
        l_output+="\n - IPv6 network traffic from loopback address correctly set to drop"
    else
        l_output2+="\n - IPv6 network traffic from loopback address not set to drop"
    fi
fi

if [ -z "$l_output2" ]; then
    additional_output="$l_output"
    result="Passed"

else
     additional_output="$l_output2"
    result="Failed"



fi

additional_output="${additional_output[*]:6:120}"


# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"





title="3.4.2.3 Ensure firewalld drops unnecessary services and ports (Manual)"

# Check if firewalld service is enabled
if systemctl is-enabled firewalld.service | grep -q 'enabled'; then
    # Get the active zone
    active_zone=$(firewall-cmd --list-all | awk '/\(active\)/ { print $1 }')
    
    # List all rules for the active zone related to services and ports
    firewall-cmd --list-all --zone="$active_zone" | grep -P -- '^\h*(services:|ports:)'
    
    # Check the exit status of the last command to determine success or Failedure
    if [ $? -eq 0 ]; then
       
       additional_output="Firewalld is correctly configured to drop unnecessary services and ports."
       result="Passed"


    else
       additional_output="Firewalld is not correctly configured to drop unnecessary services and ports."
       result="Failed"
 

    fi
else
    additional_output="Firewalld service is not enabled."
    result="Failed"


fi



# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




title="3.4.2.4 Ensure nftables established connections are configured (Manual)"


# Check if nftables service is enabled
if systemctl is-enabled nftables.service | grep -q 'enabled'; then
    # List rules related to established connections in the input hook
    nft list ruleset | awk '/hook input/,/}/' | grep 'ct state'
    
    # Check the exit status of the last command to determine success or Failedure
    if [ $? -eq 0 ]; then
        additional_output="Nftables is correctly configured to handle established connections."
        result="Passed"

    else
       additional_output="Nftables is not correctly configured to handle established connections."
       result="Failed"

    fi
else
    additional_output="Nftables service is not enabled."
    result="Failed"


fi



# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



title="3.4.2.5 Ensure nftables default deny firewall policy (Automated)"

# Check if nftables service is enabled
if systemctl --quiet is-enabled nftables.service; then
    # Check the rules for the input hook to ensure it has a policy of drop
    input_result=$(nft list ruleset | grep 'hook input' | grep -v 'policy drop')
    
    # Check the rules for the forward hook to ensure it has a policy of drop
    forward_result=$(nft list ruleset | grep 'hook forward' | grep -v 'policy drop')
    
    # Determine the audit result based on the checks
    if [[ -z "$input_result" && -z "$forward_result" ]]; then
        additional_output="Nftables has a default deny policy for both input and forward hooks."
        result="Passed"

    else
        additional_output="Nftables does not have a default deny policy for either input or forward hooks."
        result="Failed"


    fi
else
    additional_output="Nftables service is not enabled."
    result="Failed"

fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
#     csv_filename="$timestamp.csv"
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
#     csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
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
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



#chapter 6 script 1
permission=$(stat -Lc 'Access: (%#a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/passwd)
title="6.1.1 Ensure permissions on /etc/passwd are configured (Automated)"

# Extract UID and GID values
uid=$(echo "$permission" | awk '{print $4}')
gid=$(echo "$permission" | awk '{print $6}')

if [[ $uid == "(0/root)" && $gid == "(0/root)" ]]; then
  result="Passed"
  additional_output="Permission on /etc/passwd is set correctly"
else
  result="Failed"
  additional_output="Permission on /etc/passwd: $permission"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




#chapter 6 script 2
permission=$(stat -Lc 'Access: (%#a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/passwd-)
title="6.1.2 Ensure permissions on /etc/passwd- are configured (Automated)"

# Extract UID and GID values
uid=$(echo "$permission" | awk '{print $4}')
gid=$(echo "$permission" | awk '{print $6}')

if [[ $uid == "(0/root)" && $gid == "(0/root)" ]]; then
  result="Passed"
  additional_output="Permission on /etc/passwd- is set correctly"
else
  result="Failed"
  additional_output="Permission on /etc/passwd-: $permission"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




# Chapter 6 Script 3

permission=$([ -e "/etc/security/opasswd" ] && stat -Lc '%n Access: (%#a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/security/opasswd)
title="6.1.3 Ensure permissions on /etc/opasswd are configured (Automated)"

# Extract UID and GID values
access1=$(echo "$permission" | awk '{print $3}')
uid=$(echo "$permission" | awk '{print $5}')
gid=$(echo "$permission" | awk '{print $7}')

if [[ $access1 == "(0600/-rw-------)" && $uid == "(0/root)" && $gid == "(0/root)" ]] || [ -z "$permission" ]; then
  result2="Passed"
  additional_output2="Permission on /etc/opasswd is set correctly"
else
  result2="Failed"
  additional_output2="Permission on /etc/opasswd: $permission"
fi

# Save the result and additional output to different variables
result_3_1="$result2"
additional_output_3_1="$additional_output2"

# Script 3.2
permission1=$([ -e "/etc/security/opasswd.old" ] && stat -Lc '%n Access: (%#a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/security/opasswd.old)

# Extract UID and GID values
access1=$(echo "$permission1" | awk '{print $3}')
uid1=$(echo "$permission1" | awk '{print $5}')
gid1=$(echo "$permission1" | awk '{print $7}')

if [[ $access1 == "(0600/-rw-------)" && $uid1 == "(0/root)" && $gid1 == "(0/root)" ]] || [ -z "$permission1" ]; then
  result1="Passed"
  additional_output1="Permission on /etc/opasswd.old is set correctly"
else
  result1="Failed"
  additional_output1="Permission on /etc/opasswd.old: $permission1"
fi

# Save the result and additional output to different variables
result_3_2="$result1"
additional_output_3_2="$additional_output1"

# Combine the results
if [[ $result_3_1 == "Passed" && $result_3_2 == "Passed" ]]; then
  result="Passed"
  additional_output="$additional_output_3_1 and $additional_output_3_2"
else
  result="Failed"
  additional_output="$additional_output_3_1 and $additional_output_3_2"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




#chapter 6 script 4
permission=$(stat -Lc 'Access: (%#a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/group)
title="6.1.4 Ensure permissions on /etc/group are configured (Automated)"

# Extract UID and GID values 
access1=$(echo "$permission" | awk '{print $2}')
uid=$(echo "$permission" | awk '{print $4}')
gid=$(echo "$permission" | awk '{print $6}')

if [[ $access1 == "(0644/-rw-r--r--)" && $uid == "(0/root)" && $gid == "(0/root)" ]] || [ -z "$permission" ]; then
  result="Passed"
  additional_output="Permission on /etc/group is configured correctly"
else
  result="Failed"
  additional_output="Permission on /etc/group is wrongly configured: $permission"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"





# Chapter 6 Script 5
permission1=$(stat -Lc 'Access: (%#a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/group-)
title="6.1.5 Ensure permissions on /etc/group- are configured (Automated)"

# Extract UID and GID values
access1=$(echo "$permission1" | awk '{print $2}')
uid1=$(echo "$permission1" | awk '{print $4}')
gid1=$(echo "$permission1" | awk '{print $6}')

if [[ $access1 == "(0644/-rw-r--r--)" && $uid1 == "(0/root)" && $gid1 == "(0/root)" ]] || [ -z "$permission1" ]; then
  result="Passed"
  additional_output="Permission on /etc/group- is configured correctly"
else
  result="failed"
  additional_output="Permission on /etc/group- is wrongly configured: $permission1"
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




#chapter 6 script 6
permission=$(stat -Lc 'Access: (%#a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/shadow)
title="6.1.6 Ensure permissions on /etc/shadow are configured (Automated)"

# Extract UID and GID values
access1=$(echo "$permission" | awk '{print $2}')
uid=$(echo "$permission" | awk '{print $4}')
gid=$(echo "$permission" | awk '{print $6}')

if [[ $access1 == "(0/----------)" && $uid == "(0/root)" && $gid == "(0/root)" ]] || [ -z "$permission" ]; then
  result="Passed"
  additional_output="Permission on /etc/shadow is configured correctly"
else
  result="Failed"
  additional_output="Permission on /etc/shadow is configured wrongly: $permission"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"





#chapter 6 script 7
permission=$(stat -Lc 'Access: (%#a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/shadow-)
title="6.1.7 Ensure permissions on /etc/shadow- are configured (Automated)"

# Extract UID and GID values
access1=$(echo "$permission" | awk '{print $2}')
uid=$(echo "$permission" | awk '{print $4}')
gid=$(echo "$permission" | awk '{print $6}')

if [[ $access1 == "(0/----------)" && $uid == "(0/root)" && $gid == "(0/root)" ]] || [ -z "$permission" ]; then
  result="Passed"
  additional_output="Permission on /etc/shadow- is configured correctly"
else
  result="Failed"
  additional_output="Permission on /etc/shadow- is configured wrongly: $permission"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




#chapter 6 script 8
permission=$(stat -Lc 'Access: (%#a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/gshadow)
title="6.1.8 Ensure permissions on /etc/gshadow are configured (Automated)"

# Extract UID and GID values
access1=$(echo "$permission" | awk '{print $2}')
uid=$(echo "$permission" | awk '{print $4}')
gid=$(echo "$permission" | awk '{print $6}')

if [[ $access1 == "(0/----------)" && $uid == "(0/root)" && $gid == "(0/root)" ]] || [ -z "$permission" ]; then
  result="Passed"
  additional_output="Permission on /etc/gshadow is configured correctly"
else
  result="Failed"
  additional_output="Permission on /etc/gshadow is configured wrongly: $permission"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



#chapter 6 script 9
permission=$(stat -Lc 'Access: (%#a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/gshadow-)
title="6.1.9 Ensure permissions on /etc/gshadow- are configured (Automated)"

# Extract UID and GID values
access1=$(echo "$permission" | awk '{print $2}')
uid=$(echo "$permission" | awk '{print $4}')
gid=$(echo "$permission" | awk '{print $6}')

if [[ $access1 == "(0/----------)" && $uid == "(0/root)" && $gid == "(0/root)" ]] || [ -z "$permission" ]; then
  result="Passed"
  additional_output="Permission on /etc/gshadow- is configured correctly"
else
  result="Failed"
  additional_output="Permission on /etc/gshadow is configured wrongly: $permission"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




#chapter 6 script 10
title="6.1.10 Ensure permissions on /etc/shells are configured (Automated)"
permission=$(stat -Lc 'Access: (%#a/%A) Uid: (%u/%U) Gid: (%g/%G)' /etc/shells)
# Extract UID and GID values
access1=$(echo "$permission" | awk '{print $2}')
uid=$(echo "$permission" | awk '{print $4}')
gid=$(echo "$permission" | awk '{print $6}')

if [[ $access1 == "(0644/-rw-r--r--)" && $uid == "(0/root)" && $gid == "(0/root)" ]] || [ -z "$permission" ]; then
  result="Passed"
  additional_output="Permission on /etc/shells is configured correctly"
else
  result="Failed"
  additional_output="Permission on /etc/shells is configured wrongly: $permission"
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



l_output=""
l_output2=""
l_smask='01000'
a_path=(); a_arr=(); a_file=(); a_dir=() # Initialize arrays

a_path=(! -path "/run/user/*" -a ! -path "/proc/*" -a ! -path "*/containerd/*" -a ! -path "*/kubelet/pods/*" -a ! -path "/sys/kernel/security/apparmor/*" -a ! -path "/snap/*" -a ! -path "/sys/fs/cgroup/memory/*" -a ! -path "/sys/fs/selinux/*")

while read -r l_bfs; do
    a_path+=( -a ! -path "$l_bfs"/* )
done < <(findmnt -Dkerno fstype,target | awk '$1 ~ /^\s*(nfs|proc|smb)/ {print $2}')

# Populate array with files that will possibly fail one of the audits
while IFS= read -r -d $'\0' l_file; do
    [ -e "$l_file" ] && a_arr+=("$(stat -Lc '%n^%#a' "$l_file")")
done < <(find / \( "${a_path[@]}" \) \( -type f -o -type d \) -perm -0002 -print0 2>/dev/null)

while IFS="^" read -r l_fname l_mode; do
    # Test files in the array
    [ -f "$l_fname" ] && a_file+=("$l_fname") # Add WR files
    if [ -d "$l_fname" ]; then
        # Add directories w/o sticky bit
        [ ! $(( $l_mode & $l_smask )) -gt 0 ] && a_dir+=("$l_fname")
    fi
done < <(printf '%s\n' "${a_arr[@]}")

if ! (( ${#a_file[@]} > 0 )); then
    l_output="$l_output\n - No world-writable files exist on the local filesystem."
else
    l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_file[@]}")\" world-writable files on the system.\n - The following is a list of world-writable files:\n$(printf '%s\n' "${a_file[@]}")\n - end of list\n"
fi

if ! (( ${#a_dir[@]} > 0 )); then
    l_output="$l_output\n - Sticky bit is set on world-writable directories on the local filesystem."
else
    l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_dir[@]}")\" world-writable directories without the sticky bit on the system.\n - The following is a list of world-writable directories without the sticky bit:\n$(printf '%s\n' "${a_dir[@]}")\n - end of list\n"
fi

unset a_path; unset a_arr; unset a_file; unset a_dir # Remove arrays

# If l_output2 is empty, we pass
if [ -z "$l_output2" ]; then
    result="Passed"
    additional_output="World-writable files and directories are secured"
else
    result="Failed"
    additional_output="World-writable files and directories are insecure: $l_output"
fi

title="6.1.11 Ensure world-writable files and directories are secured (Automated)"

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

# # chapter 6 script 11 come back to check again 
# {
#  l_output="" l_output2=""
#  l_smask='01000'
#  a_path=(); a_arr=(); a_file=(); a_dir=() # Initialize arrays
#  a_path=(! -path "/run/user/*" -a ! -path "/proc/*" -a ! -path "*/containerd/*" -a ! -path 
# "*/kubelet/pods/*" -a ! -path "/sys/kernel/security/apparmor/*" -a ! -path "/snap/*" -a ! -path 
# "/sys/fs/cgroup/memory/*" -a ! -path "/sys/fs/selinux/*")
#  while read -r l_bfs; do
#  a_path+=( -a ! -path ""$l_bfs"/*")
#  done < <(findmnt -Dkerno fstype,target | awk '$1 ~ /^\s*(nfs|proc|smb)/ {print $2}')
#  # Populate array with files that will possibly fail one of the audits
#  while IFS= read -r -d $'\0' l_file; do
#  [ -e "$l_file" ] && a_arr+=("$(stat -Lc '%n^%#a' "$l_file")")
#  done < <(find / \( "${a_path[@]}" \) \( -type f -o -type d \) -perm -0002 -print0 2>/dev/null)
#  while IFS="^" read -r l_fname l_mode; do # Test files in the array
#  [ -f "$l_fname" ] && a_file+=("$l_fname") # Add WR files
#  if [ -d "$l_fname" ]; then # Add directories w/o sticky bit
#  [ ! $(( $l_mode & $l_smask )) -gt 0 ] && a_dir+=("$l_fname")
#  fi
#  done < <(printf '%s\n' "${a_arr[@]}")
#  if ! (( ${#a_file[@]} > 0 )); then
#  l_output="$l_output\n - No world writable files exist on the local filesystem."
#  else
#  l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_file[@]}")\" World writable files 
# on the system.\n - The following is a list of World writable files:\n$(printf '%s\n' 
# "${a_file[@]}")\n - end of list\n"
#  fi
#  if ! (( ${#a_dir[@]} > 0 )); then
#  l_output="$l_output\n - Sticky bit is set on world writable directories on the local 
# filesystem."
#  else
#  l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_dir[@]}")\" World writable 
# directories without the sticky bit on the system.\n - The following is a list of World writable 
# directories without the sticky bit:\n$(printf '%s\n' "${a_dir[@]}")\n - end of list\n"
#  fi
#  unset a_path; unset a_arr; unset a_file; unset a_dir # Remove arrays
#  # If l_output2 is empty, we pass
#  if [ -z "$l_output2" ]; then
# result="Passed"
# additional_output="World writable files and directories are secured"
#  else
#  [ -n "$l_output" ]
# result="Failed"
# additional_output="World writable files and directories are insecured"

#  fi
# title=" 6.1.11 Ensure world writable files and directories are secured (Automated)"
# # Check if a custom CSV name is provided
# if [ -n "$1" ]; then
#     # Use the custom name if provided
#     csv_filename="$1"
# else
#     # Otherwise, use the timestamp
#     csv_filename="$timestamp.csv"
# fi

# echo "$title,$additional_output,$result" >> "$csv_filename"

# } 

# chapter 6 script 12 come back to check again need to remove the long text
# l_output=""
# l_output2=""
# a_path=(); a_arr=(); a_nouser=(); a_nogroup=() # Initialize arrays

# a_path=(! -path "/run/user/*" -a ! -path "/proc/*" -a ! -path "*/containerd/*" -a ! -path "*/kubelet/pods/*" -a ! -path "/sys/fs/cgroup/memory/*")

# while read -r l_bfs; do
#     a_path+=( -a ! -path "$l_bfs"/* )
# done < <(findmnt -Dkerno fstype,target | awk '$1 ~ /^\s*(nfs|proc|smb)/ {print $2}')

# while IFS= read -r -d $'\0' l_file; do
#     [ -e "$l_file" ] && a_arr+=("$(stat -Lc '%n^%U^%G' "$l_file")") && echo "Adding: $l_file"
# done < <(find / \( "${a_path[@]}" \) \( -type f -o -type d \) \( -nouser -o -nogroup \) -print0 2> /dev/null)

# while IFS="^" read -r l_fname l_user l_group; do
#     # Test files in the array
#     [ "$l_user" = "UNKNOWN" ] && a_nouser+=("$l_fname")
#     [ "$l_group" = "UNKNOWN" ] && a_nogroup+=("$l_fname")
# done <<< "$(printf '%s\n' "${a_arr[@]}")"

# if ! (( ${#a_nouser[@]} > 0 )); then
#     l_output="$l_output\n - No unowned files or directories exist on the local filesystem."
# else
#     l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_nouser[@]}")\" unowned files or directories on the system.\n - The following is a list of unowned files and/or directories:\n$(printf '%s\n' "${a_nouser[@]}")\n - end of list"
# fi

# if ! (( ${#a_nogroup[@]} > 0 )); then
#     l_output="$l_output\n - No ungrouped files or directories exist on the local filesystem."
# else
#     l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_nogroup[@]}")\" ungrouped files or directories on the system.\n - The following is a list of ungrouped files and/or directories:\n$(printf '%s\n' "${a_nogroup[@]}")\n - end of list"
# fi 

# unset a_path; unset a_arr ; unset a_nouser; unset a_nogroup # Remove arrays

# if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass
#     result="Passed"
#     additional_output="No unowned or ungrouped files or directories exist"
# else
#     result="Failed"
#     additional_output="There are unowned or ungrouped files or directories exist"
#     [ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output\n" 
# fi

# title="6.1.12 Ensure no unowned or ungrouped files or directories exist (Automated)"

# # Check if a custom CSV name is provided
# if [ -n "$1" ]; then
#     # Use the custom name if provided
#     csv_filename="$1"
# else
#     # Otherwise, use the timestamp
#     timestamp=$(date +"%Y-%m-%d_%H:%M:%S")
#     csv_filename="$timestamp.csv"
# fi

# echo "$title,$additional_output,$result" >> "$csv_filename"


# chapter 6 script 12 come back to check again need to remove the long text
{
 l_output="" l_output2=""
 a_path=(); a_arr=(); a_nouser=(); a_nogroup=() # Initialize arrays
 a_path=(! -path "/run/user/*" -a ! -path "/proc/*" -a ! -path "*/containerd/*" -a ! -path 
"*/kubelet/pods/*" -a ! -path "/sys/fs/cgroup/memory/*")
 while read -r l_bfs; do
 a_path+=( -a ! -path ""$l_bfs"/*")
 done < <(findmnt -Dkerno fstype,target | awk '$1 ~ /^\s*(nfs|proc|smb)/ {print $2}')
 while IFS= read -r -d $'\0' l_file; do
 [ -e "$l_file" ] && a_arr+=("$(stat -Lc '%n^%U^%G' "$l_file")") && echo "Adding: $l_file"
 done < <(find / \( "${a_path[@]}" \) \( -type f -o -type d \) \( -nouser -o -nogroup \) - print0 2> /dev/null)
 while IFS="^" read -r l_fname l_user l_group; do # Test files in the array
 [ "$l_user" = "UNKNOWN" ] && a_nouser+=("$l_fname")
 [ "$l_group" = "UNKNOWN" ] && a_nogroup+=("$l_fname")
 done <<< "$(printf '%s\n' "${a_arr[@]}")"
 if ! (( ${#a_nouser[@]} > 0 )); then
 l_output="$l_output\n - No unowned files or directories exist on the local filesystem."
 else
 l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_nouser[@]}")\" unowned files or 
directories on the system.\n - The following is a list of unowned files and/or 
directories:\n$(printf '%s\n' "${a_nouser[@]}")\n - end of list"
 fi
 if ! (( ${#a_nogroup[@]} > 0 )); then
 l_output="$l_output\n - No ungrouped files or directories exist on the local filesystem."
 else
 l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_nogroup[@]}")\" ungrouped files 
or directories on the system.\n - The following is a list of ungrouped files and/or 
directories:\n$(printf '%s\n' "${a_nogroup[@]}")\n - end of list"
 fi 
 unset a_path; unset a_arr ; unset a_nouser; unset a_nogroup # Remove arrays
 if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass
 result="Passed"
additional_output="No unowned or ungrouped files or directories exist"
 else
result="Failed"
additional_output="There is unowned or ungrouped files or directories exist"
 [ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output\n" 
 fi
title="6.1.12 Ensure no unowned or ungrouped files or directories exist (Automated)"
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


} 

# # chapter 6 script 13 
# {
# title="6.1.13 Ensure SUID and SGID files are reviewed (Manual)"
# echo "$title"
#  l_output="" l_output2=""
#  a_arr=(); a_suid=(); a_sgid=() # initialize arrays
#  # Populate array with files that will possibly fail one of the audits
#  while read -r l_mpname; do
#  while IFS= read -r -d $'\0' l_file; do
#  [ -e "$l_file" ] && a_arr+=("$(stat -Lc '%n^%#a' "$l_file")")
#  done < <(find "$l_mpname" -xdev -not -path "/run/user/*" -type f \( -
# perm -2000 -o -perm -4000 \) -print0)
#  done <<< "$(findmnt -Derno target)"
#  # Test files in the array
#  while IFS="^" read -r l_fname l_mode; do
#  if [ -f "$l_fname" ]; then
#  l_suid_mask="04000"; l_sgid_mask="02000"
#  [ $(( $l_mode & $l_suid_mask )) -gt 0 ] && a_suid+=("$l_fname")
#  [ $(( $l_mode & $l_sgid_mask )) -gt 0 ] && a_sgid+=("$l_fname")
#  fi
#  done <<< "$(printf '%s\n' "${a_arr[@]}")" 
#  if ! (( ${#a_suid[@]} > 0 )); then
#  l_output="$l_output\n - There are no SUID files exist on the system"
#  else
#  l_output2="$l_output2\n - List of \"$(printf '%s' "${#a_suid[@]}")\" 
# SUID executable files:\n$(printf '%s\n' "${a_suid[@]}")\n - end of list -\n"
#  fi
#  if ! (( ${#a_sgid[@]} > 0 )); then
#  l_output="$l_output\n - There are no SGID files exist on the system"
#  else
#  l_output2="$l_output2\n - List of \"$(printf '%s' "${#a_sgid[@]}")\" 
# SGID executable files:\n$(printf '%s\n' "${a_sgid[@]}")\n - end of list -\n"
#  fi
#  [ -n "$l_output2" ] && l_output2="$l_output2\n- Review the preceding 
# list(s) of SUID and/or SGID files to\n- ensure that no rogue programs have 
# been introduced onto the system.\n" 
#  unset a_arr; unset a_suid; unset a_sgid # Remove arrays
#  # If l_output2 is empty, Nothing to report
#  if [ -z "$l_output2" ]; then
#  echo -e "\n- Audit Result:\n$l_output\n"
#  else
#  echo -e "\n- Audit Result:\n$l_output2\n"
#  [ -n "$l_output" ] && echo -e "$l_output\n"
#  fi
# }






# #6.1.14 Audit system file permissions (Manual) haven do comeback later chapter 6 script 14
# echo "6.2.1 Ensure accounts in /etc/passwd use shadowed passwords (Automated)"
# script1=$(rpm -qf /bin/bash)
# script2=$(rpm -V bash-4.4.19-2.fc28.x86_64)
# script3=$(rpm -qi bash)

# echo "$script1"
# echo "$script2"
# echo "$script3"



# echo " "




# Check if Accounts in /etc/password use shadowed password is installed chapter 6 script 15
title="6.2.1 Ensure accounts in /etc/passwd use shadowed passwords (Automated)"
accountsuse=$(awk -F: '($2 != "x" ) { print $1 " is not set to shadowed passwords "}' /etc/passwd)
if [[ -z "$accountsuse" ]]; then
  result="Passed"
  additional_output="Accounts in /etc/passwd use shadowed passwords "
else
  result="Failed"
additional_output="Accounts in /etc/passwd do not use shadowed passwords "
fi

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


# Check if /etc/shadow password fields are not empty (Automated)chapter 6 script 16
accountsuse=$( awk -F: '($2 == "" ) { print $1 " does not have a password "}' /etc/shadow)
title="6.2.2 Ensure /etc/shadow password fields are not empty (Automated)"
if [[ -z "$accountsuse" ]]; then
  result="Passed"
  additional_output="Accounts in /etc/passwd password fields are not empty"
else
  result="Failed"
additional_output="Accounts in /etc/passwd password fields are empty "
fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"






#chapter 6 script 17
check=$(for i in $(cut -s -d: -f4 /etc/passwd | sort -u ); do
 grep -q -P "^.*?:[^:]*:$i:" /etc/group
 if [ $? -ne 0 ]; then
 echo "Group $i is referenced by /etc/passwd but does not exist in 
/etc/group"
 fi
done)
if [[ -z "$check" ]]; then
  result="Passed"
  additional_output="All groups in /etc/passwd exist in /etc/group"
else
  result="Failed"
additional_output="All groups in /etc/passwd do not exist in /etc/group"
fi
title="6.2.3 Ensure all groups in /etc/passwd exist in /etc/group  (Automated)"
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"





#chapter 6 script 18
check=$({
 while read -r l_count l_uid; do
 if [ "$l_count" -gt 1 ]; then
 echo -e "Duplicate UID: \"$l_uid\" Users: \"$(awk -F: '($3 == n) { 
print $1 }' n=$l_uid /etc/passwd | xargs)\""
 fi
 done < <(cut -f3 -d":" /etc/passwd | sort -n | uniq -c)
})
if [[ -z "$check" ]]; then
  result="Passed"
  additional_output="No duplicate UIDs exist"
else
  result="Failed"
additional_output="Duplicate UIDs exist"
fi
title="6.2.4 Ensure no duplicate UIDs exist (Automated)"
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"






#chapter 6 script 19
check=$({
 while read -r l_count l_gid; do
 if [ "$l_count" -gt 1 ]; then
 echo -e "Duplicate GID: \"$l_gid\" Groups: \"$(awk -F: '($3 == n) { 
print $1 }' n=$l_gid /etc/group | xargs)\""
 fi
 done < <(cut -f3 -d":" /etc/group | sort -n | uniq -c)
})
if [[ -z "$check" ]]; then
  result="Passed"
  additional_output="No duplicate GIDs exist"
else
  result="Failed"
additional_output="Duplicate GIDs exist"
fi
title="6.2.5 Ensure no duplicate GIDs exist (Automated)"
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"





#chapter 6 script 20
check=$({
 while read -r l_count l_user; do
 if [ "$l_count" -gt 1 ]; then
 echo -e "Duplicate User: \"$l_user\" Users: \"$(awk -F: '($1 == n) { 
print $1 }' n=$l_user /etc/passwd | xargs)\""
 fi
 done < <(cut -f1 -d":" /etc/passwd | sort -n | uniq -c)
})
if [[ -z "$check" ]]; then
  result="Passed"
  additional_output="No duplicate user names exist"
else
  result="Failed"
additional_output="Duplicate user names exist"
fi
title="6.2.6 Ensure no duplicate user names exist (Automated)"
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"






#chapter 6 script 21
check=$({
 while read -r l_count l_group; do
 if [ "$l_count" -gt 1 ]; then
 echo -e "Duplicate Group: \"$l_group\" Groups: \"$(awk -F: '($1 == 
n) { print $1 }' n=$l_group /etc/group | xargs)\""
 fi
 done < <(cut -f1 -d":" /etc/group | sort -n | uniq -c)
})
if [[ -z "$check" ]]; then
  result="Passed"
  additional_output="No duplicate group exist"
else
  result="Failed"
additional_output="Duplicate group exist"
fi
title="6.2.7 Ensure no duplicate group names exist (Automated)"
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



#chapter 6 script 22
{
 l_output2=""
 l_pmask="0022"
 l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )"
 l_root_path="$(sudo -Hiu root env | grep '^PATH' | cut -d= -f2)"
 unset a_path_loc && IFS=":" read -ra a_path_loc <<< "$l_root_path"
 grep -q "::" <<< "$l_root_path" && l_output2="$l_output2\n - root's path contains an empty directory (::)"
 grep -Pq ":\h*$" <<< "$l_root_path" && l_output2="$l_output2\n - root's path contains a trailing (:)"
 grep -Pq '(\h+|:)\.(:|\h*$)' <<< "$l_root_path" && l_output2="$l_output2\n - root's path contains the current working directory (.)"
 while read -r l_path; do
   if [ -d "$l_path" ]; then
     while read -r l_fmode l_fown; do
       [ "$l_fown" != "root" ] && l_output2="$l_output2\n - Directory: \"$l_path\" is owned by: \"$l_fown\" and should be owned by \"root\""
       [ $(( $l_fmode & $l_pmask )) -gt 0 ] && l_output2="$l_output2\n - Directory: \"$l_path\" is mode: \"$l_fmode\" and should be mode: \"$l_maxperm\" or more restrictive"
     done <<< "$(stat -Lc '%#a %U' "$l_path")"
   else
     l_output2="$l_output2\n - \"$l_path\" is not a directory"
   fi
 done <<< "$(printf "%s\n" "${a_path_loc[@]}")"

 if [ -z "$l_output2" ]; then
   result="passed"
   additional_output="Root's path is correctly configured"
 else
title="6.2.8 Ensure root path integrity (Automated)"
#reason=$(echo -e " :\n$l_output2\n")
result="Failed"
 additional_output="Root's path is not correctly configured.$reason"
    
   
 fi
# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"


}


#chapter 6 script 7
permission=$(awk -F: '($3 == 0) { print $1 }' /etc/passwd)
title="6.2.9 Ensure root is the only UID 0 account (Automated)"

# Extract UID and GID values

if [[ $permission == "root" ]]; then
  result="Passed"
  additional_output="Root is the only UID 0 account"
else
  result="Failed"
  additional_output="Root is not the only UID 0 account"
fi


# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"




# script last 2 

{
  l_output=""
  l_output2=""
  l_heout2=""
  l_hoout2=""
  l_haout2=""
  l_valid_shells="^($(awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' -))$"
  unset a_uarr && a_uarr=() # Clear and initialize array

  while read -r l_epu l_eph; do
    # Populate array with users and user home location
    a_uarr+=("$l_epu $l_eph")
  done <<< "$(awk -v pat="$l_valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd)"

  l_asize="${#a_uarr[@]}" # Here if we want to look at the number of users before proceeding
  [ "$l_asize" -gt "10000" ] && echo -e "\n ** INFO **\n - \"$l_asize\" Local interactive users found on the system\n - This may be a long-running check\n"

  while read -r l_user l_home; do
    if [ -d "$l_home" ]; then
      l_mask='0027'
      l_max="$(printf '%o' $((0777 & ~$l_mask)))"
      while read -r l_own l_mode; do
        [ "$l_user" != "$l_own" ] && l_hoout2="$l_hoout2\n - User: \"$l_user\" Home \"$l_home\" is owned by: \"$l_own\""
        if [ $(( $l_mode & $l_mask )) -gt 0 ]; then
          l_haout2="$l_haout2\n - User: \"$l_user\" Home \"$l_home\" is mode: \"$l_mode\" should be mode: \"$l_max\" or more restrictive"
        fi
      done <<< "$(stat -Lc '%U %#a' "$l_home")"
    else
      l_heout2="$l_heout2\n - User: \"$l_user\" Home \"$l_home\" Doesn't exist"
    fi
  done <<< "$(printf '%s\n' "${a_uarr[@]}")"

  [ -z "$l_heout2" ] && l_output="$l_output\n - home directories exist" || l_output2="$l_output2$l_heout2"
  [ -z "$l_hoout2" ] && l_output="$l_output\n - own their home directory" || l_output2="$l_output2$l_hoout2"
  [ -z "$l_haout2" ] && l_output="$l_output\n - home directories are mode: \"$l_max\" or more restrictive" || l_output2="$l_output2$l_haout2"
  [ -n "$l_output" ] && l_output=" - All local interactive users:$l_output"

  if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass
additional_output="Local interactive user home directories are configured correctly "
    result="Passed"

  else
    additional_output="Local interactive user home directories are not configured correctly "
    result="Failed"
  fi

title="6.2.10 Ensure local interactive user home directories are configured (Automated)"

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



}

#script last one
{

l_output=""
l_output2=""
l_output3=""
l_bf=""
l_df=""
l_nf=""
l_hf=""
l_valid_shells="^($(awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' -))$"
declare -a a_uarr=()

while read -r l_epu l_eph; do
    [[ -n "$l_epu" && -n "$l_eph" ]] && a_uarr+=("$l_epu $l_eph")
done <<<"$(awk -v pat="$l_valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd)"

l_asize="${#a_uarr[@]}"
l_maxsize="1000"

if [ "$l_asize" -gt "$l_maxsize" ]; then
    echo -e "\n ** INFO **\n - \"$l_asize\" Local interactive users found on the system\n - This may be a long-running check\n"
fi

file_access_chk() {
    l_facout2=""
    l_max="$(printf '%o' $((0777 & ~$l_mask)))"
    
    if [ $(( $l_mode & $l_mask )) -gt 0 ]; then
        l_facout2="$l_facout2\n - File: \"$l_hdfile\" is mode: \"$l_mode\" and should be mode: \"$l_max\" or more restrictive"
    fi
    
    if [[ ! "$l_owner" =~ ($l_user) ]]; then
        l_facout2="$l_facout2\n - File: \"$l_hdfile\" owned by: \"$l_owner\" and should be owned by \"${l_user//|/ or }\""
    fi
    
    if [[ ! "$l_gowner" =~ ($l_group) ]]; then
        l_facout2="$l_facout2\n - File: \"$l_hdfile\" group owned by: \"$l_gowner\" and should be group owned by \"${l_group//|/ or }\""
    fi
}

while read -r l_user l_home; do
    l_fe=""
    l_nout2=""
    l_nout3=""
    l_dfout2=""
    l_hdout2=""
    l_bhout2=""

    if [ -d "$l_home" ]; then
        l_group="$(id -gn "$l_user" | xargs)"
        l_group="${l_group// /|}"

        while IFS= read -r -d $'\0' l_hdfile; do
            while read -r l_mode l_owner l_gowner; do
                case "$(basename "$l_hdfile")" in
                    .forward | .rhost)
                        l_fe="Y" && l_bf="Y"
                        l_dfout2="$l_dfout2\n - File: \"$l_hdfile\" exists" ;;
                    .netrc)
                        l_mask='0177'
                        file_access_chk
                        if [ -n "$l_facout2" ]; then
                            l_fe="Y" && l_nf="Y"
                            l_nout2="$l_facout2"
                        else
                            l_nout3=" - File: \"$l_hdfile\" exists"
                        fi ;;
                    .bash_history)
                        l_mask='0177'
                        file_access_chk
                        if [ -n "$l_facout2" ]; then
                            l_fe="Y" && l_hf="Y"
                            l_bhout2="$l_facout2"
                        fi ;;
                    *)
                        l_mask='0133'
                        file_access_chk
                        if [ -n "$l_facout2" ]; then
                            l_fe="Y" && l_df="Y"
                            l_hdout2="$l_facout2"
                        fi ;;
                esac
            done <<<"$(stat -Lc '%#a %U %G' "$l_hdfile")"
        done < <(find "$l_home" -xdev -type f -name '.*' -print0)
    fi

    if [ "$l_fe" = "Y" ]; then
        l_output2="$l_output2\n - User: \"$l_user\" Home Directory: \"$l_home\""
        [ -n "$l_dfout2" ] && l_output2="$l_output2$l_dfout2"
        [ -n "$l_nout2" ] && l_output2="$l_output2$l_nout2"
        [ -n "$l_bhout2" ] && l_output2="$l_output2$l_bhout2"
        [ -n "$l_hdout2" ] && l_output2="$l_output2$l_hdout2"
    fi

    [ -n "$l_nout3" ] && l_output3="$l_output3\n - User: \"$l_user\" Home Directory: \"$l_home\"\n$l_nout3"
done <<<"$(printf '%s\n' "${a_uarr[@]}")"

unset a_uarr

[ -n "$l_output3" ] && l_output3=" - ** Warning **\n - \".netrc\" files should be removed unless deemed necessary\n and in accordance with local site policy:$l_output3"
[ -z "$l_bf" ] && l_output="$l_output\n - \".forward\" or \".rhost\" files"
[ -z "$l_nf" ] && l_output="$l_output\n - \".netrc\" files with incorrect access configured"
[ -z "$l_hf" ] && l_output="$l_output\n - \".bash_history\" files with incorrect access configured"
[ -z "$l_df" ] && l_output="$l_output\n - \"dot\" files with incorrect access configured"
[ -n "$l_output" ] && l_output=" - No local interactive users home directories contain:$l_output"

if [ -z "$l_output2" ]; then
    additional_output="Local interactive user dot files access is configured correctly "
    result="Passed"
else
    additional_output="Local interactive user dot files access is not configured correctly "
    result="Failed"
fi

title="6.2.11 Ensure local interactive user dot files access is configured (Automated)"

# Check if a custom CSV name is provided
if [ -n "$1" ]; then
    # Use the custom name if provided
    csv_filename="$1"
else
    # Otherwise, use the timestamp
    csv_filename="$timestamp.csv"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"



}





