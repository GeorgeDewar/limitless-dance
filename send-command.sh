#!/bin/bash 

if [ -z "$1" ] ; then 
    echo "You must enter a parameter: "  
    echo "  e.g. $0 allon" 
    exit 1 
fi 

incmd="$1" 
ipaddress="192.168.0.100" 
portnum="8899"

allon="\x42\00\x55" 
alloff="\x41\00\x55" 

#note for disco commands these will impact the group you are currently in for example if you previously typed "./bashlight group2on" then 
#when you turn on disco it will only affect group 2, if you want disco to apply to all then type "./bashlight allon" first

discoon="\x4D\00\x55" 
discofaster="\x44\00\x55" 
discoslower="\x43\00\x55"
discomode="\x4D\00\x55"

group1on="\x45\00\x55"
group1off="\x46\00\x55"

group2on="\x47\00\x55"
group2off="\x48\00\x55"

group3on="\x49\00\x55"
group3off="\x4A\00\x55"

group4on="\x4B\00\x55"
group4off="\x4C\00\x55"

#Set all to white
allwhite="\xC2\00\x55"

#Set Group 1 to white
group1white="\xC5\00\x55"
group2white="\xC7\00\x55"
group3white="\xC9\00\x55"
group4white="\xCB\00\x55"

#Working (range: 2 to 27 need to work out Hexidecimal eg Hexidecimal 1B is Decimal 27
#note this will impact the group you are currently in for example if you previously typed "./bashlight group2on" then 
#when you adjust the brightness it will only affect group 2, if you want the brightness to apply to all groups then type "./bashlight allon" first

#Special NOTE #1: The LimitlessLED bulb remembers its own Brightness setting memory separately for ColorRGB and separately for White. 
#For example dimming Green, then switching to White full brightness, and when you go back to a specific color the brightness returns 
#to what the ColorRGB was before. Same vice versa for the White. The previous brightness setting is remembered specifically for the 
#White and specifically for the ColorRGB.

brightest="\x4E\x1B\x55"
lowest="\x4E\x02\x55"
half="\x4E\xd\x55"

#Colours

#    0x00 Violet
#    0x10 Royal_Blue
#    0x20 Baby_Blue
#    0x30 Aqua
#    0x40 Mint
#    0x50 Seafoam_Green
#    0x60 Green
#    0x70 Lime_Green
#    0x80 Yellow
#    0x90 Yellow_Orange
#    0xA0 Orange
#    0xB0 Red
#    0xC0 Pink
#    0xD0 Fusia
#    0xE0 Lilac
#    0xF0 Lavendar

# Note there are more colours (0-255) in between, this color chart is just steps of 16.
# and they are incrementing by 10 so example mint is 40 but you could use 41 42 43 44 45 etc for the in between colours

#First byte x40 says change colour , second byte is the colour that you want.

#Usage note when using these commands they will impact the current active group for example if you previously typed "./bashlight group2on" then 
#when you adjust the colour it will only affect group 2, if you want the colour to apply to all then type "./bashlight allon" first
#or if you wanted to make only group 1 red then type "./bashlight group1on" first then "./bashlight col_red"

col_violet="\x40\x00\x55"
col_royal_blue="\x40\x10\x55"
col_baby_blue="\x40\x20\x55"
col_aqua="\x40\x30\x55"
col_mint="\x40\x40\x55"
col_mint2="\x40\x45\x55"
col_seafoam_green="\x40\x50\x55"
col_green="\x40\x60\x55"
col_lime_green="\x40\x70\x55"
col_yellow="\x40\x80\x55"
col_yelloworange="\x40\x90\x55"
col_orange="\x40\xA0\x55"
col_red="\x40\xB0\x55"
col_pink="\x40\xC0\x55"
col_fusia="\x40\xD0\x55"
col_lilac="\x40\xE0\x55"
col_lavendar="\x40\xF0\x55"

eval incmd=\$$incmd 

echo -n -e "$incmd" >/dev/udp/"$ipaddress"/"$portnum"

