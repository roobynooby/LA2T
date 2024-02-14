#!/bin/bash
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"
