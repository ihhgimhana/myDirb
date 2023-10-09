#!/bin/bash

welcome(){
    # Welcome Window
    if command -v lolcat >/dev/null 2>&1; then
        figlet "My Dirb" | lolcat
        echo ""
        echo "My Dirb - Web Directory Search Tool"
        echo "Author : Hasa"
    else
        echo "My Dirb - Web Directory Search Tool"
    fi
}

# Function to check and install dependencies
check_dependencies() {
    if command -v gobuster >/dev/null 2>&1 && \
        command -v wordlists >/dev/null 2>&1 && \
       command -v figlet >/dev/null 2>&1 && \
       command -v lolcat >/dev/null 2>&1; then
        echo "Dependencies are already installed."
    else
        echo "Installing Dependencies................"
        echo "# Installing Gobuster...(2.5 MB)"
        sudo apt install gobuster -y >/dev/null 2>&1
        echo "# Installing wordlists...(53 MB)"
        sudo apt install wordlists -y >/dev/null 2>&1
        echo "# Installing Figlet...(0.2 MB)"
        sudo apt install figlet -y >/dev/null 2>&1
        echo "# Installing Lolcat...(0.01 MB)"
        sudo apt install lolcat -y >/dev/null 2>&1

        # Check installation status again after installation
        if command -v gobuster >/dev/null 2>&1 && \
            command -v wordlists >/dev/null 2>&1 && \
           command -v figlet >/dev/null 2>&1 && \
           command -v lolcat >/dev/null 2>&1; then
            echo "Dependencies installed successfully."
        else
            echo "Failed to install dependencies."
            exit 1
        fi
    fi
}

install() {
    if [ ! -f '/usr/bin/mydirb' ]; then
        sudo cp mydirb.sh /usr/bin/mydirb
        echo "My Dirb installed successfully."
    else
        echo ""
    fi
}

uninstall() {
    if [ -f '/usr/bin/mydirb' ]; then
        sudo rm /usr/bin/mydirb
        echo "My Dirb has been uninstalled."
    else
        echo "Nothing to uninstall."
    fi
}

# Check command-line arguments
if [ "$1" == "install" ]; then
    install
elif [ "$1" == "uninstall" ]; then
    uninstall
    exit
else
    echo ""
fi

# Function to get user inputs and process them
get_user_input() {
    echo ""
    echo -n "Enter URL: "
    read url
    echo -e "1. Normal \n2. Force \nOption :  \c"
    read select 

    # Check if the wordlist file exists
    if [ "$select" -eq "1" ] && [ -f '/usr/share/wordlists/dirbuster/directory-list-2.3-small.txt' ]; then
        gobuster dir -u "$url" -w '/usr/share/wordlists/dirbuster/directory-list-2.3-small.txt'
    elif [ "$select" -eq "2" ] && [ -f '/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt' ]; then
        gobuster dir -u "$url" -w '/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt'
    else
        echo "Error: Wordlist file not found."
    fi
}

# Main function
main() {
    # Welcome Window
    welcome

    # Check and install dependencies
    check_dependencies

    # Install
    install

    # Get user inputs and process them
    get_user_input
}

# Call the main function to start the script
main
