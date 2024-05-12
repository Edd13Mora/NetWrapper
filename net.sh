#!/bin/bash

# Define the default output file name
output_file="netexec_report_$(date +%Y%m%d_%H%M%S).html"

# Function to display help menu
display_help() {
    echo "Usage: $0 [netexec options]"
    echo "This script is a wrapper for netexec that generates an HTML report."
    echo "All standard netexec options are supported as described in its help."
    exit 0
}

# Check for help option
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    display_help
fi

# Check if netexec is available in the PATH
if ! command -v netexec &> /dev/null; then
    echo "netexec could not be found, please ensure it is installed and in your PATH."
    exit 1
fi

# Execute Netexec Command with all provided arguments
netexec_output=$(netexec "$@" 2>&1)
exit_status=$?

# Check for successful execution of netexec
if [ $exit_status -ne 0 ]; then
    echo "Error running netexec: $netexec_output"
    exit $exit_status
fi

# Start generating HTML report
html_content="<html><head><title>Netexec Report</title>"
html_content+="<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css' rel='stylesheet'>"
html_content+="<link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css' rel='stylesheet'>"
html_content+="<style>"
html_content+="body { background-color: #f4f4f9; }"
html_content+=".container { margin-top: 20px; }"
html_content+=".protocol { color: #007bff; font-weight: bold; }"
html_content+=".header-violet { color: #8a2be2; }"
html_content+=".icon-success { color: green; }"
html_content+=".icon-warning { color: orange; }"
html_content+=".green-text { color: #28a745; font-weight: bold; }"  # Strong green color
html_content+=".red-text { color: #dc3545; font-weight: bold; }"    # Strong red color
html_content+="pre { background-color: #e9ecef; border-radius: 5px; padding: 20px; overflow-x: auto; }"
html_content+="</style>"
html_content+="</head><body><div class='container'>"
html_content+="<div class='card'>"
html_content+="<div class='card-header'>Netexec Report</div>"
html_content+="<div class='card-body'>"
html_content+="<h5 class='card-title'>Command Executed</h5>"
html_content+="<p class='card-text'><code>netexec $@</code></p>"
html_content+="<h5 class='card-title'>Output</h5>"
html_content+="<pre>"
# Replace symbols and apply color to protocol using alternative delimiters
netexec_output=$(echo "$netexec_output" | sed 's#\[\*\]#<i class="fas fa-check icon-success"></i>#g')  # Replace [*] with check icon
netexec_output=$(echo "$netexec_output" | sed 's#\[\+\]#<i class="fa fa-bolt icon-warning" aria-hidden="true"></i>#g')  # Replace [+] with orange bolt icon
netexec_output=$(echo "$netexec_output" | sed 's#SMB #<span class="protocol">SMB</span>#g')  # Highlight SMB
netexec_output=$(echo "$netexec_output" | sed 's#LDAP #<span class="protocol">LDAP</span>#g')  # Highlight SMB
netexec_output=$(echo "$netexec_output" | sed 's#FTP #<span class="protocol">FTP</span>#g')  # Highlight SMB
netexec_output=$(echo "$netexec_output" | sed 's#SSH #<span class="protocol">SSH</span>#g')  # Highlight SMB
netexec_output=$(echo "$netexec_output" | sed 's#WINRM #<span class="protocol">WINRM</span>#g')  # Highlight SMB
netexec_output=$(echo "$netexec_output" | sed 's#RDP #<span class="protocol">RDP</span>#g')  # Highlight SMB
netexec_output=$(echo "$netexec_output" | sed 's#MSSQL #<span class="protocol">MSSQL</span>#g')  # Highlight SMB
netexec_output=$(echo "$netexec_output" | sed 's#signing:True#<span class="green-text">signing:True</span>#g')  # Color "signing:True" in strong green
netexec_output=$(echo "$netexec_output" | sed 's#SMBv1:False#<span class="green-text">SMBv1:False</span>#g')  # Color "SMBv1:False" in strong green
netexec_output=$(echo "$netexec_output" | sed 's#signing:False#<span class="red-text">signing:False</span>#g')  # Color "signing:False" in strong red
netexec_output=$(echo "$netexec_output" | sed 's#SMBv1:True#<span class="red-text">SMBv1:True</span>#g')  # Color "SMBv1:True" in strong red
netexec_output=$(echo "$netexec_output" | sed 's#-Username-#<span class="header-violet">-Username-</span>#g')
netexec_output=$(echo "$netexec_output" | sed 's#-Last PW Set-#<span class="header-violet">-Last PW Set-</span>#g')
netexec_output=$(echo "$netexec_output" | sed 's#-BadPW-#<span class="header-violet">-BadPW-</span>#g')
netexec_output=$(echo "$netexec_output" | sed 's#-Description-#<span class="header-violet">-Description-</span>#g')
html_content+="$netexec_output"
html_content+="</pre>"
html_content+="</div></div></div>"
html_content+="</body></html>"

# Write HTML content to output file
echo "$html_content" > "$output_file"
echo "Report generated: $output_file"
