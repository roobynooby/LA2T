#!/bin/bash
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
#     csv_filename="$timestamp"
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
#     csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
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
    csv_filename="$timestamp"
fi

echo "$title,$additional_output,$result" >> "$csv_filename"

