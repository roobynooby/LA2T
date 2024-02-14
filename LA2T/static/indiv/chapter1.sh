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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
        csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
#     csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
        csv_filename="$timestamp"
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
        csv_filename="$timestamp"
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
        csv_filename="$timestamp"
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
        csv_filename="$timestamp"
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
        csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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

    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
        csv_filename="$timestamp"
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
        csv_filename="$timestamp"
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
        csv_filename="$timestamp"
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
    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"
