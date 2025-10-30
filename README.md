# IP-Network-Info-Tool
The IP and Network Info Tool provides a clear view of your system’s networking setup by displaying IP addresses, active interfaces, and live connections. It helps monitor data flow, detect unusual network activity, and troubleshoot connectivity issues. Useful for both beginners and admins, it offers real-time insight into system communication.

# Features
1) Display current *system IP addresses*
2) List all *active network interfaces*
3) Show *top active network connections*
4) *Color-coded*, clean, and minimal CLI interface
5) Works on all *Linux distributions*

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

 
    header(){    
    clear    
    echo -e "${CYAN}┌──────────────────────────────────────────────┐${RESET}"
    echo -e "${CYAN}│${BOLD}             IP & NETWORK INFO TOOL           ${RESET}${CYAN}│${RESET}"
    echo -e "${CYAN}└──────────────────────────────────────────────┘${RESET}"
    }
    
    show_ip(){
    header
    echo -e "${BOLD}${GREEN}System IP Address(es):${RESET}"
    echo ""
    ip addr show | awk '/inet / {print $2}' | grep -v '127.0.0.1' | sed 's/^/   → /'
    echo ""
    }
    
    show_interfaces() {
    header
    echo -e "${BOLD}${GREEN}Network Interfaces:${RESET}"
    echo ""
    ip -brief addr show | awk '{printf "   %-12s %-10s %s\n", $1, $2, $3}'
    echo ""}
    show_connections() {
    header
    echo -e "${BOLD}${GREEN}Active Network Connections:${RESET}"
    echo ""
    netstat -tunp 2>/dev/null | awk 'NR>2 {printf "   %-6s %-25s %-25s %-10s %s\n", $1, $4, $5, $6, $7}' | head -n 10
    echo ""
    }
    
    menu() {
    while true; do
    header
        if [ -z "$shown_desc" ]; then
            echo " "
            echo -e "${BOLD}${CYAN}Description:${RESET}"
            echo -e " "
            echo -e "This tool provides a quick network diagnostics and shows your system ’s"
            echo -e "current IP address, all active network interfaces, and open connections."
            echo ""
            echo -e "${CYAN}Example:${RESET}IP Address: 192.168.1.5 | Interface:wlan0 | Active Connections:4"
            echo ""
            shown_desc=1
            
        fi
        echo -e "${BOLD}${CYAN}Choose an option:${RESET}"
        echo ""
        echo -e "   1) Show IP Address"
        echo -e "   2) Show Network Interfaces"
        echo -e "   3) Show Active Connections"
        echo -e "   4) Exit"
        echo ""
        read -p "Enter your choice [1–4]: " choice
        echo ""
        case $choice in
            1) show_ip; read -p "Press Enter to return to menu..." ;;
            2) show_interfaces; read -p "Press Enter to return to menu..." ;;
            3) show_connections; read -p "Press Enter to return to menu..." ;;
            4) echo -e "${RED}Exiting...${RESET}"; sleep 0.5; clear; exit 0 ;;
            *) echo -e "${RED}Invalid choice! Please enter 1–4.${RESET}"; sleep 1 ;;
        esac
        done
        }
        menu


