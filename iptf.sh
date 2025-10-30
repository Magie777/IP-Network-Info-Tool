#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
BOLD="\e[1m"
RESET="\e[0m"
header() {
    clear
    echo -e "${CYAN}┌──────────────────────────────────────────────┐${RESET}"
    echo -e "${CYAN}│${BOLD}             IP & NETWORK INFO TOOL           ${RESET}${CYAN}│${RESET}"
    echo -e "${CYAN}└──────────────────────────────────────────────┘${RESET}"
}
show_ip() {
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
    echo ""
}
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
