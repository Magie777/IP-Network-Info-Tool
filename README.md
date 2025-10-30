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



# 7. Count Active (Established) Connections

Command: ss -tun | grep ESTAB | wc -l

Description: Filters only established connections and counts them.

