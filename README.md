# IP-Network-Info-Tool
The IP and Network Info Tool provides a clear view of your system’s networking setup by displaying IP addresses, active interfaces, and live connections. It helps monitor data flow, detect unusual network activity, and troubleshoot connectivity issues. Useful for both beginners and admins, it offers real-time insight into system communication.

# Features
1) Display current *system IP addresses*
2) List all *active network interfaces*
3) Show *top active network connections*
4) *Color-coded*, clean, and minimal CLI interface
5) Works on all *Linux distributions*

# Output Screen

<img width="1731" height="923" alt="image" src="https://github.com/user-attachments/assets/04e8e37f-9e99-4630-865e-3ccf27ffd5ef" />
<img width="1725" height="890" alt="image" src="https://github.com/user-attachments/assets/87d3fa18-f1aa-420e-9394-483dd49eb112" />



# Commands and Their Descriptions

# 1. Display IP Address

Command: hostname -I

Description: Shows all IP addresses assigned to your system.

Example Output: 192.168.1.5



# 2. Alternative Command for IP

Command: ip addr show

Description: Displays detailed information about all network interfaces, including IP addresses, MAC addresses, and interface states.



# 3. Display Network Interfaces

Command: ip link show

Description: Lists all network interfaces (like eth0, wlan0, lo) and shows whether each is active or inactive.



# 4. Alternative Command for Interfaces

Command: ifconfig

Description: Older command that displays information about each active network interface (IP, MAC, etc.).



# 5. Display Active Network Connections

Command: ss -tun

Description: Shows all current TCP (-t) and UDP (-u) connections.

You can add | wc -l to count the total number of active connections.



# 6. Alternative Command for Connections

Command: netstat -tun

Description: Older equivalent of ss that lists all active TCP/UDP connections.


# CODE



    #!/bin/bash

    RED="\e[31m"
    GREEN="\e[32m"
    YELLOW="\e[33m"
    CYAN="\e[36m"
    BOLD="\e[1m"
    RESET="\e[0m"


    professional_intro() {
    clear
    echo -e "${CYAN}${BOLD}Initializing IP AND NETWORK INFO TOOL...${RESET}"
    sleep 1
    echo -e "${YELLOW}Loading system modules...${RESET}"
    (for i in {1..20}; do sleep 0.1; done) &
    spinner $!
    echo -e " [${GREEN}Complete${RESET}]"
    sleep 0.5
        echo -e "${RED}${BOLD}    ██╗██████╗     █████╗ ███╗   ██╗██████╗     ███╗   ██╗███████╗████████╗██╗    ██╗  █ █████╗ ██████╗ ██╗  ██╗${RESET}"
        sleep 0.2
        echo -e "   ██║██╔══██╗    ██╔══██╗████╗  ██║██╔══██╗    ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝${RESET}"
        sleep 0.2
        echo -e "   ██║██████╔╝    ███████║██╔██╗ ██║██║  ██║    ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ${RESET}"
        sleep 0.2
        echo -e "   ██║██╔═══╝     ██╔══██║██║╚██╗██║██║  ██║    ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ${RESET}"
        sleep 0.2
        echo -e "   ██║██║         ██║  ██║██║ ╚████║██████╔╝    ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗${RESET}"
        sleep 0.2
        echo -e "   ╚═╝╚═╝         ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝     ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝${RESET}"
        sleep 0.2
        echo -e "${RED}${BOLD}   ██╗███╗   ██╗███████╗ ██████╗     ████████╗ ██████╗  ██████╗ ██╗     ${RESET}"
        sleep 0.2
        echo -e "   ██║████╗  ██║██╔════╝██╔═══██╗    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ${RESET}"
        sleep 0.2
        echo -e "   ██║██╔██╗ ██║█████╗  ██║   ██║       ██║   ██║   ██║██║   ██║██║     ${RESET}"
        sleep 0.2
        echo -e "   ██║██║╚██╗██║██╔══╝  ██║   ██║       ██║   ██║   ██║██║   ██║██║     ${RESET}"
        sleep 0.2
        echo -e "   ██║██║ ╚████║██║     ╚██████╔╝       ██║   ╚██████╔╝╚██████╔╝███████╗${RESET}"
        sleep 0.2
        echo -e "   ╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝        ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝${RESET}"
    sleep 1
    echo -e "${GREEN}System ready. Proceeding to diagnostics.${RESET}"
    sleep 1.5
    }

    header() {
    clear
    echo -e "${CYAN}┌─────────────────────────────────────────────────────────────────────────────┐${RESET}"
    sleep 0.1
    echo -e "${CYAN}│${BOLD}                       IP & NETWORK INFO TOOL                                ${RESET}${CYAN}│${RESET}"
    sleep 0.1
    echo -e "${CYAN}└─────────────────────────────────────────────────────────────────────────────┘${RESET}"
    sleep 0.1
    }

    progress_bar() {
    animated_progress_bar "${1:-2}"
    }

    show_ip() {
    header
    echo -e "${BOLD}${GREEN}System IP Addresses${RESET}"
    echo -e "${CYAN}───────────────────${RESET}"
    progress_bar 1
        local ips
        ips=$(ip addr show | awk '/inet / {print $2}' | grep -v '127.0.0.1')
        if [ -n "$ips" ]; then
            echo ""
            echo "$ips" | while read -r ip; do
                echo -e "  - ${CYAN}$ip${RESET}"
                sleep 0.1
            done
        else
            echo -e "${YELLOW}  No non-loopback IP addresses detected.${RESET}"
        fi
    echo ""
    }
    show_interfaces() {
    header
    echo -e "${BOLD}${GREEN}Network Interfaces${RESET}"
    echo -e "${CYAN}──────────────────${RESET}"
    progress_bar 1
        local interfaces
        interfaces=$(ip -brief addr show | awk 'BEGIN {print "Interface\tState\tAddress"} {print $1"\t"$2"\t"$3}')
        if [ -n "$interfaces" ]; then
            echo ""
            echo "$interfaces" | column -t -s $'\t' | while read -r line; do
                echo -e "  ${CYAN}$line${RESET}"
                sleep 0.1
            done
        else
            echo -e "${YELLOW}  No interfaces detected.${RESET}"
        fi
    echo ""
    }
    show_connections() {
    header
    echo -e "${BOLD}${GREEN}Active Network Connections${RESET}"
    echo -e "${CYAN}──────────────────────────${RESET}"
    progress_bar 1
    local cmd=""
        cmd="ss -tunp 2>/dev/null | awk 'NR>1 {print \$1\"\t\"\$4\"\t\"\$5\"\t\"\$6\"\t\"\$7}' | head -n 10"


    local connections
    connections=$(eval "$cmd")
    if [ -n "$connections" ]; then
        echo ""
        echo -e "  Proto\tLocal Address\t\tPeer Address\t\tState\tPID/Program"
        echo "$connections" | column -t -s $'\t' | while read -r line; do
            echo -e "  ${CYAN}$line${RESET}"
            sleep 0.1
        done
        echo -e "${YELLOW}  (Limited to 10 entries. Run as root for full details.)${RESET}"
    else
        echo -e "${YELLOW}  No active connections detected (or insufficient permissions).${RESET}"
    fi
    echo ""
    }
    save_to_txt() {
    local data_type="$1"
    local timestamp
    timestamp=$(date +"%Y%m%d_%H%M%S")
    local filename="network_report_${timestamp}.txt"
    echo -e "${YELLOW}Generating TXT report...${RESET}"
    (sleep 2) &
    spinner $!
    {
        echo "NETWORK DIAGNOSTICS REPORT"
        echo "==========================="
        echo "Report Type: $data_type"
        echo "Generated: $(date)"
        echo ""
        case "$data_type" in
            "IP")
                echo "SYSTEM IP ADDRESSES"
                echo "-------------------"
                ip addr show | awk '/inet / {print $2}' | grep -v '127.0.0.1' | sed 's/^/- /' ;;
            "Interfaces")
                echo "NETWORK INTERFACES"
                echo "------------------"
                ip -brief addr show ;;
            "Connections")
                echo "ACTIVE CONNECTIONS"
                echo "------------------"
                ss -tunp 2>/dev/null | head -n 10 ;;
            "All")
                echo "SYSTEM IP ADDRESSES"
                echo "-------------------"
                ip addr show | awk '/inet / {print $2}' | grep -v '127.0.0.1' | sed 's/^/- /'
                echo ""
                echo "NETWORK INTERFACES"
                echo "------------------"
                ip -brief addr show
                echo ""
                echo "ACTIVE CONNECTIONS"
                echo "------------------"
                ss -tunp 2>/dev/null | head -n 10 ;;
        esac
        echo ""
        echo "End of Report"
    } > "$filename"
    echo -e "${GREEN}Data saved to $filename${RESET}"
    }

    list_saved_files() {
    header
    echo -e "${BOLD}${GREEN}Saved Reports${RESET}"
    echo -e "${CYAN}─────────────${RESET}"
    local files
    files=$(ls -t network_report_*.txt network_report_*.pdf 2>/dev/null | head -n 5)
    if [ -n "$files" ]; then
        echo "$files" | nl -s ") "
    else
        echo -e "${YELLOW}No saved reports found.${RESET}"
    fi
    echo ""
    }
    menu() {
    local shown_desc=""
    while true; do
        header
        if [ -z "$shown_desc" ]; then
            echo ""
            echo -e "${BOLD}${CYAN}Description${RESET}"
            echo -e "${CYAN}───────────${RESET}"
            echo "This tool provides professional network diagnostics for your system."
            echo "View IP addresses, interfaces, and active connections."
            echo ""
            echo -e "${YELLOW}Example: IP: 192.168.1.5 | Interface: wlan0 | Connections: 4${RESET}"
            echo ""
            shown_desc=1
        fi

        echo -e "${BOLD}${CYAN}Options${RESET}"
        echo -e "${CYAN}───────${RESET}"
        echo "1) Show IP Addresses"
        echo "2) Show Network Interfaces"
        echo "3) Show Active Connections"
        echo "4) Refresh Data"
        echo "5) Save to TXT File"
        echo "6) View Saved Files"
        echo "7) Exit"
        echo ""
        # Blinking prompt
        echo -e -n "${BOLD}${CYAN}Select option [1-7]: ${RESET}"
        read -p "" choice
        echo ""

        case $choice in
            1) show_ip; read -p "Press Enter to continue..." ;;
            2) show_interfaces; read -p "Press Enter to continue..." ;;
            3) show_connections; read -p "Press Enter to continue..." ;;
            4) unset shown_desc ;;
            5)
                echo -e "${CYAN}Save type (IP/Interfaces/Connections/All): ${RESET}"
                read -p "" data_type
                save_to_txt "$data_type"
                sleep 2 ;;
            6) list_saved_files; read -p "Press Enter to continue..." ;;
            7)
                echo -e "${GREEN}Shutting down...${RESET}"
                sleep 1
                clear
                exit 0 ;;
            *) echo -e "${RED}Invalid option. Please select 1-7.${RESET}"; sleep 1 ;;
        esac
        done
       }

        professional_intro
        menu


